"""The private assistant chat over gRPC. Every call is scoped to the caller."""

from typing import Any

from asgiref.sync import sync_to_async
from django_socio_grpc import generics
from django_socio_grpc.decorators import grpc_action
from google.protobuf.empty_pb2 import Empty

from apps.assistant.chat import MessageView, chat_service
from apps.assistant.grpc.serializers import Message
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


GRPC_SERVICES = [AssistantService]
