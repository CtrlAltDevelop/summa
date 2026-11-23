from collections.abc import Callable
from decimal import Decimal
from typing import Any

import grpc
import pytest
from django.test import Client
from google.protobuf.empty_pb2 import Empty

from apps.assets.grpc import assets_pb2, assets_pb2_grpc
from apps.assets.rates import rate_service

Rates = assets_pb2_grpc.RatesControllerStub
Assets = assets_pb2_grpc.AssetsControllerStub
PASSWORD = "corr3ct-horse-battery"


def sign_up(name: str) -> str:
    response = Client().post(
        "/api/v1/auth/password/signup",
        {"identifier": name, "password": PASSWORD, "email": f"{name}@example.com"},
        content_type="application/json",
    )
    assert response.status_code == 200, response.content
    return response.json()["data"]["credentials"]["access_token"]


def test_rates_list_and_convert(transactional_db: None, grpc_call: Callable[..., Any]) -> None:
    token = sign_up("zoe")
    rate_service.set_manual("USD", Decimal(60_000))

    listed = grpc_call(Rates, "List", Empty(), token=token).rates
    converted = grpc_call(
        Rates,
        "Convert",
        assets_pb2.ConvertRequest(amount_minor=1_200_000, from_currency="IRT", to_currency="USD"),
        token=token,
    )
    usd = next(r for r in listed if r.symbol == "USD")
    gold = next(r for r in listed if r.symbol == "GOLD18")

    assert (usd.price, usd.known, usd.source) == ("60000", True, "manual")
    assert (gold.known, gold.stale, gold.price) == (False, True, "")
    assert converted.amount_minor == 2_000


def test_a_missing_rate_is_not_found_and_a_bad_currency_invalid(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")

    with pytest.raises(grpc.aio.AioRpcError) as missing:
        grpc_call(
            Rates,
            "Convert",
            assets_pb2.ConvertRequest(amount_minor=1, from_currency="IRT", to_currency="USD"),
            token=token,
        )
    with pytest.raises(grpc.aio.AioRpcError) as bad:
        grpc_call(
            Rates,
            "Convert",
            assets_pb2.ConvertRequest(amount_minor=1, from_currency="IRT", to_currency="XXX"),
            token=token,
        )

    assert missing.value.code() is grpc.StatusCode.NOT_FOUND
    assert bad.value.code() is grpc.StatusCode.INVALID_ARGUMENT


def test_an_asset_with_a_lot_a_sale_and_a_profit(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")
    rate_service.set_manual("GOLD18", Decimal(8_000_000))
    asset = grpc_call(
        Assets,
        "Create",
        assets_pb2.AssetCreate(
            symbol="GOLD18",
            quantity="10",
            unit_price_minor=7_000_000,
            bought_on="2026-11-01",
            client_mutation_id="a1",
        ),
        token=token,
    ).asset
    grpc_call(
        Assets,
        "AddLot",
        assets_pb2.LotAdd(
            asset_id=asset.id, quantity="5", unit_price_minor=7_600_000, bought_on="2026-11-10"
        ),
        token=token,
    )
    grpc_call(
        Assets,
        "Sell",
        assets_pb2.AssetSell(asset_id=asset.id, quantity="12", unit_price_minor=8_100_000),
        token=token,
    )

    listed = grpc_call(Assets, "List", Empty(), token=token)
    held = listed.assets[0]

    assert (held.name, held.unit, held.quantity) == ("طلای ۱۸ عیار", "گرم", "3")
    assert (held.value_minor, held.cost_minor, held.realized_minor) == (
        24_000_000,
        22_800_000,
        12_000_000,
    )
    assert (listed.value_minor, listed.profit_minor) == (24_000_000, 1_200_000)


def test_privacy_and_validation(transactional_db: None, grpc_call: Callable[..., Any]) -> None:
    zoe, ali = sign_up("zoe"), sign_up("ali")
    asset = grpc_call(
        Assets,
        "Create",
        assets_pb2.AssetCreate(
            symbol="USD", quantity="1", unit_price_minor=1, client_mutation_id="a1"
        ),
        token=zoe,
    ).asset

    with pytest.raises(grpc.aio.AioRpcError) as foreign:
        grpc_call(Assets, "Delete", assets_pb2.AssetRef(asset_id=asset.id), token=ali)
    with pytest.raises(grpc.aio.AioRpcError) as bad_quantity:
        grpc_call(
            Assets,
            "Create",
            assets_pb2.AssetCreate(symbol="USD", quantity="1.5e3", client_mutation_id="a2"),
            token=zoe,
        )
    with pytest.raises(grpc.aio.AioRpcError) as bad_date:
        grpc_call(
            Assets,
            "AddLot",
            assets_pb2.LotAdd(asset_id=asset.id, quantity="1", bought_on="yesterday"),
            token=zoe,
        )

    assert list(grpc_call(Assets, "List", Empty(), token=ali).assets) == []
    assert foreign.value.code() is grpc.StatusCode.NOT_FOUND
    assert bad_quantity.value.code() is grpc.StatusCode.INVALID_ARGUMENT
    assert bad_date.value.code() is grpc.StatusCode.INVALID_ARGUMENT


def test_no_credential_is_unauthenticated(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(Rates, "List", Empty())

    assert refusal.value.code() is grpc.StatusCode.UNAUTHENTICATED
