"""Rates and assets over gRPC. Every call is scoped to the caller."""

from datetime import date
from typing import Any

from asgiref.sync import sync_to_async
from django.utils import timezone
from django_socio_grpc import generics
from django_socio_grpc.decorators import grpc_action
from google.protobuf.empty_pb2 import Empty

from apps.assets.grpc.serializers import AssetMsg, RateMsg
from apps.assets.rates import RateView, rate_service
from apps.assets.service import AssetView, asset_service
from infrastructure.common.errors import ApiError
from infrastructure.common.grpc.errors import action, require_caller
from infrastructure.common.identity import grpc_caller


def _day(text: str) -> date:
    if not text:
        return timezone.now().date()
    try:
        return date.fromisoformat(text)
    except ValueError:
        raise ApiError("bought_on is not an ISO date.", 400) from None


def _rate(view: RateView) -> Any:
    from apps.assets.grpc import assets_pb2

    return assets_pb2.RateMsg(
        symbol=view.symbol,
        name=view.name,
        unit=view.unit,
        group=view.group,
        price=format(view.price.normalize(), "f") if view.price is not None else "",
        known=view.known,
        source=view.source,
        fetched_at=view.fetched_at.isoformat() if view.fetched_at else "",
        age_seconds=view.age_seconds,
        stale=view.stale,
    )


def _asset(view: AssetView) -> Any:
    from apps.assets.grpc import assets_pb2

    return assets_pb2.AssetMsg(
        id=view.id,
        symbol=view.symbol,
        name=view.name,
        unit=view.unit,
        quantity=view.quantity,
        cost_minor=view.cost_minor,
        value_minor=view.value_minor,
        profit_minor=view.profit_minor,
        realized_minor=view.realized_minor,
        price=view.price,
        price_known=view.price_known,
        stale=view.stale,
    )


class RatesService(generics.GenericService):
    @grpc_action(
        request=[],
        response=[{"name": "rates", "type": RateMsg, "cardinality": "repeated"}],
        response_name="RateListReply",
    )
    @action
    async def List(self, request: Any, context: Any) -> Any:
        from apps.assets.grpc import assets_pb2

        require_caller(await grpc_caller(context))
        views = await sync_to_async(rate_service.list)(timezone.now())
        return assets_pb2.RateListReply(rates=[_rate(v) for v in views])

    @grpc_action(
        request=[
            {"name": "amount_minor", "type": "int64"},
            {"name": "from_currency", "type": "string"},
            {"name": "to_currency", "type": "string"},
        ],
        request_name="ConvertRequest",
        response=[
            {"name": "amount_minor", "type": "int64"},
            # True when the rate behind this conversion is old.
            {"name": "stale", "type": "bool"},
        ],
        response_name="ConvertReply",
    )
    @action
    async def Convert(self, request: Any, context: Any) -> Any:
        from apps.assets.grpc import assets_pb2

        require_caller(await grpc_caller(context))
        result = await sync_to_async(rate_service.convert)(
            request.amount_minor,
            request.from_currency,
            request.to_currency,
            now=timezone.now(),
        )
        return assets_pb2.ConvertReply(amount_minor=result.amount_minor, stale=result.stale)


class AssetsService(generics.GenericService):
    @grpc_action(
        request=[
            # A listed symbol (GOLD18, USD, BTC...) or empty for a custom asset.
            {"name": "symbol", "type": "string"},
            {"name": "name", "type": "string"},
            # Decimal text, up to 8 decimals: never a float.
            {"name": "quantity", "type": "string"},
            {"name": "unit_price_minor", "type": "int64"},
            {"name": "manual_price_minor", "type": "int64"},
            {"name": "bought_on", "type": "string"},
            {"name": "client_mutation_id", "type": "string"},
        ],
        request_name="AssetCreate",
        response=[{"name": "asset", "type": AssetMsg}],
        response_name="AssetReply",
    )
    @action
    async def Create(self, request: Any, context: Any) -> Any:
        from apps.assets.grpc import assets_pb2

        user = require_caller(await grpc_caller(context))
        view = await sync_to_async(asset_service.create)(
            user,
            symbol=request.symbol,
            name=request.name,
            quantity=request.quantity,
            unit_price_minor=request.unit_price_minor,
            manual_price_minor=request.manual_price_minor,
            bought_on=_day(request.bought_on),
            client_mutation_id=request.client_mutation_id,
            now=timezone.now(),
        )
        return assets_pb2.AssetReply(asset=_asset(view))

    @grpc_action(
        request=[],
        response=[
            {"name": "assets", "type": AssetMsg, "cardinality": "repeated"},
            {"name": "value_minor", "type": "int64"},
            {"name": "cost_minor", "type": "int64"},
            {"name": "profit_minor", "type": "int64"},
            {"name": "realized_minor", "type": "int64"},
        ],
        response_name="AssetListReply",
    )
    @action
    async def List(self, request: Any, context: Any) -> Any:
        from apps.assets.grpc import assets_pb2

        user = require_caller(await grpc_caller(context))
        result = await sync_to_async(asset_service.list)(user, timezone.now())
        return assets_pb2.AssetListReply(
            assets=[_asset(v) for v in result.assets],
            value_minor=result.value_minor,
            cost_minor=result.cost_minor,
            profit_minor=result.profit_minor,
            realized_minor=result.realized_minor,
        )

    @grpc_action(
        request=[
            {"name": "asset_id", "type": "string"},
            {"name": "quantity", "type": "string"},
            {"name": "unit_price_minor", "type": "int64"},
            {"name": "bought_on", "type": "string"},
        ],
        request_name="LotAdd",
        response=[],
    )
    @action
    async def AddLot(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        await sync_to_async(asset_service.add_lot)(
            user,
            request.asset_id,
            quantity=request.quantity,
            unit_price_minor=request.unit_price_minor,
            bought_on=_day(request.bought_on),
        )
        return Empty()

    @grpc_action(
        request=[
            {"name": "asset_id", "type": "string"},
            {"name": "quantity", "type": "string"},
            {"name": "unit_price_minor", "type": "int64"},
        ],
        request_name="AssetSell",
        response=[],
    )
    @action
    async def Sell(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        await sync_to_async(asset_service.sell)(
            user,
            request.asset_id,
            quantity=request.quantity,
            unit_price_minor=request.unit_price_minor,
        )
        return Empty()

    @grpc_action(
        request=[{"name": "asset_id", "type": "string"}],
        request_name="AssetRef",
        response=[],
    )
    @action
    async def Delete(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        await sync_to_async(asset_service.delete)(user, request.asset_id)
        return Empty()


GRPC_SERVICES = [RatesService, AssetsService]
