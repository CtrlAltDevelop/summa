"""Subscriptions over gRPC. Open to an expired account on purpose: it must be able to pay."""

from typing import Any

from asgiref.sync import sync_to_async
from django.utils import timezone
from django_socio_grpc import generics
from django_socio_grpc.decorators import grpc_action
from google.protobuf.empty_pb2 import Empty  # noqa: F401  (the proto imports it)

from apps.billing.grpc.serializers import PlanMsg
from apps.billing.service import StatusView, billing_service
from infrastructure.common.grpc.errors import action, require_caller
from infrastructure.common.identity import grpc_caller

STATUS_REPLY = [
    # none | trial | active | expired
    {"name": "status", "type": "string"},
    {"name": "ends_at", "type": "string"},
    {"name": "days_left", "type": "int32"},
    {"name": "plan_code", "type": "string"},
    {"name": "can_write", "type": "bool"},
    {"name": "trial_available", "type": "bool"},
]


def _status(view: StatusView) -> Any:
    from apps.billing.grpc import billing_pb2

    return billing_pb2.StatusReply(
        status=view.status,
        ends_at=view.ends_at.isoformat() if view.ends_at else "",
        days_left=view.days_left,
        plan_code=view.plan_code,
        can_write=view.can_write,
        trial_available=view.trial_available,
    )


class BillingService(generics.GenericService):
    @grpc_action(
        request=[],
        response=[{"name": "plans", "type": PlanMsg, "cardinality": "repeated"}],
        response_name="PlanListReply",
    )
    @action
    async def Plans(self, request: Any, context: Any) -> Any:
        from apps.billing.grpc import billing_pb2

        require_caller(await grpc_caller(context))
        views = await sync_to_async(billing_service.plans)()
        return billing_pb2.PlanListReply(
            plans=[
                billing_pb2.PlanMsg(
                    code=p.code,
                    name=p.name,
                    description=p.description,
                    price_minor=p.price_minor,
                    period_days=p.period_days,
                )
                for p in views
            ]
        )

    @grpc_action(request=[], response=STATUS_REPLY, response_name="StatusReply")
    @action
    async def Status(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        return _status(await sync_to_async(billing_service.status)(user, timezone.now()))

    @grpc_action(request=[], response=STATUS_REPLY, response_name="StatusReply")
    @action
    async def StartTrial(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        return _status(await sync_to_async(billing_service.start_trial)(user, timezone.now()))

    @grpc_action(
        request=[{"name": "plan_code", "type": "string"}],
        request_name="CheckoutRequest",
        response=[
            {"name": "payment_id", "type": "string"},
            {"name": "reference", "type": "string"},
            # Where the person pays; opening it is the app's job.
            {"name": "pay_url", "type": "string"},
        ],
        response_name="CheckoutReply",
    )
    @action
    async def Checkout(self, request: Any, context: Any) -> Any:
        from apps.billing.grpc import billing_pb2

        user = require_caller(await grpc_caller(context))
        view = await sync_to_async(billing_service.checkout)(
            user, request.plan_code, timezone.now()
        )
        return billing_pb2.CheckoutReply(
            payment_id=view.payment_id, reference=view.reference, pay_url=view.pay_url
        )

    @grpc_action(
        request=[{"name": "reference", "type": "string"}],
        request_name="VerifyRequest",
        response=STATUS_REPLY,
        response_name="StatusReply",
    )
    @action
    async def Verify(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        view = await sync_to_async(billing_service.verify)(user, request.reference, timezone.now())
        return _status(view)


GRPC_SERVICES = [BillingService]
