from collections.abc import Callable
from typing import Any

import grpc
import pytest
from django.test import Client
from google.protobuf.empty_pb2 import Empty

from apps.debts.grpc import debts_pb2, debts_pb2_grpc
from apps.wallets.grpc import wallets_pb2, wallets_pb2_grpc

Stub = debts_pb2_grpc.DebtsControllerStub
PASSWORD = "corr3ct-horse-battery"


def sign_up(name: str) -> str:
    response = Client().post(
        "/api/v1/auth/password/signup",
        {"identifier": name, "password": PASSWORD, "email": f"{name}@example.com"},
        content_type="application/json",
    )
    assert response.status_code == 200, response.content
    return response.json()["data"]["credentials"]["access_token"]


def make_wallet(grpc_call: Callable[..., Any], token: str) -> Any:
    return grpc_call(
        wallets_pb2_grpc.WalletsControllerStub,
        "Create",
        wallets_pb2.WalletCreate(
            name="ملی",
            kind="bank",
            currency="IRT",
            opening_balance_minor=10_000_000,
            client_mutation_id="w",
        ),
        token=token,
    ).wallet


def definition(**overrides: Any) -> Any:
    fields: dict[str, Any] = {
        "kind": "bank_loan",
        "title": "وام",
        "currency": "IRT",
        "installment_minor": 1_000_000,
        "count": 3,
        "first_due": "2026-12-06",
        "client_mutation_id": "d1",
    } | overrides
    return debts_pb2.DebtCreate(**fields)


def test_create_list_pay_and_unpay_over_the_wire(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")
    wallet = make_wallet(grpc_call, token)
    debt = grpc_call(Stub, "Create", definition(wallet_id=wallet.id), token=token).debt

    assert [i.due_date for i in debt.installments] == ["2026-12-06", "2027-01-05", "2027-02-04"]
    grpc_call(
        Stub, "Pay", debts_pb2.InstallmentPay(installment_id=debt.installments[0].id), token=token
    )
    listed = grpc_call(Stub, "List", Empty(), token=token).debts[0]
    entries = grpc_call(
        wallets_pb2_grpc.LedgerControllerStub, "List", wallets_pb2.EntryQuery(), token=token
    ).entries

    assert (listed.paid_count, listed.remaining_minor, listed.next_due) == (
        1,
        2_000_000,
        "2027-01-05",
    )
    assert [(e.kind, e.amount_minor) for e in entries] == [("expense", 1_000_000)]

    grpc_call(
        Stub,
        "Unpay",
        debts_pb2.InstallmentRef(installment_id=debt.installments[0].id),
        token=token,
    )
    assert grpc_call(Stub, "List", Empty(), token=token).debts[0].paid_count == 0
    assert (
        list(
            grpc_call(
                wallets_pb2_grpc.LedgerControllerStub, "List", wallets_pb2.EntryQuery(), token=token
            ).entries
        )
        == []
    )


def test_privacy_and_delete(transactional_db: None, grpc_call: Callable[..., Any]) -> None:
    zoe, ali = sign_up("zoe"), sign_up("ali")
    debt = grpc_call(Stub, "Create", definition(), token=zoe).debt

    with pytest.raises(grpc.aio.AioRpcError) as foreign:
        grpc_call(Stub, "Delete", debts_pb2.DebtRef(debt_id=debt.id), token=ali)
    assert list(grpc_call(Stub, "List", Empty(), token=ali).debts) == []
    grpc_call(Stub, "Delete", debts_pb2.DebtRef(debt_id=debt.id), token=zoe)

    assert foreign.value.code() is grpc.StatusCode.NOT_FOUND
    assert list(grpc_call(Stub, "List", Empty(), token=zoe).debts) == []


@pytest.mark.parametrize("overrides", [{"first_due": "yesterday"}, {"count": 0}, {"kind": "x"}])
def test_invalid_debts_are_invalid_argument(
    transactional_db: None, grpc_call: Callable[..., Any], overrides: dict[str, Any]
) -> None:
    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(Stub, "Create", definition(**overrides), token=sign_up("zoe"))

    assert refusal.value.code() is grpc.StatusCode.INVALID_ARGUMENT


def test_no_credential_is_unauthenticated(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(Stub, "List", Empty())

    assert refusal.value.code() is grpc.StatusCode.UNAUTHENTICATED
