from datetime import UTC, date, datetime
from typing import Any

import pytest
from django.contrib.auth import get_user_model

from apps.debts.service import MAX_INSTALLMENTS, debt_service
from apps.wallets.categories import category_service
from apps.wallets.ledger import ledger_service
from apps.wallets.services import wallets_service
from infrastructure.common.errors import ApiError

pytestmark = pytest.mark.django_db

NOW = datetime(2026, 11, 22, 9, 0, tzinfo=UTC)  # 1405/09/01 12:30 Tehran
FIRST = date(2026, 12, 6)  # 1405/09/15


def make_user(name: str = "zoe") -> Any:
    return get_user_model()._default_manager.create_user(username=name)


def wallet(user: Any, name: str = "a", balance: int = 10_000_000, currency: str = "IRT") -> Any:
    return wallets_service.create(
        user,
        name=name,
        kind="bank",
        currency=currency,
        bank="",
        opening_balance_minor=balance,
        client_mutation_id=f"w-{name}",
    )


def create(user: Any, **overrides: Any) -> Any:
    fields: dict[str, Any] = {
        "kind": "bank_loan",
        "title": "وام مسکن",
        "currency": "IRT",
        "installment_minor": 1_000_000,
        "count": 12,
        "first_due": FIRST,
        "principal_minor": 0,
        "wallet_id": None,
        "category_id": None,
        "client_mutation_id": "d1",
        "now": NOW,
    } | overrides
    return debt_service.create(user, **fields)


def only_debt(user: Any, now: datetime = NOW) -> Any:
    [debt] = debt_service.list(user, now)
    return debt


def balance(user: Any, name: str = "a") -> int:
    return next(w.balance_minor for w in wallets_service.list(user).wallets if w.name == name)


# --- the schedule ---------------------------------------------------------------


def test_twelve_installments_fall_monthly_on_the_same_shamsi_day() -> None:
    user = make_user()

    debt = create(user)

    dates = [i.due_date for i in debt.installments]
    assert len(dates) == 12 and dates[0] == FIRST
    assert dates[1] == date(2027, 1, 5)  # 1405/10/15
    assert dates[-1] == date(2027, 11, 6)  # 1406/08/15
    assert [i.number for i in debt.installments] == list(range(1, 13))
    assert {i.amount_minor for i in debt.installments} == {1_000_000}


def test_a_day_a_short_month_lacks_falls_on_its_last_day() -> None:
    user = make_user()

    # 1405/06/31 (Shahrivar has 31 days); Mehr and Aban have 30, so the 31st clamps
    debt = create(user, first_due=date(2026, 9, 22), count=3)

    assert [i.due_date for i in debt.installments] == [
        date(2026, 9, 22),
        date(2026, 10, 22),  # 1405/07/30
        date(2026, 11, 21),  # 1405/08/30
    ]


def test_the_schedule_walks_through_esfand_and_the_new_year() -> None:
    user = make_user()
    # 1405/11/30 = 2027-02-19; Esfand has 29 days in 1405, so 1405/12/29, then 1406/01/30
    debt = create(user, first_due=date(2027, 2, 19), count=3)

    assert [i.due_date for i in debt.installments] == [
        date(2027, 2, 19),
        date(2027, 3, 20),  # 1405/12/29
        date(2027, 4, 19),  # 1406/01/30
    ]


def test_remaining_paid_count_and_next_due() -> None:
    user = make_user()
    debt = create(user, count=3)

    assert (debt.remaining_minor, debt.paid_count, debt.next_due) == (3_000_000, 0, FIRST)
    assert debt.closed is False and debt.currency == "IRT"


# --- validation -------------------------------------------------------------------


@pytest.mark.parametrize(
    "bad",
    [
        {"kind": "mortgage"},
        {"title": "  "},
        {"title": "x" * 61},
        {"installment_minor": 0},
        {"count": 0},
        {"count": MAX_INSTALLMENTS + 1},
        {"currency": "XXX"},
        {"principal_minor": -1},
        {"client_mutation_id": ""},
    ],
)
def test_invalid_debts_are_refused(bad: dict[str, Any]) -> None:
    with pytest.raises(ApiError) as refusal:
        create(make_user(), **bad)

    assert refusal.value.status == 400


def test_the_wallet_must_be_the_users_open_and_of_the_same_currency() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    mine, usd = wallet(zoe), wallet(zoe, "u", currency="USD")
    gone = wallet(zoe, "g")
    wallets_service.archive(zoe, gone.id)

    with pytest.raises(ApiError) as foreign:
        create(ali, wallet_id=mine.id)
    with pytest.raises(ApiError) as wrong_currency:
        create(zoe, wallet_id=usd.id, client_mutation_id="d2")
    with pytest.raises(ApiError) as archived:
        create(zoe, wallet_id=gone.id, client_mutation_id="d3")

    assert (foreign.value.status, wrong_currency.value.status, archived.value.status) == (
        404,
        400,
        400,
    )


def test_the_category_must_be_an_expense_category_of_the_user() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    salary = next(c.id for c in category_service.list(zoe) if c.name == "حقوق")
    foreign = next(c.id for c in category_service.list(ali) if c.is_other and c.kind == "expense")

    with pytest.raises(ApiError) as wrong_kind:
        create(zoe, category_id=salary)
    with pytest.raises(ApiError) as other_user:
        create(zoe, category_id=foreign, client_mutation_id="d2")

    assert (wrong_kind.value.status, other_user.value.status) == (400, 404)


def test_creating_twice_with_one_mutation_id_makes_one() -> None:
    user = make_user()

    first, again = create(user), create(user)

    assert first.id == again.id and len(debt_service.list(user, NOW)) == 1


# --- paying -----------------------------------------------------------------------


def test_paying_records_an_ordinary_expense_and_updates_the_debt() -> None:
    user = make_user()
    w = wallet(user)
    debt = create(user, wallet_id=w.id, count=3)

    entry = debt_service.pay(user, debt.installments[0].id, wallet_id=None, amount_minor=0, now=NOW)

    assert (entry.kind, entry.amount_minor, entry.wallet_id, entry.note) == (
        "expense",
        1_000_000,
        w.id,
        "وام مسکن (1/3)",
    )
    after = only_debt(user)
    assert (after.paid_count, after.remaining_minor, after.next_due) == (
        1,
        2_000_000,
        debt.installments[1].due_date,
    )
    assert balance(user) == 9_000_000


def test_another_wallet_or_a_different_amount_can_be_used() -> None:
    user = make_user()
    a, b = wallet(user, "a"), wallet(user, "b")
    debt = create(user, wallet_id=a.id)

    debt_service.pay(user, debt.installments[0].id, wallet_id=b.id, amount_minor=750_000, now=NOW)

    assert (balance(user, "a"), balance(user, "b")) == (10_000_000, 9_250_000)


def test_without_any_wallet_a_payment_needs_one() -> None:
    user = make_user()
    debt = create(user)

    with pytest.raises(ApiError) as refusal:
        debt_service.pay(user, debt.installments[0].id, wallet_id=None, amount_minor=0, now=NOW)

    assert refusal.value.status == 400


def test_paying_from_another_currency_or_an_archived_wallet_is_refused() -> None:
    user = make_user()
    w = wallet(user)
    usd = wallet(user, "u", currency="USD")
    debt = create(user, wallet_id=w.id)
    wallets_service.archive(user, w.id)

    with pytest.raises(ApiError) as wrong_currency:
        debt_service.pay(user, debt.installments[0].id, wallet_id=usd.id, amount_minor=0, now=NOW)
    with pytest.raises(ApiError) as archived:
        debt_service.pay(user, debt.installments[0].id, wallet_id=None, amount_minor=0, now=NOW)

    assert (wrong_currency.value.status, archived.value.status) == (400, 400)


def test_paying_twice_is_refused_and_records_once() -> None:
    user = make_user()
    debt = create(user, wallet_id=wallet(user).id)
    debt_service.pay(user, debt.installments[0].id, wallet_id=None, amount_minor=0, now=NOW)

    with pytest.raises(ApiError) as refusal:
        debt_service.pay(user, debt.installments[0].id, wallet_id=None, amount_minor=0, now=NOW)

    assert refusal.value.status == 400
    assert len(ledger_service.list(user, wallet_id=None, limit=50)) == 1


def test_paying_the_last_installment_closes_the_debt() -> None:
    user = make_user()
    debt = create(user, wallet_id=wallet(user).id, count=2)

    for installment in debt.installments:
        debt_service.pay(user, installment.id, wallet_id=None, amount_minor=0, now=NOW)

    closed = only_debt(user)
    assert (closed.closed, closed.remaining_minor, closed.next_due) == (True, 0, None)


def test_the_debts_category_goes_on_the_expense() -> None:
    user = make_user()
    installments = next(c.id for c in category_service.list(user) if c.name == "اقساط")
    debt = create(user, wallet_id=wallet(user).id, category_id=installments)

    entry = debt_service.pay(user, debt.installments[0].id, wallet_id=None, amount_minor=0, now=NOW)

    assert entry.category_id == installments


def test_unpay_deletes_the_expense_and_reopens_the_installment() -> None:
    user = make_user()
    debt = create(user, wallet_id=wallet(user).id, count=2)
    for installment in debt.installments:
        debt_service.pay(user, installment.id, wallet_id=None, amount_minor=0, now=NOW)

    debt_service.unpay(user, debt.installments[1].id)

    reopened = only_debt(user)
    assert (reopened.closed, reopened.paid_count, reopened.remaining_minor) == (False, 1, 1_000_000)
    assert balance(user) == 9_000_000
    assert len(ledger_service.list(user, wallet_id=None, limit=50)) == 1
    # and it can be paid again
    debt_service.pay(user, debt.installments[1].id, wallet_id=None, amount_minor=0, now=NOW)
    assert balance(user) == 8_000_000


def test_unpaying_an_unpaid_installment_is_refused() -> None:
    user = make_user()
    debt = create(user)

    with pytest.raises(ApiError) as refusal:
        debt_service.unpay(user, debt.installments[0].id)

    assert refusal.value.status == 400


def test_unpay_still_works_if_the_expense_was_deleted_by_hand() -> None:
    user = make_user()
    debt = create(user, wallet_id=wallet(user).id)
    entry = debt_service.pay(user, debt.installments[0].id, wallet_id=None, amount_minor=0, now=NOW)
    ledger_service.delete(user, entry.id)

    debt_service.unpay(user, debt.installments[0].id)

    assert only_debt(user).paid_count == 0


# --- overdue, privacy, deleting -----------------------------------------------------


def test_an_unpaid_installment_is_overdue_only_after_its_day() -> None:
    user = make_user()
    create(user)

    on_the_day = only_debt(user, datetime(2026, 12, 6, 9, 0, tzinfo=UTC))
    next_day = only_debt(user, datetime(2026, 12, 7, 9, 0, tzinfo=UTC))
    before = only_debt(user)

    assert [i.overdue for i in on_the_day.installments[:2]] == [False, False]
    assert [i.overdue for i in next_day.installments[:2]] == [True, False]
    assert not any(i.overdue for i in before.installments)


def test_a_paid_installment_is_never_overdue() -> None:
    user = make_user()
    debt = create(user, wallet_id=wallet(user).id)
    debt_service.pay(user, debt.installments[0].id, wallet_id=None, amount_minor=0, now=NOW)

    later = only_debt(user, datetime(2027, 1, 10, tzinfo=UTC))

    assert later.installments[0].overdue is False and later.installments[1].overdue is True


def test_other_users_see_and_touch_nothing() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    debt = create(zoe, wallet_id=wallet(zoe).id)

    assert debt_service.list(ali, NOW) == []
    for call in (
        lambda: debt_service.pay(
            ali, debt.installments[0].id, wallet_id=None, amount_minor=0, now=NOW
        ),
        lambda: debt_service.unpay(ali, debt.installments[0].id),
        lambda: debt_service.delete(ali, debt.id),
        lambda: debt_service.delete(ali, "not-a-uuid"),
    ):
        with pytest.raises(ApiError) as refusal:
            call()
        assert refusal.value.status == 404


def test_deleting_a_debt_keeps_the_payments_it_made() -> None:
    user = make_user()
    debt = create(user, wallet_id=wallet(user).id)
    debt_service.pay(user, debt.installments[0].id, wallet_id=None, amount_minor=0, now=NOW)

    debt_service.delete(user, debt.id)

    assert debt_service.list(user, NOW) == []
    assert len(ledger_service.list(user, wallet_id=None, limit=50)) == 1
