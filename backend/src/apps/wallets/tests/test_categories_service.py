from datetime import UTC, datetime
from typing import Any

import pytest
from django.contrib.auth import get_user_model

from apps.wallets.categories import category_service
from apps.wallets.ledger import ledger_service
from apps.wallets.profile import DEFAULT_CATEGORIES
from apps.wallets.services import wallets_service
from apps.wallets.transfers import transfer_service
from infrastructure.common.errors import ApiError

pytestmark = pytest.mark.django_db

NOV = (datetime(2026, 11, 1, tzinfo=UTC), datetime(2026, 12, 1, tzinfo=UTC))


def make_user(name: str = "zoe") -> Any:
    return get_user_model()._default_manager.create_user(username=name)


def wallet(user: Any, mutation: str = "w1", currency: str = "IRT") -> Any:
    return wallets_service.create(
        user,
        name=mutation,
        kind="bank",
        currency=currency,
        bank="",
        opening_balance_minor=1_000_000,
        client_mutation_id=mutation,
    )


def cat(user: Any, name: str, kind: str = "expense") -> Any:
    return next(c for c in category_service.list(user) if c.name == name and c.kind == kind)


def spend(user: Any, w: Any, category: Any, amount: int, mutation: str, **kw: Any) -> Any:
    return ledger_service.record(
        user,
        wallet_id=w.id,
        kind=kw.pop("kind", "expense"),
        amount_minor=amount,
        occurred_at=kw.pop("occurred_at", datetime(2026, 11, 10, tzinfo=UTC)),
        note="",
        client_mutation_id=mutation,
        category_id=category.id if category else None,
    )


def test_a_new_user_gets_the_defaults_once() -> None:
    user = make_user()

    first = category_service.list(user)
    again = category_service.list(user)

    expected = sum(len(names) for names in DEFAULT_CATEGORIES.values())
    assert len(first) == expected == len(again)
    assert {c.kind for c in first} == {"expense", "income"}
    assert sum(c.is_other for c in first) == 2


def test_users_do_not_share_categories() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    category_service.create(zoe, name="سفر", kind="expense")

    assert "سفر" not in {c.name for c in category_service.list(ali)}


@pytest.mark.parametrize(
    "bad",
    [{"name": "  "}, {"name": "x" * 41}, {"kind": "transfer"}, {"name": "خوراک و سوپرمارکت"}],
)
def test_invalid_categories_are_refused(bad: dict[str, Any]) -> None:
    user = make_user()
    category_service.list(user)

    with pytest.raises(ApiError) as refusal:
        category_service.create(user, **({"name": "سفر", "kind": "expense"} | bad))

    assert refusal.value.status == 400


def test_an_entry_takes_a_category_and_shows_it() -> None:
    user = make_user()
    w = wallet(user)
    food = cat(user, "خوراک و سوپرمارکت")

    entry = spend(user, w, food, 100, "e1")

    assert entry.category_id == food.id
    assert ledger_service.list(user, wallet_id=None, limit=50)[0].category_id == food.id


def test_a_category_of_the_wrong_kind_or_owner_is_refused() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    w = wallet(zoe)
    salary = cat(zoe, "حقوق", "income")
    other_users = cat(ali, "سایر")

    with pytest.raises(ApiError) as wrong_kind:
        spend(zoe, w, salary, 5, "e1")
    with pytest.raises(ApiError) as foreign:
        spend(zoe, w, other_users, 5, "e2")

    assert (wrong_kind.value.status, foreign.value.status) == (400, 404)


def test_edit_can_change_or_keep_the_category() -> None:
    user = make_user()
    w = wallet(user)
    food, fun = cat(user, "خوراک و سوپرمارکت"), cat(user, "تفریح و اشتراک")
    entry = spend(user, w, food, 100, "e1")

    kept = ledger_service.edit(user, entry.id, amount_minor=90, occurred_at=None, note="")
    moved = ledger_service.edit(
        user, kept.id, amount_minor=90, occurred_at=None, note="", category_id=fun.id
    )

    assert (kept.category_id, moved.category_id) == (food.id, fun.id)


def test_deleting_a_category_moves_its_entries_to_other() -> None:
    user = make_user()
    w = wallet(user)
    trip = category_service.create(user, name="سفر", kind="expense")
    spend(user, w, trip, 100, "e1")
    category_service.set_budget(user, trip.id, currency="IRT", limit_minor=500)

    category_service.delete(user, trip.id)

    other = cat(user, "سایر")
    assert ledger_service.list(user, wallet_id=None, limit=50)[0].category_id == other.id
    assert "سفر" not in {c.name for c in category_service.list(user)}
    assert category_service.budget_status(user, NOV[0], NOV[1]) == []


def test_other_cannot_be_deleted_and_foreign_ids_are_not_found() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")

    with pytest.raises(ApiError) as other:
        category_service.delete(zoe, cat(zoe, "سایر").id)
    with pytest.raises(ApiError) as foreign:
        category_service.delete(ali, cat(zoe, "حقوق", "income").id)
    with pytest.raises(ApiError) as junk:
        category_service.delete(zoe, "not-a-uuid")

    assert (other.value.status, foreign.value.status, junk.value.status) == (400, 404, 404)


def test_budget_counts_only_matching_spending_in_the_window() -> None:
    user = make_user()
    toman, usd = wallet(user, "t"), wallet(user, "u", currency="USD")
    food = cat(user, "خوراک و سوپرمارکت")
    category_service.set_budget(user, food.id, currency="IRT", limit_minor=1_000)
    spend(user, toman, food, 300, "a")
    spend(user, toman, food, 200, "b", occurred_at=datetime(2026, 10, 31, tzinfo=UTC))  # before
    spend(user, usd, food, 50, "c")  # other currency
    spend(user, toman, food, 40, "d", kind="expense")
    gone = spend(user, toman, food, 999, "e")
    ledger_service.delete(user, gone.id)

    [status] = category_service.budget_status(user, NOV[0], NOV[1])

    assert (status.category_id, status.limit_minor, status.spent_minor) == (food.id, 1_000, 340)


def test_income_and_transfers_do_not_count_against_a_budget() -> None:
    user = make_user()
    a, b = wallet(user, "a"), wallet(user, "b")
    food = cat(user, "خوراک و سوپرمارکت")
    category_service.set_budget(user, food.id, currency="IRT", limit_minor=1_000)
    transfer_service.transfer(
        user,
        from_wallet_id=a.id,
        to_wallet_id=b.id,
        amount_minor=500,
        rate="",
        fee_minor=5,
        occurred_at=datetime(2026, 11, 10, tzinfo=UTC),
        note="",
        client_mutation_id="t",
    )

    [status] = category_service.budget_status(user, NOV[0], NOV[1])

    assert status.spent_minor == 0


def test_set_budget_replaces_and_zero_removes_it() -> None:
    user = make_user()
    food = cat(user, "خوراک و سوپرمارکت")

    category_service.set_budget(user, food.id, currency="IRT", limit_minor=100)
    category_service.set_budget(user, food.id, currency="USD", limit_minor=200)
    [status] = category_service.budget_status(user, NOV[0], NOV[1])
    category_service.set_budget(user, food.id, currency="USD", limit_minor=0)

    assert (status.currency, status.limit_minor) == ("USD", 200)
    assert category_service.budget_status(user, NOV[0], NOV[1]) == []


@pytest.mark.parametrize(
    "bad",
    [{"limit_minor": -1}, {"currency": "XXX"}],
)
def test_invalid_budgets_are_refused(bad: dict[str, Any]) -> None:
    user = make_user()
    food = cat(user, "خوراک و سوپرمارکت")

    with pytest.raises(ApiError) as refusal:
        category_service.set_budget(
            user,
            food.id,
            currency=str(bad.get("currency", "IRT")),
            limit_minor=int(bad.get("limit_minor", 5)),
        )

    assert refusal.value.status == 400


def test_income_categories_take_no_budget_and_windows_must_be_ordered() -> None:
    user = make_user()
    salary = cat(user, "حقوق", "income")

    with pytest.raises(ApiError) as income:
        category_service.set_budget(user, salary.id, currency="IRT", limit_minor=5)
    with pytest.raises(ApiError) as window:
        category_service.budget_status(user, NOV[1], NOV[0])

    assert (income.value.status, window.value.status) == (400, 400)
