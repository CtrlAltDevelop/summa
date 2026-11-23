"""Privacy settings and account deletion over gRPC. Every call is scoped to the caller."""

from typing import Any

from asgiref.sync import sync_to_async
from django_socio_grpc import generics
from django_socio_grpc.decorators import grpc_action
from google.protobuf.empty_pb2 import Empty

from apps.privacy.service import privacy_service
from infrastructure.common.grpc.errors import action, require_caller
from infrastructure.common.identity import grpc_caller


class PrivacyService(generics.GenericService):
    @grpc_action(
        request=[],
        response=[
            # 0 keeps the chat forever.
            {"name": "chat_retention_days", "type": "int32"},
        ],
        response_name="PrivacySettings",
    )
    @action
    async def GetSettings(self, request: Any, context: Any) -> Any:
        from apps.privacy.grpc import privacy_pb2

        user = require_caller(await grpc_caller(context))
        days = await sync_to_async(privacy_service.chat_retention_days)(user)
        return privacy_pb2.PrivacySettings(chat_retention_days=days)

    @grpc_action(
        request=[{"name": "days", "type": "int32"}],
        request_name="ChatRetention",
        response=[],
    )
    @action
    async def SetChatRetention(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        await sync_to_async(privacy_service.set_chat_retention)(user, request.days)
        return Empty()

    @grpc_action(
        request=[
            # Must be exactly DELETE. The app asks for biometrics or the app
            # passcode before it ever sends this.
            {"name": "confirmation", "type": "string"},
        ],
        request_name="DeleteConfirmation",
        response=[],
    )
    @action
    async def DeleteAccount(self, request: Any, context: Any) -> Any:
        user = require_caller(await grpc_caller(context))
        await sync_to_async(privacy_service.delete_account)(user, request.confirmation)
        return Empty()


GRPC_SERVICES = [PrivacyService]
