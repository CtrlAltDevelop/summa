from datetime import UTC, datetime
from typing import Any

import pytest
from django.contrib.auth import get_user_model

from apps.wallets.categories import category_service
from apps.wallets.ledger import SplitPart, ledger_service
from apps.wallets.services import wallets_service
from infrastructure.common.errors import ApiError

pytestmark = pytest.mark.django_db

NOV = (datetime(2026, 11, 1, tzinfo=UTC), datetime(2026, 12, 1, tzinfo=UTC))
WHEN = datetime(2026, 11, 10, tzinfo=UTC)


def make_user(name: str = "zoe") -> Any:
    return get_user_model()._default_manager.create_user(username=name)


def wallet(user: Any, name: str = "w", archived: bool = False) -> Any:
    w = wallets_service.create(
        user,
        name=name,
        kind="bank",
        currency="IRT",
        bank="",
        opening_balance_minor=1_000_000,
        client_mutation_id=f"w-{name}",
    )
    if archived:
        wallets_service.archive(user, w.id)
    return w


def cat(user: Any, name: str, kind: str = "expense") -> Any:
    return next(c for c in category_service.list(user) if c.name == name and c.kind == kind)


def balance(user: Any) -> int:
    return wallets_service.list(user).wallets[0].balance_minor


def split(user: Any, w: Any, parts: list[SplitPart], **overrides: Any) -> list[Any]:
    fields: dict[str, Any] = {
        "wallet_id": w.id,
        "parts": parts,
        "occurred_at": WHEN,
        "note": "شام",
        "client_mutation_id": "s1",
    } | overrides
    return ledger_service.record_split(user, **fields)


def test_a_split_charges_the_sum_and_keeps_each_category() -> None:
    user = make_user()
    w = wallet(user)
    food, fun = cat(user, "رستوران و کافه"), cat(user, "تفریح و اشتراک")

    entries = split(
        user,
        w,
        [SplitPart(food.id, 300_000, False), SplitPart(fun.id, 100_000, False)],
    )

    assert balance(user) == 600_000
    assert [(e.category_id, e.amount_minor) for e in entries] == [
        (food.id, 300_000),
        (fun.id, 100_000),
    ]
    assert len({e.split_id for e in entries}) == 1 and entries[0].split_id != ""


def test_an_outside_part_leaves_the_wallet_but_not_the_budget() -> None:
    user = make_user()
    w = wallet(user)
    food = cat(user, "رستوران و کافه")
    category_service.set_budget(user, food.id, currency="IRT", limit_minor=1_000_000)

    split(user, w, [SplitPart(food.id, 100_000, False), SplitPart(food.id, 300_000, True)])

    [status] = category_service.budget_status(user, *NOV)
    assert balance(user) == 600_000
    assert status.spent_minor == 100_000


def test_record_and_edit_carry_the_outside_flag() -> None:
    user = make_user()
    w = wallet(user)
    entry = ledger_service.record(
        user,
        wallet_id=w.id,
        kind="expense",
        amount_minor=100,
        occurred_at=WHEN,
        note="",
        client_mutation_id="e1",
        outside_totals=True,
    )

    kept = ledger_service.edit(user, entry.id, amount_minor=90, occurred_at=None, note="")
    cleared = ledger_service.edit(
        user, kept.id, amount_minor=90, occurred_at=None, note="", outside_totals=False
    )

    assert (entry.outside_totals, kept.outside_totals, cleared.outside_totals) == (
        True,
        True,
        False,
    )


def test_income_cannot_be_outside_the_totals() -> None:
    user = make_user()
    w = wallet(user)

    with pytest.raises(ApiError) as refusal:
        ledger_service.record(
            user,
            wallet_id=w.id,
            kind="income",
            amount_minor=5,
            occurred_at=None,
            note="",
            client_mutation_id="e1",
            outside_totals=True,
        )

    assert refusal.value.status == 400


@pytest.mark.parametrize(
    "parts",
    [
        [(100, False)],
        [(100, False)] * 11,
        [(100, False), (0, False)],
        [(100, False), (-5, False)],
    ],
)
def test_the_number_and_size_of_parts_is_checked(parts: list[tuple[int, bool]]) -> None:
    user = make_user()
    w = wallet(user)

    with pytest.raises(ApiError) as refusal:
        split(user, w, [SplitPart("", amount, outside) for amount, outside in parts])

    assert refusal.value.status == 400
    assert balance(user) == 1_000_000


def test_categories_must_be_the_users_own_expense_categories() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    w = wallet(zoe)
    salary = cat(zoe, "حقوق", "income")
    foreign = cat(ali, "سایر")

    with pytest.raises(ApiError) as wrong_kind:
        split(zoe, w, [SplitPart(salary.id, 5, False), SplitPart("", 5, False)])
    with pytest.raises(ApiError) as other_user:
        split(zoe, w, [SplitPart(foreign.id, 5, False), SplitPart("", 5, False)])

    assert (wrong_kind.value.status, other_user.value.status) == (400, 404)


def test_an_archived_wallet_and_a_long_note_are_refused() -> None:
    user = make_user()
    gone = wallet(user, "gone", archived=True)
    live = wallet(user, "live")
    parts = [SplitPart("", 5, False), SplitPart("", 5, False)]

    with pytest.raises(ApiError) as archived:
        split(user, gone, parts)
    with pytest.raises(ApiError) as note:
        split(user, live, parts, note="x" * 201, client_mutation_id="s2")

    assert (archived.value.status, note.value.status) == (400, 400)


def test_repeating_a_mutation_splits_once() -> None:
    user = make_user()
    w = wallet(user)
    parts = [SplitPart("", 100, False), SplitPart("", 200, True)]

    first = split(user, w, parts)
    again = split(user, w, parts)

    assert [e.id for e in again] == [e.id for e in first]
    assert balance(user) == 999_700


def test_deleting_one_part_voids_the_whole_split() -> None:
    user = make_user()
    w = wallet(user)
    entries = split(user, w, [SplitPart("", 100, False), SplitPart("", 200, False)])

    ledger_service.delete(user, entries[1].id)

    assert balance(user) == 1_000_000
    assert ledger_service.list(user, wallet_id=None, limit=50) == []


def test_a_part_cannot_be_edited() -> None:
    user = make_user()
    w = wallet(user)
    entries = split(user, w, [SplitPart("", 100, False), SplitPart("", 200, False)])

    with pytest.raises(ApiError) as refusal:
        ledger_service.edit(user, entries[0].id, amount_minor=1, occurred_at=None, note="")

    assert refusal.value.status == 400


def test_splits_are_private() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    entries = split(zoe, wallet(zoe), [SplitPart("", 100, False), SplitPart("", 200, False)])

    with pytest.raises(ApiError) as refusal:
        ledger_service.delete(ali, entries[0].id)

    assert refusal.value.status == 404
    assert ledger_service.list(ali, wallet_id=None, limit=50) == []
