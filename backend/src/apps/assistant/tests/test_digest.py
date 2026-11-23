from datetime import UTC, datetime
from typing import Any

import pytest
from django.contrib.auth import get_user_model

from apps.assistant.digest import digest_service
from apps.recurring.service import recurring_service
from apps.wallets.categories import category_service
from apps.wallets.ledger import ledger_service
from apps.wallets.services import wallets_service
from infrastructure.common.errors import ApiError

pytestmark = pytest.mark.django_db

# 1405/09/01 at 20:30 Tehran; midnight Tehran is 20:30 UTC the evening before
EVENING = datetime(2026, 11, 22, 17, 0, tzinfo=UTC)
MORNING = datetime(2026, 11, 22, 4, 0, tzinfo=UTC)  # 07:30 Tehran


def make_user(name: str = "zoe") -> Any:
    return get_user_model()._default_manager.create_user(username=name)


def wallet(user: Any, balance: int = 1_000_000) -> Any:
    return wallets_service.create(
        user,
        name="a",
        kind="bank",
        currency="IRT",
        bank="",
        opening_balance_minor=balance,
        client_mutation_id="w",
    )


def spend(user: Any, w: Any, when: datetime, mutation: str, category: str | None = None) -> Any:
    return ledger_service.record(
        user,
        wallet_id=w.id,
        kind="expense",
        amount_minor=100,
        occurred_at=when,
        note="",
        client_mutation_id=mutation,
        category_id=category,
    )


def cat(user: Any, name: str) -> str:
    return next(c.id for c in category_service.list(user) if c.name == name)


def test_the_hour_is_stored_cleared_and_validated() -> None:
    user = make_user()

    assert digest_service.accounting_hour(user) == -1
    digest_service.set_accounting_hour(user, 20)
    assert digest_service.accounting_hour(user) == 20
    digest_service.set_accounting_hour(user, -1)
    assert digest_service.accounting_hour(user) == -1
    for bad in (24, -2, 100):
        with pytest.raises(ApiError) as refusal:
            digest_service.set_accounting_hour(user, bad)
        assert refusal.value.status == 400


def test_the_digest_counts_only_todays_tehran_entries() -> None:
    user = make_user()
    w = wallet(user)
    food = cat(user, "خوراک و سوپرمارکت")
    spend(user, w, datetime(2026, 11, 22, 8, 0, tzinfo=UTC), "today", food)
    spend(user, w, datetime(2026, 11, 22, 16, 0, tzinfo=UTC), "today-uncategorized")
    spend(
        user, w, datetime(2026, 11, 21, 15, 0, tzinfo=UTC), "yesterday-late", food
    )  # 18:30 Tehran
    gone = spend(user, w, datetime(2026, 11, 22, 9, 0, tzinfo=UTC), "deleted", food)
    ledger_service.delete(user, gone.id)

    digest = digest_service.digest(user, EVENING)

    assert (digest.entries_today, digest.uncategorized_today) == (2, 1)


def test_the_tehran_midnight_boundary_belongs_to_the_new_day() -> None:
    user = make_user()
    w = wallet(user)
    midnight = datetime(2026, 11, 21, 20, 30, tzinfo=UTC)  # 00:00 on 1405/09/01 in Tehran
    spend(user, w, midnight, "edge", cat(user, "خوراک و سوپرمارکت"))

    assert digest_service.digest(user, EVENING).entries_today == 1


def test_open_questions_and_low_balance_are_counted() -> None:
    user = make_user()
    w = wallet(user, balance=50)
    recurring_service.create(
        user,
        wallet_id=w.id,
        kind="expense",
        amount_minor=100_000,
        category_id=None,
        note="اجاره",
        period="monthly",
        day=1,
        auto_confirm=False,
        client_mutation_id="r",
        now=EVENING,
    )

    digest = digest_service.digest(user, EVENING)

    assert (digest.due_questions, digest.low_balance_warnings) == (1, 1)


@pytest.mark.parametrize(
    ("hour", "now", "expected"),
    [
        (20, EVENING, True),  # 20:30 >= 20, nothing recorded today
        (20, MORNING, False),  # 07:30 < 20
        (-1, EVENING, False),  # reminders off
    ],
)
def test_should_remind_follows_the_hour(hour: int, now: datetime, expected: bool) -> None:
    user = make_user()
    wallet(user)
    digest_service.set_accounting_hour(user, hour)

    assert digest_service.digest(user, now).should_remind is expected


def test_a_complete_day_needs_no_reminder() -> None:
    user = make_user()
    w = wallet(user)
    digest_service.set_accounting_hour(user, 20)
    spend(user, w, datetime(2026, 11, 22, 8, 0, tzinfo=UTC), "x", cat(user, "سلامت"))

    digest = digest_service.digest(user, EVENING)

    assert (digest.entries_today, digest.should_remind) == (1, False)


def test_an_uncategorized_entry_or_a_due_question_keeps_the_reminder() -> None:
    user = make_user()
    w = wallet(user)
    digest_service.set_accounting_hour(user, 20)
    spend(user, w, datetime(2026, 11, 22, 8, 0, tzinfo=UTC), "x")  # no category

    assert digest_service.digest(user, EVENING).should_remind is True


def test_users_do_not_share_anything() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    digest_service.set_accounting_hour(zoe, 9)
    spend(zoe, wallet(zoe), datetime(2026, 11, 22, 8, 0, tzinfo=UTC), "x")

    digest = digest_service.digest(ali, EVENING)

    assert (digest.accounting_hour, digest.entries_today, digest.should_remind) == (-1, 0, False)
