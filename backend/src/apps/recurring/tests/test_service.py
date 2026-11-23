from datetime import UTC, date, datetime, timedelta
from typing import Any

import pytest
from django.contrib.auth import get_user_model
from django.core.management import call_command

from apps.recurring.models import Occurrence
from apps.recurring.schedule import next_due
from apps.recurring.service import MAX_CATCH_UP, recurring_service
from apps.wallets.categories import category_service
from apps.wallets.ledger import ledger_service
from apps.wallets.services import wallets_service
from infrastructure.common.errors import ApiError

pytestmark = pytest.mark.django_db

# 1405/09/01 (a Sunday), 12:30 in Tehran
NOW = datetime(2026, 11, 22, 9, 0, tzinfo=UTC)
TODAY = date(2026, 11, 22)


def make_user(name: str = "zoe") -> Any:
    return get_user_model()._default_manager.create_user(username=name)


def wallet(user: Any, name: str = "a", balance: int = 1_000_000, currency: str = "IRT") -> Any:
    return wallets_service.create(
        user,
        name=name,
        kind="bank",
        currency=currency,
        bank="",
        opening_balance_minor=balance,
        client_mutation_id=f"w-{name}",
    )


def create(user: Any, w: Any, **overrides: Any) -> Any:
    fields: dict[str, Any] = {
        "wallet_id": w.id,
        "kind": "expense",
        "amount_minor": 100_000,
        "category_id": None,
        "note": "اجاره",
        "period": "monthly",
        "day": 15,
        "auto_confirm": False,
        "client_mutation_id": "r1",
        "now": NOW,
    } | overrides
    return recurring_service.create(user, **fields)


def balance(user: Any, name: str = "a") -> int:
    return next(w.balance_minor for w in wallets_service.list(user).wallets if w.name == name)


# --- the schedule ---------------------------------------------------------------


@pytest.mark.parametrize(
    ("period", "day", "frm", "expected"),
    [
        ("monthly", 15, date(2026, 11, 22), date(2026, 12, 6)),  # 1405/09/15
        ("monthly", 15, date(2026, 12, 6), date(2026, 12, 6)),  # the day itself counts
        ("monthly", 15, date(2026, 12, 7), date(2027, 1, 5)),  # next month 1405/10/15
        ("monthly", 31, date(2026, 11, 22), date(2026, 12, 21)),  # 1405/09 has 30: clamp
        ("monthly", 30, date(2027, 3, 1), date(2027, 3, 20)),  # Esfand 1405 has 29: clamp
        ("monthly", 1, date(2026, 11, 22), date(2026, 11, 22)),
        ("weekly", 0, date(2026, 11, 22), date(2026, 11, 23)),  # Sunday -> Monday
        ("weekly", 6, date(2026, 11, 22), date(2026, 11, 22)),
    ],
)
def test_next_due(period: str, day: int, frm: date, expected: date) -> None:
    assert next_due(period, day, frm) == expected


# --- creating --------------------------------------------------------------------


def test_create_sets_the_first_due_date() -> None:
    user = make_user()

    view = create(user, wallet(user))

    assert (view.next_due, view.currency, view.active) == (date(2026, 12, 6), "IRT", True)


def test_creating_twice_with_one_mutation_id_makes_one() -> None:
    user = make_user()
    w = wallet(user)

    first, again = create(user, w), create(user, w)

    assert first.id == again.id
    assert len(recurring_service.list(user, NOW).recurrings) == 1


@pytest.mark.parametrize(
    "bad",
    [
        {"day": 0},
        {"day": 32},
        {"period": "weekly", "day": 7},
        {"period": "yearly"},
        {"kind": "transfer"},
        {"amount_minor": -1},
        {"note": "x" * 201},
        {"client_mutation_id": ""},
        {"auto_confirm": True, "amount_minor": 0},  # variable amounts cannot auto-confirm
    ],
)
def test_invalid_definitions_are_refused(bad: dict[str, Any]) -> None:
    user = make_user()

    with pytest.raises(ApiError) as refusal:
        create(user, wallet(user), **bad)

    assert refusal.value.status == 400


def test_wallet_and_category_must_be_the_users_own() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    foreign_category = next(
        c for c in category_service.list(ali) if c.is_other and c.kind == "expense"
    )

    with pytest.raises(ApiError) as other_wallet:
        create(ali, wallet(zoe))
    with pytest.raises(ApiError) as other_category:
        create(zoe, wallet(zoe, "z2"), category_id=foreign_category.id)

    assert (other_wallet.value.status, other_category.value.status) == (404, 404)


def test_an_archived_wallet_is_refused() -> None:
    user = make_user()
    w = wallet(user)
    wallets_service.archive(user, w.id)

    with pytest.raises(ApiError) as refusal:
        create(user, w)

    assert refusal.value.status == 400


# --- generating occurrences ----------------------------------------------------


def test_occurrences_appear_only_inside_the_lead_window() -> None:
    user = make_user()
    create(user, wallet(user))  # due 1405/09/15 = 2026-12-06, 14 days away

    before = recurring_service.list(user, NOW).occurrences
    within = recurring_service.list(user, datetime(2026, 12, 3, 9, 0, tzinfo=UTC)).occurrences

    assert before == []
    assert [o.due_date for o in within] == [date(2026, 12, 6)]
    assert within[0].status == "upcoming"


def test_processing_twice_does_not_duplicate() -> None:
    user = make_user()
    create(user, wallet(user), day=1)

    recurring_service.process(user, NOW)
    recurring_service.process(user, NOW)

    assert Occurrence.objects.filter(user=user).count() == 1


def test_a_due_day_turns_an_occurrence_into_a_question() -> None:
    user = make_user()
    create(user, wallet(user), day=1)  # due today

    [occurrence] = recurring_service.list(user, NOW).occurrences

    assert (occurrence.due_date, occurrence.status) == (TODAY, "due")


def test_the_next_cycle_is_created_when_its_window_opens() -> None:
    user = make_user()
    create(user, wallet(user), day=1)
    recurring_service.process(user, NOW)

    later = datetime(2026, 12, 19, 9, 0, tzinfo=UTC)  # 1405/10/01 is 3 days away
    recurring_service.process(user, later)

    dates = sorted(Occurrence.objects.filter(user=user).values_list("due_date", flat=True))
    assert dates == [date(2026, 11, 22), date(2026, 12, 22)]


def test_a_long_absence_catches_up_with_a_cap() -> None:
    user = make_user()
    create(user, wallet(user), period="weekly", day=0)
    far_later = NOW + timedelta(days=365)

    recurring_service.process(user, far_later)

    assert Occurrence.objects.filter(user=user).count() == MAX_CATCH_UP


def test_a_paused_recurring_makes_no_occurrences() -> None:
    user = make_user()
    view = create(user, wallet(user), day=1)
    recurring_service.set_active(user, view.id, active=False)

    assert recurring_service.list(user, NOW).occurrences == []


def test_low_balance_is_flagged_before_the_due_date() -> None:
    user = make_user()
    create(user, wallet(user, balance=50_000), day=1, amount_minor=100_000)

    [low] = recurring_service.list(user, NOW).occurrences

    assert low.low_balance is True


def test_enough_balance_or_a_variable_amount_is_not_flagged() -> None:
    user = make_user()
    create(user, wallet(user, balance=500_000), day=1, amount_minor=100_000)
    create(user, wallet(user, "b", balance=0), day=1, amount_minor=0, client_mutation_id="r2")

    flags = {o.amount_minor: o.low_balance for o in recurring_service.list(user, NOW).occurrences}

    assert flags == {100_000: False, 0: False}


# --- answering the question ------------------------------------------------------


def due(user: Any, **overrides: Any) -> tuple[Any, Any]:
    w = wallet(user)
    create(user, w, day=1, **overrides)
    [occurrence] = recurring_service.list(user, NOW).occurrences
    return w, occurrence


def test_confirm_records_an_ordinary_expense_on_the_due_date() -> None:
    user = make_user()
    w, occurrence = due(user)

    recurring_service.resolve(user, occurrence.id, action="confirm", wallet_id=None, amount_minor=0)

    [entry] = ledger_service.list(user, wallet_id=None, limit=50)
    assert (entry.kind, entry.amount_minor, entry.wallet_id, entry.note) == (
        "expense",
        100_000,
        w.id,
        "اجاره",
    )
    assert entry.occurred_at.astimezone(UTC).date() == TODAY
    assert balance(user) == 900_000
    assert recurring_service.list(user, NOW).occurrences == []


def test_confirming_twice_is_refused_and_records_once() -> None:
    user = make_user()
    _, occurrence = due(user)
    recurring_service.resolve(user, occurrence.id, action="confirm", wallet_id=None, amount_minor=0)

    with pytest.raises(ApiError) as refusal:
        recurring_service.resolve(
            user, occurrence.id, action="confirm", wallet_id=None, amount_minor=0
        )

    assert refusal.value.status == 400
    assert balance(user) == 900_000


def test_another_wallet_of_the_same_currency_can_pay() -> None:
    user = make_user()
    _, occurrence = due(user)
    other = wallet(user, "b")

    recurring_service.resolve(
        user, occurrence.id, action="other_wallet", wallet_id=other.id, amount_minor=0
    )

    assert (balance(user, "a"), balance(user, "b")) == (1_000_000, 900_000)


def test_another_currency_or_a_missing_wallet_is_refused() -> None:
    user = make_user()
    _, occurrence = due(user)
    usd = wallet(user, "u", currency="USD")

    with pytest.raises(ApiError) as other_currency:
        recurring_service.resolve(
            user, occurrence.id, action="other_wallet", wallet_id=usd.id, amount_minor=0
        )
    with pytest.raises(ApiError) as missing:
        recurring_service.resolve(
            user, occurrence.id, action="other_wallet", wallet_id=None, amount_minor=0
        )

    assert (other_currency.value.status, missing.value.status) == (400, 400)


def test_cancel_skips_only_this_occurrence() -> None:
    user = make_user()
    _, occurrence = due(user)

    recurring_service.resolve(user, occurrence.id, action="cancel", wallet_id=None, amount_minor=0)

    assert ledger_service.list(user, wallet_id=None, limit=50) == []
    assert recurring_service.list(user, NOW).occurrences == []
    assert len(recurring_service.list(user, NOW).recurrings) == 1


def test_a_variable_amount_must_be_given_when_confirming() -> None:
    user = make_user()
    _, occurrence = due(user, amount_minor=0)

    with pytest.raises(ApiError) as missing:
        recurring_service.resolve(
            user, occurrence.id, action="confirm", wallet_id=None, amount_minor=0
        )
    recurring_service.resolve(
        user, occurrence.id, action="confirm", wallet_id=None, amount_minor=70_000
    )

    assert missing.value.status == 400
    assert balance(user) == 930_000


def test_an_unknown_action_is_refused() -> None:
    user = make_user()
    _, occurrence = due(user)

    with pytest.raises(ApiError) as refusal:
        recurring_service.resolve(
            user, occurrence.id, action="maybe", wallet_id=None, amount_minor=0
        )

    assert refusal.value.status == 400


def test_other_users_cannot_answer_or_see_it() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    _, occurrence = due(zoe)

    with pytest.raises(ApiError) as refusal:
        recurring_service.resolve(
            ali, occurrence.id, action="confirm", wallet_id=None, amount_minor=0
        )

    assert refusal.value.status == 404
    assert recurring_service.list(ali, NOW).recurrings == []


def test_an_income_recurring_records_an_income() -> None:
    user = make_user()
    w, occurrence = due(user, kind="income", amount_minor=2_000_000, note="حقوق")

    recurring_service.resolve(user, occurrence.id, action="confirm", wallet_id=None, amount_minor=0)

    assert balance(user) == 3_000_000 and w.id


# --- automatic confirmation ----------------------------------------------------


def test_auto_confirm_records_on_the_due_day_but_not_before() -> None:
    user = make_user()
    create(user, wallet(user), day=15, auto_confirm=True)  # due 2026-12-06

    recurring_service.process(user, datetime(2026, 12, 4, 9, 0, tzinfo=UTC))
    assert ledger_service.list(user, wallet_id=None, limit=50) == []
    recurring_service.process(user, datetime(2026, 12, 6, 9, 0, tzinfo=UTC))

    assert [e.amount_minor for e in ledger_service.list(user, wallet_id=None, limit=50)] == [
        100_000
    ]
    assert recurring_service.list(user, datetime(2026, 12, 6, 9, 0, tzinfo=UTC)).occurrences == []


def test_auto_confirm_does_not_double_record() -> None:
    user = make_user()
    create(user, wallet(user), day=1, auto_confirm=True)

    recurring_service.process(user, NOW)
    recurring_service.process(user, NOW)

    assert len(ledger_service.list(user, wallet_id=None, limit=50)) == 1


def test_auto_confirm_leaves_a_question_when_it_cannot_record() -> None:
    user = make_user()
    w = wallet(user)
    create(user, w, day=1, auto_confirm=True)
    wallets_service.archive(user, w.id)

    recurring_service.process(user, NOW)

    assert [o.status for o in recurring_service.list(user, NOW).occurrences] == ["due"]


# --- deleting and the command ------------------------------------------------------


def test_deleting_a_recurring_keeps_the_entries_it_made() -> None:
    user = make_user()
    view = create(user, wallet(user), day=1, auto_confirm=True)
    recurring_service.process(user, NOW)

    recurring_service.delete(user, view.id)

    assert recurring_service.list(user, NOW).recurrings == []
    assert len(ledger_service.list(user, wallet_id=None, limit=50)) == 1


def test_foreign_recurrings_cannot_be_paused_or_deleted() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    view = create(zoe, wallet(zoe))

    for call in (
        lambda: recurring_service.set_active(ali, view.id, active=False),
        lambda: recurring_service.delete(ali, view.id),
        lambda: recurring_service.delete(ali, "not-a-uuid"),
    ):
        with pytest.raises(ApiError) as refusal:
            call()
        assert refusal.value.status == 404


def test_the_command_processes_every_user(capsys: Any) -> None:
    from unittest.mock import patch

    zoe, ali = make_user("zoe"), make_user("ali")
    create(zoe, wallet(zoe), day=1, auto_confirm=True)
    create(ali, wallet(ali), day=1, auto_confirm=True)

    with patch("apps.recurring.management.commands.process_recurring.timezone.now") as clock:
        clock.return_value = NOW
        call_command("process_recurring")

    assert "2 user(s)" in capsys.readouterr().out
    assert len(ledger_service.list(zoe, wallet_id=None, limit=50)) == 1
    assert len(ledger_service.list(ali, wallet_id=None, limit=50)) == 1


# --- phase 07b: "not yet" and "I got it now" ------------------------------------


def test_not_yet_moves_the_question_to_tomorrow() -> None:
    user = make_user()
    _, occurrence = due(user, kind="income", amount_minor=2_000_000, note="حقوق")

    recurring_service.resolve(
        user, occurrence.id, action="postpone", wallet_id=None, amount_minor=0
    )
    today_view = recurring_service.list(user, NOW).occurrences
    tomorrow_view = recurring_service.list(user, NOW + timedelta(days=1)).occurrences

    assert [o.due_date for o in today_view] == [TODAY + timedelta(days=1)]
    assert [o.status for o in today_view] == ["upcoming"]
    assert [o.status for o in tomorrow_view] == ["due"]
    assert ledger_service.list(user, wallet_id=None, limit=50) == []


def test_postponing_keeps_the_same_question_and_can_repeat() -> None:
    user = make_user()
    _, occurrence = due(user)

    for _ in range(2):
        recurring_service.resolve(
            user, occurrence.id, action="postpone", wallet_id=None, amount_minor=0
        )

    [only] = recurring_service.list(user, NOW).occurrences
    assert only.id == occurrence.id and only.due_date == TODAY + timedelta(days=2)


def test_postponing_onto_the_next_cycle_is_refused() -> None:
    user = make_user()
    w = wallet(user)
    create(user, w, period="weekly", day=0)  # every Monday
    later = NOW + timedelta(days=1)  # Monday, due today
    [monday] = recurring_service.list(user, later).occurrences
    next_monday = recurring_service.list(user, later + timedelta(days=5)).occurrences

    assert monday.status == "due" and len(next_monday) == 2
    with pytest.raises(ApiError) as refusal:
        for _ in range(8):  # slide the first one into next Monday's date
            recurring_service.resolve(
                user, monday.id, action="postpone", wallet_id=None, amount_minor=0
            )

    assert refusal.value.status == 400


def test_an_answered_occurrence_cannot_be_postponed() -> None:
    user = make_user()
    _, occurrence = due(user)
    recurring_service.resolve(user, occurrence.id, action="cancel", wallet_id=None, amount_minor=0)

    with pytest.raises(ApiError) as refusal:
        recurring_service.resolve(
            user, occurrence.id, action="postpone", wallet_id=None, amount_minor=0
        )

    assert refusal.value.status == 400


def test_confirming_early_records_today_and_a_late_one_records_its_own_date() -> None:
    user = make_user()
    w = wallet(user)
    create(user, w, day=15, amount_minor=1_000)  # 2026-12-06
    create(user, w, day=1, amount_minor=2_000, client_mutation_id="r2")  # due 2026-11-22
    on_dec_4 = datetime(2026, 12, 4, 9, 0, tzinfo=UTC)
    by_amount = {o.amount_minor: o for o in recurring_service.list(user, on_dec_4).occurrences}

    recurring_service.resolve(
        user, by_amount[1_000].id, action="confirm", wallet_id=None, amount_minor=0, now=on_dec_4
    )
    recurring_service.resolve(
        user, by_amount[2_000].id, action="confirm", wallet_id=None, amount_minor=0, now=on_dec_4
    )

    dates = {
        e.amount_minor: e.occurred_at.astimezone(UTC).date()
        for e in ledger_service.list(user, wallet_id=None, limit=50)
    }
    assert dates == {1_000: date(2026, 12, 4), 2_000: date(2026, 11, 22)}


def test_settle_now_records_the_next_cycle_even_before_its_window() -> None:
    user = make_user()
    w = wallet(user)
    view = create(user, w, kind="income", amount_minor=5_000_000, note="حقوق", day=15)

    entry = recurring_service.settle_now(user, view.id, amount_minor=0, now=NOW)

    assert (entry.kind, entry.amount_minor) == ("income", 5_000_000)
    assert entry.occurred_at.astimezone(UTC).date() == TODAY  # early: today
    assert balance(user) == 6_000_000
    assert recurring_service.list(user, NOW).occurrences == []
    assert recurring_service.list(user, NOW).recurrings[0].next_due > date(2026, 12, 6)


def test_settle_now_uses_the_open_occurrence_when_there_is_one() -> None:
    user = make_user()
    _, occurrence = due(user, kind="income", amount_minor=300)

    recurring_service.settle_now(user, occurrence.recurring_id, amount_minor=0, now=NOW)

    assert Occurrence.objects.filter(user=user).count() == 1
    assert Occurrence.objects.get(user=user).status == Occurrence.CONFIRMED


def test_settle_now_needs_an_amount_for_a_variable_recurring() -> None:
    user = make_user()
    view = create(user, wallet(user), kind="income", amount_minor=0, day=15)

    with pytest.raises(ApiError) as missing:
        recurring_service.settle_now(user, view.id, amount_minor=0, now=NOW)
    entry = recurring_service.settle_now(user, view.id, amount_minor=77, now=NOW)

    assert missing.value.status == 400 and entry.amount_minor == 77


def test_settle_now_is_private() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    view = create(zoe, wallet(zoe))

    with pytest.raises(ApiError) as refusal:
        recurring_service.settle_now(ali, view.id, amount_minor=0, now=NOW)

    assert refusal.value.status == 404
