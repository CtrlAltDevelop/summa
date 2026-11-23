from datetime import UTC, datetime
from typing import Any

import pytest
from django.contrib.auth import get_user_model

from apps.wallets.categories import category_service
from apps.wallets.ledger import ledger_service
from apps.wallets.services import wallets_service
from infrastructure.common.errors import ApiError

pytestmark = pytest.mark.django_db

NOV = (datetime(2026, 11, 1, tzinfo=UTC), datetime(2026, 12, 1, tzinfo=UTC))
WHEN = datetime(2026, 11, 10, tzinfo=UTC)


def make_user(name: str = "zoe") -> Any:
    return get_user_model()._default_manager.create_user(username=name)


def wallet(user: Any, name: str = "a", currency: str = "IRT") -> Any:
    return wallets_service.create(
        user,
        name=name,
        kind="bank",
        currency=currency,
        bank="",
        opening_balance_minor=1_000_000,
        client_mutation_id=f"w-{name}",
    )


def spend(user: Any, w: Any, amount: int = 1_000, mutation: str = "e1", **kw: Any) -> Any:
    return ledger_service.record(
        user,
        wallet_id=w.id,
        kind=kw.pop("kind", "expense"),
        amount_minor=amount,
        occurred_at=WHEN,
        note="",
        client_mutation_id=mutation,
        **kw,
    )


def refund(user: Any, entry: Any, **overrides: Any) -> Any:
    fields: dict[str, Any] = {
        "wallet_id": None,
        "amount_minor": 0,
        "occurred_at": WHEN,
        "note": "",
        "client_mutation_id": "r1",
    } | overrides
    return ledger_service.refund(user, entry.id, **fields)


def balances(user: Any) -> dict[str, int]:
    return {w.name: w.balance_minor for w in wallets_service.list(user).wallets}


def test_a_full_refund_restores_the_balance_and_links_to_the_expense() -> None:
    user = make_user()
    w = wallet(user)
    expense = spend(user, w)

    back = refund(user, expense)

    assert balances(user) == {"a": 1_000_000}
    assert (back.kind, back.amount_minor, back.refund_of) == ("refund", 1_000, expense.id)


def test_a_partial_refund_tracks_what_is_left() -> None:
    user = make_user()
    w = wallet(user)
    expense = spend(user, w)

    refund(user, expense, amount_minor=300)
    refund(user, expense, amount_minor=0, client_mutation_id="r2")  # the remaining 700

    listed = {e.id: e for e in ledger_service.list(user, wallet_id=None, limit=50)}
    assert listed[expense.id].refunded_minor == 1_000
    assert balances(user) == {"a": 1_000_000}


def test_one_cannot_refund_more_than_was_spent() -> None:
    user = make_user()
    expense = spend(user, wallet(user))
    refund(user, expense, amount_minor=900)

    with pytest.raises(ApiError) as over:
        refund(user, expense, amount_minor=101, client_mutation_id="r2")
    with pytest.raises(ApiError) as none_left:
        refund(user, expense, amount_minor=100, client_mutation_id="r3")
        refund(user, expense, amount_minor=0, client_mutation_id="r4")

    assert over.value.status == 400 and none_left.value.status == 400


def test_a_refund_can_go_to_another_wallet_of_the_same_currency() -> None:
    user = make_user()
    a, b = wallet(user, "a"), wallet(user, "b")
    expense = spend(user, a)

    back = refund(user, expense, wallet_id=b.id)

    assert back.wallet_id == b.id
    assert balances(user) == {"a": 999_000, "b": 1_001_000}


def test_a_refund_to_another_currency_is_refused() -> None:
    user = make_user()
    expense = spend(user, wallet(user, "a"))
    usd = wallet(user, "u", currency="USD")

    with pytest.raises(ApiError) as refusal:
        refund(user, expense, wallet_id=usd.id)

    assert refusal.value.status == 400


@pytest.mark.parametrize("kind", ["income"])
def test_only_expenses_can_be_refunded(kind: str) -> None:
    user = make_user()
    income = spend(user, wallet(user), kind=kind)

    with pytest.raises(ApiError) as refusal:
        refund(user, income)

    assert refusal.value.status == 400


def test_a_refund_cannot_be_refunded() -> None:
    user = make_user()
    back = refund(user, spend(user, wallet(user)))

    with pytest.raises(ApiError) as refusal:
        refund(user, back, client_mutation_id="r2")

    assert refusal.value.status == 400


@pytest.mark.parametrize(
    "bad", [{"amount_minor": -1}, {"note": "x" * 201}, {"client_mutation_id": ""}]
)
def test_invalid_refunds_are_refused(bad: dict[str, Any]) -> None:
    user = make_user()
    expense = spend(user, wallet(user))

    with pytest.raises(ApiError) as refusal:
        refund(user, expense, **bad)

    assert refusal.value.status == 400
    assert balances(user) == {"a": 999_000}


def test_an_archived_target_wallet_is_refused() -> None:
    user = make_user()
    a, b = wallet(user, "a"), wallet(user, "b")
    expense = spend(user, a)
    wallets_service.archive(user, b.id)

    with pytest.raises(ApiError) as refusal:
        refund(user, expense, wallet_id=b.id)

    assert refusal.value.status == 400


def test_other_users_cannot_refund_or_see_it() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    expense = spend(zoe, wallet(zoe))

    with pytest.raises(ApiError) as refusal:
        refund(ali, expense)

    assert refusal.value.status == 404


def test_a_deleted_expense_is_not_found_for_refunds() -> None:
    user = make_user()
    expense = spend(user, wallet(user))
    ledger_service.delete(user, expense.id)

    with pytest.raises(ApiError) as refusal:
        refund(user, expense)

    assert refusal.value.status == 404


def test_repeating_a_mutation_refunds_once() -> None:
    user = make_user()
    expense = spend(user, wallet(user))

    first = refund(user, expense, amount_minor=100)
    again = refund(user, expense, amount_minor=100)

    assert again.id == first.id
    assert balances(user) == {"a": 999_100}


def test_deleting_a_refund_reopens_the_expense_for_refunding() -> None:
    user = make_user()
    expense = spend(user, wallet(user))
    back = refund(user, expense)

    ledger_service.delete(user, back.id)
    again = refund(user, expense, client_mutation_id="r2")

    assert balances(user) == {"a": 1_000_000}
    assert again.amount_minor == 1_000


def test_an_expense_with_a_refund_cannot_be_deleted_or_edited() -> None:
    user = make_user()
    expense = spend(user, wallet(user))
    refund(user, expense, amount_minor=1)

    with pytest.raises(ApiError) as deleted:
        ledger_service.delete(user, expense.id)
    with pytest.raises(ApiError) as edited:
        ledger_service.edit(user, expense.id, amount_minor=5, occurred_at=None, note="")

    assert (deleted.value.status, edited.value.status) == (400, 400)


def test_a_refund_cannot_be_edited() -> None:
    user = make_user()
    back = refund(user, spend(user, wallet(user)))

    with pytest.raises(ApiError) as refusal:
        ledger_service.edit(user, back.id, amount_minor=5, occurred_at=None, note="")

    assert refusal.value.status == 400


def test_a_refund_lowers_the_budgets_spending_but_never_below_zero() -> None:
    user = make_user()
    w = wallet(user)
    food = next(c for c in category_service.list(user) if c.name == "خوراک و سوپرمارکت")
    category_service.set_budget(user, food.id, currency="IRT", limit_minor=5_000)
    expense = spend(user, w, 1_000, category_id=food.id)

    refund(user, expense, amount_minor=400)
    [after_partial] = category_service.budget_status(user, *NOV)
    refund(user, expense, amount_minor=0, client_mutation_id="r2")
    [after_full] = category_service.budget_status(user, *NOV)

    assert (after_partial.spent_minor, after_full.spent_minor) == (600, 0)


def test_a_refund_of_an_outside_expense_does_not_touch_the_budget() -> None:
    user = make_user()
    w = wallet(user)
    food = next(c for c in category_service.list(user) if c.name == "خوراک و سوپرمارکت")
    category_service.set_budget(user, food.id, currency="IRT", limit_minor=5_000)
    spend(user, w, 1_000, mutation="inside", category_id=food.id)
    outside = spend(user, w, 700, mutation="out", category_id=food.id, outside_totals=True)

    back = refund(user, outside)
    [status] = category_service.budget_status(user, *NOV)

    assert back.outside_totals is True
    assert status.spent_minor == 1_000
