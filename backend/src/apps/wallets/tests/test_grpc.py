from collections.abc import Callable
from typing import Any

import grpc
import pytest
from django.test import Client
from google.protobuf.empty_pb2 import Empty

from apps.wallets.grpc import wallets_pb2, wallets_pb2_grpc

Stub = wallets_pb2_grpc.WalletsControllerStub
PASSWORD = "corr3ct-horse-battery"


def sign_up(name: str) -> str:
    response = Client().post(
        "/api/v1/auth/password/signup",
        {"identifier": name, "password": PASSWORD, "email": f"{name}@example.com"},
        content_type="application/json",
    )
    assert response.status_code == 200, response.content
    return response.json()["data"]["credentials"]["access_token"]


def new_wallet(mutation: str = "m1", balance: int = 1_000, **kw: Any) -> Any:
    fields = {"name": "ملی", "kind": "bank", "currency": "IRT", "bank": "ملی"} | kw
    return wallets_pb2.WalletCreate(
        opening_balance_minor=balance, client_mutation_id=mutation, **fields
    )


def test_create_then_list_shows_balance_and_total(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")

    grpc_call(Stub, "Create", new_wallet(), token=token)
    reply = grpc_call(Stub, "List", Empty(), token=token)

    assert [w.balance_minor for w in reply.wallets] == [1_000]
    assert [(t.currency, t.balance_minor) for t in reply.totals] == [("IRT", 1_000)]


def test_another_user_sees_nothing_and_cannot_archive(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    zoe, ali = sign_up("zoe"), sign_up("ali")
    wallet = grpc_call(Stub, "Create", new_wallet(), token=zoe).wallet

    assert list(grpc_call(Stub, "List", Empty(), token=ali).wallets) == []
    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(Stub, "Archive", wallets_pb2.WalletRef(wallet_id=wallet.id), token=ali)
    assert refusal.value.code() is grpc.StatusCode.NOT_FOUND


def test_invalid_currency_is_invalid_argument(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(Stub, "Create", new_wallet(currency="XXX"), token=sign_up("zoe"))

    assert refusal.value.code() is grpc.StatusCode.INVALID_ARGUMENT


def test_calls_without_a_credential_are_refused(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(Stub, "List", Empty())

    assert refusal.value.code() is grpc.StatusCode.UNAUTHENTICATED


def test_balances_beyond_32_bits_survive(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    """Rial-scale amounts exceed int32; the wire type must be int64."""
    token = sign_up("zoe")
    big = 50_000_000_000

    grpc_call(Stub, "Create", new_wallet(balance=big), token=token)

    assert grpc_call(Stub, "List", Empty(), token=token).wallets[0].balance_minor == big


LedgerStub = wallets_pb2_grpc.LedgerControllerStub


def test_record_edit_list_delete_round_trip(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")
    wallet = grpc_call(Stub, "Create", new_wallet(), token=token).wallet

    entry = grpc_call(
        LedgerStub,
        "Record",
        wallets_pb2.EntryRecord(
            wallet_id=wallet.id,
            kind="expense",
            amount_minor=300,
            occurred_at="2026-11-01T08:30:00+00:00",
            note="نان",
            client_mutation_id="e1",
        ),
        token=token,
    ).entry
    assert (entry.currency, entry.amount_minor, entry.note) == ("IRT", 300, "نان")
    assert grpc_call(Stub, "List", Empty(), token=token).wallets[0].balance_minor == 700

    edited = grpc_call(
        LedgerStub,
        "Edit",
        wallets_pb2.EntryEdit(entry_id=entry.id, amount_minor=100),
        token=token,
    ).entry
    assert edited.occurred_at.startswith("2026-11-01T08:30")
    listed = grpc_call(LedgerStub, "List", wallets_pb2.EntryQuery(), token=token)
    assert [e.amount_minor for e in listed.entries] == [100]

    grpc_call(LedgerStub, "Delete", wallets_pb2.EntryRef(entry_id=edited.id), token=token)
    assert list(grpc_call(LedgerStub, "List", wallets_pb2.EntryQuery(), token=token).entries) == []
    assert grpc_call(Stub, "List", Empty(), token=token).wallets[0].balance_minor == 1_000


def test_another_user_cannot_touch_an_entry(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    zoe, ali = sign_up("zoe"), sign_up("ali")
    wallet = grpc_call(Stub, "Create", new_wallet(), token=zoe).wallet
    entry = grpc_call(
        LedgerStub,
        "Record",
        wallets_pb2.EntryRecord(
            wallet_id=wallet.id, kind="income", amount_minor=5, client_mutation_id="e1"
        ),
        token=zoe,
    ).entry

    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(LedgerStub, "Delete", wallets_pb2.EntryRef(entry_id=entry.id), token=ali)

    assert refusal.value.code() is grpc.StatusCode.NOT_FOUND


@pytest.mark.parametrize("when", ["yesterday", "2026-11-01T08:30:00"])
def test_a_bad_time_is_invalid_argument(
    transactional_db: None, grpc_call: Callable[..., Any], when: str
) -> None:
    token = sign_up("zoe")
    wallet = grpc_call(Stub, "Create", new_wallet(), token=token).wallet

    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(
            LedgerStub,
            "Record",
            wallets_pb2.EntryRecord(
                wallet_id=wallet.id,
                kind="expense",
                amount_minor=1,
                occurred_at=when,
                client_mutation_id="e1",
            ),
            token=token,
        )

    assert refusal.value.code() is grpc.StatusCode.INVALID_ARGUMENT


def test_transfer_between_currencies_over_the_wire(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")
    toman = grpc_call(Stub, "Create", new_wallet("m1", balance=5_000_000), token=token).wallet
    usd = grpc_call(
        Stub, "Create", new_wallet("m2", balance=0, currency="USD", name="usd"), token=token
    ).wallet

    reply = grpc_call(
        LedgerStub,
        "Transfer",
        wallets_pb2.TransferRequest(
            from_wallet_id=toman.id,
            to_wallet_id=usd.id,
            amount_minor=1_000_000,
            rate="0.0000165",
            fee_minor=500,
            client_mutation_id="t1",
        ),
        token=token,
    )

    assert [(e.kind, e.amount_minor, e.currency) for e in reply.entries] == [
        ("transfer_out", 1_000_000, "IRT"),
        ("transfer_in", 1_650, "USD"),
        ("expense", 500, "IRT"),
    ]
    balances = {
        w.id: w.balance_minor for w in grpc_call(Stub, "List", Empty(), token=token).wallets
    }
    assert balances == {toman.id: 3_999_500, usd.id: 1_650}


def test_a_transfer_without_a_needed_rate_is_invalid_argument(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")
    a = grpc_call(Stub, "Create", new_wallet("m1"), token=token).wallet
    b = grpc_call(Stub, "Create", new_wallet("m2", currency="USD", name="u"), token=token).wallet

    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(
            LedgerStub,
            "Transfer",
            wallets_pb2.TransferRequest(
                from_wallet_id=a.id, to_wallet_id=b.id, amount_minor=10, client_mutation_id="t"
            ),
            token=token,
        )

    assert refusal.value.code() is grpc.StatusCode.INVALID_ARGUMENT


CategoryStub = wallets_pb2_grpc.CategoryControllerStub


def test_categories_budget_and_status_over_the_wire(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")
    wallet = grpc_call(Stub, "Create", new_wallet(), token=token).wallet
    cats = grpc_call(CategoryStub, "List", Empty(), token=token).categories
    food = next(c for c in cats if c.name == "خوراک و سوپرمارکت")

    entry = grpc_call(
        LedgerStub,
        "Record",
        wallets_pb2.EntryRecord(
            wallet_id=wallet.id,
            kind="expense",
            amount_minor=300,
            occurred_at="2026-11-10T00:00:00+00:00",
            category_id=food.id,
            client_mutation_id="e1",
        ),
        token=token,
    ).entry
    grpc_call(
        CategoryStub,
        "SetBudget",
        wallets_pb2.BudgetSet(category_id=food.id, currency="IRT", limit_minor=1_000),
        token=token,
    )
    status = grpc_call(
        CategoryStub,
        "BudgetStatus",
        wallets_pb2.BudgetWindow(
            starts_at="2026-11-01T00:00:00+00:00", ends_at="2026-12-01T00:00:00+00:00"
        ),
        token=token,
    )

    assert entry.category_id == food.id
    assert [(b.category_name, b.limit_minor, b.spent_minor) for b in status.budgets] == [
        ("خوراک و سوپرمارکت", 1_000, 300)
    ]


def test_another_user_cannot_delete_my_category_and_defaults_are_per_user(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    zoe, ali = sign_up("zoe"), sign_up("ali")
    mine = grpc_call(
        CategoryStub, "Create", wallets_pb2.CategoryCreate(name="سفر", kind="expense"), token=zoe
    ).category

    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(CategoryStub, "Delete", wallets_pb2.CategoryRef(category_id=mine.id), token=ali)

    assert refusal.value.code() is grpc.StatusCode.NOT_FOUND
    ali_names = {c.name for c in grpc_call(CategoryStub, "List", Empty(), token=ali).categories}
    assert "سفر" not in ali_names


def test_a_budget_window_without_offsets_is_invalid_argument(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(
            CategoryStub,
            "BudgetStatus",
            wallets_pb2.BudgetWindow(starts_at="2026-11-01T00:00:00", ends_at=""),
            token=sign_up("zoe"),
        )

    assert refusal.value.code() is grpc.StatusCode.INVALID_ARGUMENT
