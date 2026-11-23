"""Wallets over gRPC. Scoped to the caller by the service layer: no call takes a user id."""

from datetime import datetime
from typing import Any

from asgiref.sync import sync_to_async
from django_socio_grpc import generics
from django_socio_grpc.decorators import grpc_action
from google.protobuf.empty_pb2 import Empty

from apps.wallets.grpc.serializers import CurrencyTotal, Entry, Wallet
from apps.wallets.ledger import Entry as EntryView
from apps.wallets.ledger import ledger_service
from apps.wallets.services import WalletList, WalletView, wallets_service
from infrastructure.common.errors import ApiError
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


def _when(text: str) -> datetime | None:
    """ISO-8601 from the client; empty means "now" (record) or "keep" (edit)."""
    if not text:
        return None
    try:
        parsed = datetime.fromisoformat(text)
    except ValueError:
        raise ApiError("occurred_at is not an ISO-8601 time.", 400) from None
    if parsed.tzinfo is None:
        raise ApiError("occurred_at needs a time zone offset.", 400)
    return parsed


def _entry(view: EntryView) -> Any:
    from apps.wallets.grpc import wallets_pb2

    return wallets_pb2.Entry(
        id=view.id,
        wallet_id=view.wallet_id,
        kind=view.kind,
        amount_minor=view.amount_minor,
        currency=view.currency,
        occurred_at=view.occurred_at.isoformat(),
        note=view.note,
    )


ENTRY_REPLY = [{"name": "entry", "type": Entry}]
ENTRY_FIELDS = [
    {"name": "amount_minor", "type": "int64"},
    {"name": "occurred_at", "type": "string"},
    {"name": "note", "type": "string"},
]


class LedgerService(generics.GenericService):
    @grpc_action(
        request=[
            {"name": "wallet_id", "type": "string"},
            {"name": "kind", "type": "string"},
            *ENTRY_FIELDS,
            {"name": "client_mutation_id", "type": "string"},
        ],
        request_name="EntryRecord",
        response=ENTRY_REPLY,
        response_name="EntryReply",
    )
    @action
    async def Record(self, request: Any, context: Any) -> Any:
        from apps.wallets.grpc import wallets_pb2

        user = require_caller(await grpc_caller(context))
        view = await sync_to_async(ledger_service.record)(
            user,
            wallet_id=request.wallet_id,
            kind=request.kind,
            amount_minor=request.amount_minor,
            occurred_at=_when(request.occurred_at),
            note=request.note,
            client_mutation_id=request.client_mutation_id,
        )
        return wallets_pb2.EntryReply(entry=_entry(view))

    @grpc_action(
        request=[{"name": "wallet_id", "type": "string"}, {"name": "limit", "type": "int32"}],
        request_name="EntryQuery",
        response=[{"name": "entries", "type": Entry, "cardinality": "repeated"}],
        response_name="EntryListReply",
    )
    @action
    async def List(self, request: Any, context: Any) -> Any:
        from apps.wallets.grpc import wallets_pb2

        user = require_caller(await grpc_caller(context))
        views = await sync_to_async(ledger_service.list)(
            user, wallet_id=request.wallet_id or None, limit=request.limit
        )
        return wallets_pb2.EntryListReply(entries=[_entry(v) for v in views])

    @grpc_action(
        request=[{"name": "entry_id", "type": "string"}, *ENTRY_FIELDS],
        request_name="EntryEdit",
        response=ENTRY_REPLY,
        response_name="EntryReply",
    )
    @action
    async def Edit(self, request: Any, context: Any) -> Any:
        from apps.wallets.grpc import wallets_pb2

        user = require_caller(await grpc_caller(context))
        view = await sync_to_async(ledger_service.edit)(
            user,
            request.entry_id,
            amount_minor=request.amount_minor,
            occurred_at=_when(request.occurred_at),
            note=request.note,
        )
        return wallets_pb2.EntryReply(entry=_entry(view))

    @grpc_action(
        request=[{"name": "entry_id", "type": "string"}],
        request_name="EntryRef",
        response=[],
    )
    @action
    async def Delete(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        await sync_to_async(ledger_service.delete)(user, request.entry_id)
        return Empty()


GRPC_SERVICES = [WalletsService, LedgerService]
