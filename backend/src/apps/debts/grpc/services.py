"""Debts and installments over gRPC. Every call is scoped to the caller."""

from datetime import date
from typing import Any

from asgiref.sync import sync_to_async
from django.utils import timezone
from django_socio_grpc import generics
from django_socio_grpc.decorators import grpc_action
from google.protobuf.empty_pb2 import Empty

from apps.debts.grpc.serializers import DebtMsg
from apps.debts.service import DebtView, debt_service
from infrastructure.common.errors import ApiError
from infrastructure.common.grpc.errors import action, require_caller
from infrastructure.common.identity import grpc_caller


def _debt(view: DebtView) -> Any:
    from apps.debts.grpc import debts_pb2

    return debts_pb2.DebtMsg(
        id=view.id,
        kind=view.kind,
        title=view.title,
        currency=view.currency,
        installment_minor=view.installment_minor,
        count=view.count,
        principal_minor=view.principal_minor,
        wallet_id=view.wallet_id,
        category_id=view.category_id,
        paid_count=view.paid_count,
        remaining_minor=view.remaining_minor,
        next_due=view.next_due.isoformat() if view.next_due else "",
        closed=view.closed,
        installments=[
            debts_pb2.InstallmentMsg(
                id=i.id,
                number=i.number,
                due_date=i.due_date.isoformat(),
                amount_minor=i.amount_minor,
                paid=i.paid,
                overdue=i.overdue,
            )
            for i in view.installments
        ],
    )


class DebtsService(generics.GenericService):
    @grpc_action(
        request=[
            # bank_loan | installment_purchase | personal
            {"name": "kind", "type": "string"},
            {"name": "title", "type": "string"},
            {"name": "currency", "type": "string"},
            {"name": "installment_minor", "type": "int64"},
            {"name": "count", "type": "int32"},
            # ISO date of the first installment; the rest fall on the same Shamsi day.
            {"name": "first_due", "type": "string"},
            {"name": "principal_minor", "type": "int64"},
            {"name": "wallet_id", "type": "string"},
            {"name": "category_id", "type": "string"},
            {"name": "client_mutation_id", "type": "string"},
        ],
        request_name="DebtCreate",
        response=[{"name": "debt", "type": DebtMsg}],
        response_name="DebtReply",
    )
    @action
    async def Create(self, request: Any, context: Any) -> Any:
        from apps.debts.grpc import debts_pb2

        user = require_caller(await grpc_caller(context))
        try:
            first_due = date.fromisoformat(request.first_due)
        except ValueError:
            raise ApiError("first_due is not an ISO date.", 400) from None
        view = await sync_to_async(debt_service.create)(
            user,
            kind=request.kind,
            title=request.title,
            currency=request.currency,
            installment_minor=request.installment_minor,
            count=request.count,
            first_due=first_due,
            principal_minor=request.principal_minor,
            wallet_id=request.wallet_id or None,
            category_id=request.category_id or None,
            client_mutation_id=request.client_mutation_id,
            now=timezone.now(),
        )
        return debts_pb2.DebtReply(debt=_debt(view))

    @grpc_action(
        request=[],
        response=[{"name": "debts", "type": DebtMsg, "cardinality": "repeated"}],
        response_name="DebtListReply",
    )
    @action
    async def List(self, request: Any, context: Any) -> Any:
        from apps.debts.grpc import debts_pb2

        user = require_caller(await grpc_caller(context))
        views = await sync_to_async(debt_service.list)(user, timezone.now())
        return debts_pb2.DebtListReply(debts=[_debt(v) for v in views])

    @grpc_action(
        request=[
            {"name": "installment_id", "type": "string"},
            # Empty: the debt's own wallet.
            {"name": "wallet_id", "type": "string"},
            # Zero: the planned installment amount.
            {"name": "amount_minor", "type": "int64"},
        ],
        request_name="InstallmentPay",
        response=[],
    )
    @action
    async def Pay(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        await sync_to_async(debt_service.pay)(
            user,
            request.installment_id,
            wallet_id=request.wallet_id or None,
            amount_minor=request.amount_minor,
            now=timezone.now(),
        )
        return Empty()

    @grpc_action(
        request=[{"name": "installment_id", "type": "string"}],
        request_name="InstallmentRef",
        response=[],
    )
    @action
    async def Unpay(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        await sync_to_async(debt_service.unpay)(user, request.installment_id)
        return Empty()

    @grpc_action(
        request=[{"name": "debt_id", "type": "string"}],
        request_name="DebtRef",
        response=[],
    )
    @action
    async def Delete(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        await sync_to_async(debt_service.delete)(user, request.debt_id)
        return Empty()


GRPC_SERVICES = [DebtsService]
