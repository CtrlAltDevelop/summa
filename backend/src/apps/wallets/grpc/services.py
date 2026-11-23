"""Wallets over gRPC. Scoped to the caller by the service layer: no call takes a user id."""

from typing import Any

from asgiref.sync import sync_to_async
from django_socio_grpc import generics
from django_socio_grpc.decorators import grpc_action

from apps.wallets.grpc.serializers import CurrencyTotal, Wallet
from apps.wallets.services import WalletList, WalletView, wallets_service
from infrastructure.common.grpc.errors import action, require_caller
from infrastructure.common.identity import grpc_caller

CREATE_REQUEST = [
    {"name": "name", "type": "string"},
    {"name": "kind", "type": "string"},
    {"name": "currency", "type": "string"},
    {"name": "bank", "type": "string"},
    # Smallest unit of the currency; negative only for credit card / BNPL.
    {"name": "opening_balance_minor", "type": "int64"},
    {"name": "client_mutation_id", "type": "string"},
]
LIST_RESPONSE = [
    {"name": "wallets", "type": Wallet, "cardinality": "repeated"},
    {"name": "totals", "type": CurrencyTotal, "cardinality": "repeated"},
]


def _wallet(view: WalletView) -> Any:
    from apps.wallets.grpc import wallets_pb2

    return wallets_pb2.Wallet(**{f: getattr(view, f) for f in view.__slots__})


class WalletsService(generics.GenericService):
    @grpc_action(
        request=CREATE_REQUEST,
        request_name="WalletCreate",
        response=[{"name": "wallet", "type": Wallet}],
        response_name="WalletReply",
    )
    @action
    async def Create(self, request: Any, context: Any) -> Any:
        from apps.wallets.grpc import wallets_pb2

        user = require_caller(await grpc_caller(context))
        view = await sync_to_async(wallets_service.create)(
            user,
            name=request.name,
            kind=request.kind,
            currency=request.currency,
            bank=request.bank,
            opening_balance_minor=request.opening_balance_minor,
            client_mutation_id=request.client_mutation_id,
        )
        return wallets_pb2.WalletReply(wallet=_wallet(view))

    @grpc_action(request=[], response=LIST_RESPONSE, response_name="WalletListReply")
    @action
    async def List(self, request: Any, context: Any) -> Any:
        from apps.wallets.grpc import wallets_pb2

        user = require_caller(await grpc_caller(context))
        result: WalletList = await sync_to_async(wallets_service.list)(user)
        return wallets_pb2.WalletListReply(
            wallets=[_wallet(v) for v in result.wallets],
            totals=[
                wallets_pb2.CurrencyTotal(currency=t.currency, balance_minor=t.balance_minor)
                for t in result.totals
            ],
        )

    @grpc_action(
        request=[{"name": "wallet_id", "type": "string"}],
        request_name="WalletRef",
        response=[{"name": "wallet", "type": Wallet}],
        response_name="WalletReply",
    )
    @action
    async def Archive(self, request: Any, context: Any) -> Any:
        from apps.wallets.grpc import wallets_pb2

        user = require_caller(await grpc_caller(context))
        view = await sync_to_async(wallets_service.archive)(user, request.wallet_id)
        return wallets_pb2.WalletReply(wallet=_wallet(view))


GRPC_SERVICES = [WalletsService]
