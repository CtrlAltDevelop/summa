"""The change feed over gRPC. Scoped to the caller; the cursors are opaque to the client."""

from typing import Any

from asgiref.sync import sync_to_async
from django_socio_grpc import generics
from django_socio_grpc.decorators import grpc_action

from apps.sync.grpc.serializers import SyncCategoryMsg, SyncEntryMsg, SyncWalletMsg
from apps.sync.service import Cursors, sync_service
from infrastructure.common.grpc.errors import action, require_caller
from infrastructure.common.identity import grpc_caller


class SyncService(generics.GenericService):
    @grpc_action(
        request=[
            # Opaque positions from the previous reply; empty means "from the start".
            {"name": "wallets_cursor", "type": "string"},
            {"name": "categories_cursor", "type": "string"},
            {"name": "events_cursor", "type": "string"},
            {"name": "limit", "type": "int32"},
        ],
        request_name="ChangesRequest",
        response=[
            {"name": "wallets", "type": SyncWalletMsg, "cardinality": "repeated"},
            {"name": "categories", "type": SyncCategoryMsg, "cardinality": "repeated"},
            {"name": "entries", "type": SyncEntryMsg, "cardinality": "repeated"},
            {"name": "wallets_cursor", "type": "string"},
            {"name": "categories_cursor", "type": "string"},
            {"name": "events_cursor", "type": "string"},
            # Keep asking (with the new cursors) while this is true.
            {"name": "has_more", "type": "bool"},
        ],
        response_name="ChangesReply",
    )
    @action
    async def Changes(self, request: Any, context: Any) -> Any:
        from apps.sync.grpc import sync_pb2

        user = require_caller(await grpc_caller(context))
        page = await sync_to_async(sync_service.changes)(
            user,
            Cursors(request.wallets_cursor, request.categories_cursor, request.events_cursor),
            limit=request.limit,
        )
        return sync_pb2.ChangesReply(
            wallets=[
                sync_pb2.SyncWalletMsg(
                    id=w.id,
                    name=w.name,
                    kind=w.kind,
                    currency=w.currency,
                    bank=w.bank,
                    archived=w.archived,
                )
                for w in page.wallets
            ],
            categories=[
                sync_pb2.SyncCategoryMsg(id=c.id, name=c.name, kind=c.kind, is_other=c.is_other)
                for c in page.categories
            ],
            entries=[
                sync_pb2.SyncEntryMsg(
                    id=e.id,
                    wallet_id=e.wallet_id,
                    kind=e.kind,
                    direction=e.direction,
                    amount_minor=e.amount_minor,
                    occurred_at=e.occurred_at.isoformat(),
                    note=e.note,
                    category_id=e.category_id,
                    outside_totals=e.outside_totals,
                    split_id=e.split_id,
                    transfer_id=e.transfer_id,
                    refund_of=e.refund_of,
                    voided=e.voided,
                )
                for e in page.entries
            ],
            wallets_cursor=page.cursors.wallets,
            categories_cursor=page.cursors.categories,
            events_cursor=page.cursors.events,
            has_more=page.has_more,
        )


GRPC_SERVICES = [SyncService]
