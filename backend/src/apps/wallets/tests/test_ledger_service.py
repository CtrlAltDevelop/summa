from datetime import UTC, datetime
from typing import Any

import pytest
from django.contrib.auth import get_user_model

from apps.wallets.ledger import ledger_service
from apps.wallets.services import wallets_service
from infrastructure.common.errors import ApiError

pytestmark = pytest.mark.django_db


def make_user(name: str = "zoe") -> Any:
    return get_user_model()._default_manager.create_user(username=name)


def wallet(user: Any, balance: int = 1_000, mutation: str = "w1") -> Any:
    return wallets_service.create(
        user,
        name="کیف",
        kind="bank",
        currency="IRT",
        bank="",
        opening_balance_minor=balance,
        client_mutation_id=mutation,
    )


def record(user: Any, wallet_id: str, **overrides: Any) -> Any:
    fields: dict[str, Any] = {
        "wallet_id": wallet_id,
        "kind": "expense",
        "amount_minor": 100,
        "occurred_at": None,
        "note": "",
        "client_mutation_id": "e1",
    } | overrides
    return ledger_service.record(user, **fields)


def balance(user: Any) -> int:
    return wallets_service.list(user).wallets[0].balance_minor


def test_expense_lowers_and_income_raises_the_balance() -> None:
    user = make_user()
    w = wallet(user)

    record(user, w.id, amount_minor=300)
    record(user, w.id, kind="income", amount_minor=50, client_mutation_id="e2")

    assert balance(user) == 750


def test_entry_carries_currency_and_time() -> None:
    user = make_user()
    w = wallet(user)
    when = datetime(2026, 11, 1, 8, 30, tzinfo=UTC)

    entry = record(user, w.id, occurred_at=when, note="نان")

    assert (entry.currency, entry.occurred_at, entry.note) == ("IRT", when, "نان")


def test_repeating_a_mutation_records_once() -> None:
    user = make_user()
    w = wallet(user)

    first = record(user, w.id)
    again = record(user, w.id)

    assert again.id == first.id
    assert balance(user) == 900


@pytest.mark.parametrize(
    "bad",
    [
        {"amount_minor": 0},
        {"amount_minor": -5},
        {"kind": "transfer"},
        {"note": "x" * 201},
        {"client_mutation_id": ""},
    ],
)
def test_invalid_input_is_refused(bad: dict[str, Any]) -> None:
    user = make_user()
    w = wallet(user)

    with pytest.raises(ApiError) as refusal:
        record(user, w.id, **bad)

    assert refusal.value.status == 400


def test_recording_on_an_archived_wallet_is_refused() -> None:
    user = make_user()
    w = wallet(user)
    wallets_service.archive(user, w.id)

    with pytest.raises(ApiError) as refusal:
        record(user, w.id)

    assert refusal.value.status == 400


def test_recording_on_someone_elses_wallet_is_not_found() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    w = wallet(zoe)

    with pytest.raises(ApiError) as refusal:
        record(ali, w.id)

    assert refusal.value.status == 404


def test_edit_replaces_the_event_and_fixes_the_balance() -> None:
    user = make_user()
    w = wallet(user)
    entry = record(user, w.id, amount_minor=300)

    edited = ledger_service.edit(user, entry.id, amount_minor=100, occurred_at=None, note="کم‌تر")

    assert balance(user) == 900
    assert edited.id != entry.id
    assert [e.id for e in ledger_service.list(user, wallet_id=None, limit=50)] == [edited.id]


def test_delete_voids_the_entry() -> None:
    user = make_user()
    w = wallet(user)
    entry = record(user, w.id)

    ledger_service.delete(user, entry.id)

    assert balance(user) == 1_000
    assert ledger_service.list(user, wallet_id=None, limit=50) == []


def test_a_voided_entry_cannot_be_edited_or_deleted_again() -> None:
    user = make_user()
    w = wallet(user)
    entry = record(user, w.id)
    ledger_service.delete(user, entry.id)

    for call in (
        lambda: ledger_service.delete(user, entry.id),
        lambda: ledger_service.edit(user, entry.id, amount_minor=1, occurred_at=None, note=""),
    ):
        with pytest.raises(ApiError) as refusal:
            call()
        assert refusal.value.status == 404


def test_the_opening_balance_is_not_editable() -> None:
    user = make_user()
    wallet(user)
    from apps.wallets.models import LedgerEvent

    opening = LedgerEvent.objects.get(user=user)

    with pytest.raises(ApiError) as refusal:
        ledger_service.delete(user, str(opening.id))

    assert refusal.value.status == 404


def test_other_users_cannot_edit_or_delete() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    entry = record(zoe, wallet(zoe).id)

    with pytest.raises(ApiError) as refusal:
        ledger_service.delete(ali, entry.id)

    assert refusal.value.status == 404
    assert ledger_service.list(ali, wallet_id=None, limit=50) == []


def test_list_is_newest_first_filterable_and_limited() -> None:
    user = make_user()
    a, b = wallet(user), wallet(user, mutation="w2")
    old = record(user, a.id, occurred_at=datetime(2026, 1, 1, tzinfo=UTC), client_mutation_id="1")
    new = record(user, a.id, occurred_at=datetime(2026, 2, 1, tzinfo=UTC), client_mutation_id="2")
    other = record(user, b.id, occurred_at=datetime(2026, 3, 1, tzinfo=UTC), client_mutation_id="3")

    assert [e.id for e in ledger_service.list(user, wallet_id=None, limit=50)] == [
        other.id,
        new.id,
        old.id,
    ]
    assert [e.id for e in ledger_service.list(user, wallet_id=a.id, limit=50)] == [new.id, old.id]
    assert len(ledger_service.list(user, wallet_id=None, limit=1)) == 1
    assert len(ledger_service.list(user, wallet_id=None, limit=0)) == 3
    assert ledger_service.list(user, wallet_id="not-a-uuid", limit=50) == []
