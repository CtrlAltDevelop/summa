"""Recurring entries over gRPC. Every call is scoped to the caller."""

from typing import Any

from asgiref.sync import sync_to_async
from django.utils import timezone
from django_socio_grpc import generics
from django_socio_grpc.decorators import grpc_action
from google.protobuf.empty_pb2 import Empty

from apps.recurring.grpc.serializers import OccurrenceMsg, RecurringMsg
from apps.recurring.service import OccurrenceView, RecurringView, recurring_service
from infrastructure.common.grpc.errors import action, require_caller
from infrastructure.common.identity import grpc_caller


def _recurring(view: RecurringView) -> Any:
    from apps.recurring.grpc import recurring_pb2

    return recurring_pb2.RecurringMsg(
        id=view.id,
        wallet_id=view.wallet_id,
        kind=view.kind,
        amount_minor=view.amount_minor,
        currency=view.currency,
        category_id=view.category_id,
        note=view.note,
        period=view.period,
        day=view.day,
        auto_confirm=view.auto_confirm,
        active=view.active,
        next_due=view.next_due.isoformat(),
    )


def _occurrence(view: OccurrenceView) -> Any:
    from apps.recurring.grpc import recurring_pb2

    return recurring_pb2.OccurrenceMsg(
        id=view.id,
        recurring_id=view.recurring_id,
        wallet_id=view.wallet_id,
        kind=view.kind,
        amount_minor=view.amount_minor,
        currency=view.currency,
        note=view.note,
        due_date=view.due_date.isoformat(),
        status=view.status,
        low_balance=view.low_balance,
    )


class RecurringService(generics.GenericService):
    @grpc_action(
        request=[
            {"name": "wallet_id", "type": "string"},
            {"name": "kind", "type": "string"},
            # Zero: a variable amount, asked for each time.
            {"name": "amount_minor", "type": "int64"},
            {"name": "category_id", "type": "string"},
            {"name": "note", "type": "string"},
            # monthly (day of the Shamsi month, 1-31) or weekly (0 = Monday ... 6).
            {"name": "period", "type": "string"},
            {"name": "day", "type": "int32"},
            {"name": "auto_confirm", "type": "bool"},
            {"name": "client_mutation_id", "type": "string"},
        ],
        request_name="RecurringCreate",
        response=[{"name": "recurring", "type": RecurringMsg}],
        response_name="RecurringReply",
    )
    @action
    async def Create(self, request: Any, context: Any) -> Any:
        from apps.recurring.grpc import recurring_pb2

        user = require_caller(await grpc_caller(context))
        view = await sync_to_async(recurring_service.create)(
            user,
            wallet_id=request.wallet_id,
            kind=request.kind,
            amount_minor=request.amount_minor,
            category_id=request.category_id or None,
            note=request.note,
            period=request.period,
            day=request.day,
            auto_confirm=request.auto_confirm,
            client_mutation_id=request.client_mutation_id,
            now=timezone.now(),
        )
        return recurring_pb2.RecurringReply(recurring=_recurring(view))

    @grpc_action(
        request=[],
        response=[
            {"name": "recurrings", "type": RecurringMsg, "cardinality": "repeated"},
            {"name": "occurrences", "type": OccurrenceMsg, "cardinality": "repeated"},
        ],
        response_name="RecurringListReply",
    )
    @action
    async def List(self, request: Any, context: Any) -> Any:
        from apps.recurring.grpc import recurring_pb2

        user = require_caller(await grpc_caller(context))
        result = await sync_to_async(recurring_service.list)(user, timezone.now())
        return recurring_pb2.RecurringListReply(
            recurrings=[_recurring(v) for v in result.recurrings],
            occurrences=[_occurrence(v) for v in result.occurrences],
        )

    @grpc_action(
        request=[
            {"name": "recurring_id", "type": "string"},
            {"name": "active", "type": "bool"},
        ],
        request_name="RecurringActive",
        response=[],
    )
    @action
    async def SetActive(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        await sync_to_async(recurring_service.set_active)(
            user, request.recurring_id, active=request.active
        )
        return Empty()

    @grpc_action(
        request=[{"name": "recurring_id", "type": "string"}],
        request_name="RecurringRef",
        response=[],
    )
    @action
    async def Delete(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        await sync_to_async(recurring_service.delete)(user, request.recurring_id)
        return Empty()

    @grpc_action(
        request=[
            {"name": "occurrence_id", "type": "string"},
            # confirm | other_wallet | cancel
            {"name": "action", "type": "string"},
            {"name": "wallet_id", "type": "string"},
            # Needed for a variable amount; otherwise zero keeps the planned amount.
            {"name": "amount_minor", "type": "int64"},
        ],
        request_name="OccurrenceAnswer",
        response=[],
    )
    @action
    async def Resolve(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        await sync_to_async(recurring_service.resolve)(
            user,
            request.occurrence_id,
            action=request.action,
            wallet_id=request.wallet_id or None,
            amount_minor=request.amount_minor,
        )
        return Empty()


GRPC_SERVICES = [RecurringService]
