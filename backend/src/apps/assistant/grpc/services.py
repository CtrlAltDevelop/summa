"""The private assistant chat over gRPC. Every call is scoped to the caller."""

from typing import Any

from asgiref.sync import sync_to_async
from django.utils import timezone
from django_socio_grpc import generics
from django_socio_grpc.decorators import grpc_action
from google.protobuf.empty_pb2 import Empty

from apps.assistant.chat import MessageView, chat_service
from apps.assistant.digest import digest_service
from apps.assistant.grpc.serializers import Message
from apps.assistant.sms import SmsResult, sms_service
from infrastructure.common.grpc.errors import action, require_caller
from infrastructure.common.identity import grpc_caller

REPLY = [{"name": "messages", "type": Message, "cardinality": "repeated"}]


def _message(view: MessageView) -> Any:
    from apps.assistant.grpc import assistant_pb2

    card = view.card or {}
    return assistant_pb2.Message(
        id=view.id,
        role=view.role,
        text=view.text,
        created_at=view.created_at.isoformat(),
        card_present=view.card is not None,
        card=assistant_pb2.Card(
            kind=card.get("kind", ""),
            amount_minor=card.get("amount_minor", 0),
            currency=card.get("currency", ""),
            wallet_id=card.get("wallet_id", ""),
            to_wallet_id=card.get("to_wallet_id", ""),
            category_id=card.get("category_id", ""),
            note=card.get("note", ""),
            occurred_at=card.get("occurred_at", ""),
        ),
    )


def _reply(views: list[MessageView]) -> Any:
    from apps.assistant.grpc import assistant_pb2

    return assistant_pb2.ChatReply(messages=[_message(v) for v in views])


class AssistantService(generics.GenericService):
    @grpc_action(
        request=[
            {"name": "text", "type": "string"},
            {"name": "client_mutation_id", "type": "string"},
        ],
        request_name="MessageSend",
        response=REPLY,
        response_name="ChatReply",
    )
    @action
    async def Send(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        views = await sync_to_async(chat_service.send)(
            user, text=request.text, client_mutation_id=request.client_mutation_id
        )
        return _reply(views)

    @grpc_action(
        request=[{"name": "limit", "type": "int32"}],
        request_name="HistoryQuery",
        response=REPLY,
        response_name="ChatReply",
    )
    @action
    async def History(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        views = await sync_to_async(chat_service.history)(user, limit=request.limit)
        return _reply(views)

    @grpc_action(request=[], response=[])
    @action
    async def Clear(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        await sync_to_async(chat_service.clear)(user)
        return Empty()

    @grpc_action(
        request=[{"name": "text", "type": "string"}],
        request_name="SmsText",
        response=[
            {"name": "ignored", "type": "string"},
            {"name": "kind", "type": "string"},
            {"name": "amount_minor", "type": "int64"},
            {"name": "currency", "type": "string"},
            {"name": "wallet_id", "type": "string"},
            {"name": "confidence", "type": "string"},
            {"name": "occurred_at", "type": "string"},
            {"name": "balance_present", "type": "bool"},
            {"name": "balance_minor", "type": "int64"},
            {"name": "last4", "type": "string"},
            {"name": "category_id", "type": "string"},
            {"name": "suggested_category_ids", "type": "string", "cardinality": "repeated"},
            {"name": "duplicate_entry_id", "type": "string"},
        ],
        response_name="SmsCard",
    )
    @action
    async def ParseSms(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        result = await sync_to_async(sms_service.parse)(user, request.text)
        return _sms_card(result)

    @grpc_action(
        request=[
            {"name": "last4", "type": "string"},
            {"name": "wallet_id", "type": "string"},
        ],
        request_name="CardLink",
        response=[],
    )
    @action
    async def LinkCard(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        await sync_to_async(sms_service.link_card)(
            user, last4=request.last4, wallet_id=request.wallet_id
        )
        return Empty()

    @grpc_action(
        request=[],
        response=[
            # Tehran hour 0-23, or -1 when the reminder is off.
            {"name": "accounting_hour", "type": "int32"},
            {"name": "entries_today", "type": "int32"},
            {"name": "uncategorized_today", "type": "int32"},
            {"name": "due_questions", "type": "int32"},
            {"name": "low_balance_warnings", "type": "int32"},
            {"name": "should_remind", "type": "bool"},
        ],
        response_name="DigestReply",
    )
    @action
    async def Digest(self, request: Any, context: Any) -> Any:
        from apps.assistant.grpc import assistant_pb2

        user = require_caller(await grpc_caller(context))
        view = await sync_to_async(digest_service.digest)(user, timezone.now())
        return assistant_pb2.DigestReply(
            accounting_hour=view.accounting_hour,
            entries_today=view.entries_today,
            uncategorized_today=view.uncategorized_today,
            due_questions=view.due_questions,
            low_balance_warnings=view.low_balance_warnings,
            should_remind=view.should_remind,
        )

    @grpc_action(
        request=[{"name": "hour", "type": "int32"}],
        request_name="AccountingHour",
        response=[],
    )
    @action
    async def SetAccountingHour(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        await sync_to_async(digest_service.set_accounting_hour)(user, request.hour)
        return Empty()


def _sms_card(result: SmsResult) -> Any:
    from apps.assistant.grpc import assistant_pb2

    return assistant_pb2.SmsCard(
        ignored=result.ignored,
        kind=result.kind,
        amount_minor=result.amount_minor,
        currency=result.currency,
        wallet_id=result.wallet_id,
        confidence=result.confidence,
        occurred_at=result.occurred_at.isoformat() if result.occurred_at else "",
        balance_present=result.balance_minor is not None,
        balance_minor=result.balance_minor or 0,
        last4=result.last4,
        category_id=result.category_id,
        suggested_category_ids=result.suggested_category_ids,
        duplicate_entry_id=result.duplicate_entry_id,
    )


GRPC_SERVICES = [AssistantService]
