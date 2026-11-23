"""Net worth and goal baskets over gRPC. Every call is scoped to the caller."""

from typing import Any

from asgiref.sync import sync_to_async
from django.utils import timezone
from django_socio_grpc import generics
from django_socio_grpc.decorators import grpc_action
from google.protobuf.empty_pb2 import Empty

from apps.networth.grpc.serializers import BasketItemRefMsg, BasketMsg
from apps.networth.service import BasketItemRef, BasketView, networth_service
from infrastructure.common.grpc.errors import action, require_caller
from infrastructure.common.identity import grpc_caller

BASKET_REPLY = [{"name": "basket", "type": BasketMsg}]


def _basket(view: BasketView) -> Any:
    from apps.networth.grpc import networth_pb2

    return networth_pb2.BasketMsg(
        id=view.id,
        name=view.name,
        target_minor=view.target_minor,
        value_minor=view.value_minor,
        percent=view.percent,
        items=[
            networth_pb2.BasketItemMsg(
                kind=i.kind, ref_id=i.ref_id, name=i.name, value_minor=i.value_minor
            )
            for i in view.items
        ],
    )


class NetWorthService(generics.GenericService):
    @grpc_action(
        request=[],
        response=[
            {"name": "total_minor", "type": "int64"},
            {"name": "wallets_minor", "type": "int64"},
            {"name": "assets_minor", "type": "int64"},
            {"name": "debts_minor", "type": "int64"},
            {"name": "usd_present", "type": "bool"},
            {"name": "usd_minor", "type": "int64"},
            # Grams of 18-carat gold as decimal text; empty without a gold rate.
            {"name": "gold_grams", "type": "string"},
            {"name": "stale", "type": "bool"},
            # Currencies with no rate: left out of the totals.
            {"name": "unconverted", "type": "string", "cardinality": "repeated"},
            {"name": "unpriced_assets", "type": "int32"},
        ],
        response_name="NetWorthReply",
    )
    @action
    async def Get(self, request: Any, context: Any) -> Any:
        from apps.networth.grpc import networth_pb2

        user = require_caller(await grpc_caller(context))
        view = await sync_to_async(networth_service.net_worth)(user, timezone.now())
        return networth_pb2.NetWorthReply(
            total_minor=view.total_minor,
            wallets_minor=view.wallets_minor,
            assets_minor=view.assets_minor,
            debts_minor=view.debts_minor,
            usd_present=view.usd_minor is not None,
            usd_minor=view.usd_minor or 0,
            gold_grams=view.gold_grams,
            stale=view.stale,
            unconverted=view.unconverted,
            unpriced_assets=view.unpriced_assets,
        )

    @grpc_action(
        request=[],
        response=[{"name": "baskets", "type": BasketMsg, "cardinality": "repeated"}],
        response_name="BasketListReply",
    )
    @action
    async def ListBaskets(self, request: Any, context: Any) -> Any:
        from apps.networth.grpc import networth_pb2

        user = require_caller(await grpc_caller(context))
        views = await sync_to_async(networth_service.list_baskets)(user, timezone.now())
        return networth_pb2.BasketListReply(baskets=[_basket(v) for v in views])

    @grpc_action(
        request=[
            {"name": "name", "type": "string"},
            {"name": "target_minor", "type": "int64"},
            {"name": "items", "type": BasketItemRefMsg, "cardinality": "repeated"},
            {"name": "client_mutation_id", "type": "string"},
        ],
        request_name="BasketCreate",
        response=BASKET_REPLY,
        response_name="BasketReply",
    )
    @action
    async def CreateBasket(self, request: Any, context: Any) -> Any:
        from apps.networth.grpc import networth_pb2

        user = require_caller(await grpc_caller(context))
        view = await sync_to_async(networth_service.create_basket)(
            user,
            name=request.name,
            target_minor=request.target_minor,
            items=[BasketItemRef(i.kind, i.ref_id) for i in request.items],
            client_mutation_id=request.client_mutation_id,
            now=timezone.now(),
        )
        return networth_pb2.BasketReply(basket=_basket(view))

    @grpc_action(
        request=[{"name": "basket_id", "type": "string"}],
        request_name="BasketRef",
        response=[],
    )
    @action
    async def DeleteBasket(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        await sync_to_async(networth_service.delete_basket)(user, request.basket_id)
        return Empty()


GRPC_SERVICES = [NetWorthService]
