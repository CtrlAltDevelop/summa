from collections.abc import Callable
from decimal import Decimal
from typing import Any

import grpc
import pytest
from django.test import Client
from google.protobuf.empty_pb2 import Empty

from apps.assets.rates import rate_service
from apps.networth.grpc import networth_pb2, networth_pb2_grpc
from apps.wallets.grpc import wallets_pb2, wallets_pb2_grpc

Stub = networth_pb2_grpc.NetWorthControllerStub
PASSWORD = "corr3ct-horse-battery"


def sign_up(name: str) -> str:
    response = Client().post(
        "/api/v1/auth/password/signup",
        {"identifier": name, "password": PASSWORD, "email": f"{name}@example.com"},
        content_type="application/json",
    )
    assert response.status_code == 200, response.content
    return response.json()["data"]["credentials"]["access_token"]


def make_wallet(
    grpc_call: Callable[..., Any], token: str, balance: int, currency: str = "IRT", name: str = "a"
) -> Any:
    return grpc_call(
        wallets_pb2_grpc.WalletsControllerStub,
        "Create",
        wallets_pb2.WalletCreate(
            name=name,
            kind="bank",
            currency=currency,
            opening_balance_minor=balance,
            client_mutation_id=f"w-{name}",
        ),
        token=token,
    ).wallet


def test_net_worth_over_the_wire(transactional_db: None, grpc_call: Callable[..., Any]) -> None:
    token = sign_up("zoe")
    rate_service.set_manual("USD", Decimal(60_000))
    rate_service.set_manual("GOLD18", Decimal(8_000_000))
    make_wallet(grpc_call, token, 12_000_000)
    make_wallet(grpc_call, token, 100, "EUR", "eur")

    reply = grpc_call(Stub, "Get", Empty(), token=token)

    assert (reply.total_minor, reply.wallets_minor) == (12_000_000, 12_000_000)
    assert (reply.usd_present, reply.usd_minor, reply.gold_grams) == (True, 20_000, "1.5")
    assert list(reply.unconverted) == ["EUR"]


def test_without_rates_the_equivalents_are_blank(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")
    make_wallet(grpc_call, token, 1_000)

    reply = grpc_call(Stub, "Get", Empty(), token=token)

    assert (reply.usd_present, reply.gold_grams, reply.total_minor) == (False, "", 1_000)


def test_a_basket_is_created_measured_and_deleted(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")
    wallet = make_wallet(grpc_call, token, 25_000_000)

    made = grpc_call(
        Stub,
        "CreateBasket",
        networth_pb2.BasketCreate(
            name="خانه",
            target_minor=100_000_000,
            items=[networth_pb2.BasketItemRefMsg(kind="wallet", ref_id=wallet.id)],
            client_mutation_id="b1",
        ),
        token=token,
    ).basket
    listed = grpc_call(Stub, "ListBaskets", Empty(), token=token).baskets
    grpc_call(Stub, "DeleteBasket", networth_pb2.BasketRef(basket_id=made.id), token=token)

    assert (made.value_minor, made.percent) == (25_000_000, 25)
    assert [b.items[0].name for b in listed] == ["a"]
    assert list(grpc_call(Stub, "ListBaskets", Empty(), token=token).baskets) == []


def test_privacy_and_validation(transactional_db: None, grpc_call: Callable[..., Any]) -> None:
    zoe, ali = sign_up("zoe"), sign_up("ali")
    theirs = make_wallet(grpc_call, ali, 1)
    made = grpc_call(
        Stub,
        "CreateBasket",
        networth_pb2.BasketCreate(name="x", target_minor=10, client_mutation_id="b1"),
        token=zoe,
    ).basket

    with pytest.raises(grpc.aio.AioRpcError) as foreign_item:
        grpc_call(
            Stub,
            "CreateBasket",
            networth_pb2.BasketCreate(
                name="y",
                target_minor=10,
                items=[networth_pb2.BasketItemRefMsg(kind="wallet", ref_id=theirs.id)],
                client_mutation_id="b2",
            ),
            token=zoe,
        )
    with pytest.raises(grpc.aio.AioRpcError) as foreign_basket:
        grpc_call(Stub, "DeleteBasket", networth_pb2.BasketRef(basket_id=made.id), token=ali)
    with pytest.raises(grpc.aio.AioRpcError) as bad_target:
        grpc_call(
            Stub,
            "CreateBasket",
            networth_pb2.BasketCreate(name="z", target_minor=0, client_mutation_id="b3"),
            token=zoe,
        )

    assert foreign_item.value.code() is grpc.StatusCode.NOT_FOUND
    assert foreign_basket.value.code() is grpc.StatusCode.NOT_FOUND
    assert bad_target.value.code() is grpc.StatusCode.INVALID_ARGUMENT


def test_no_credential_is_unauthenticated(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(Stub, "Get", Empty())

    assert refusal.value.code() is grpc.StatusCode.UNAUTHENTICATED
