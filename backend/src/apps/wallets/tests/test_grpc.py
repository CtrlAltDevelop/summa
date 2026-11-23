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
