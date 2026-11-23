from collections.abc import Callable
from typing import Any

import grpc
import pytest
from django.test import Client
from google.protobuf.empty_pb2 import Empty

from apps.privacy.grpc import privacy_pb2, privacy_pb2_grpc
from apps.wallets.grpc import wallets_pb2, wallets_pb2_grpc

Stub = privacy_pb2_grpc.PrivacyControllerStub
PASSWORD = "corr3ct-horse-battery"


def sign_up(name: str) -> str:
    response = Client().post(
        "/api/v1/auth/password/signup",
        {"identifier": name, "password": PASSWORD, "email": f"{name}@example.com"},
        content_type="application/json",
    )
    assert response.status_code == 200, response.content
    return response.json()["data"]["credentials"]["access_token"]


def delete_with(grpc_call: Callable[..., Any], confirmation: str, token: str) -> Any:
    return grpc_call(
        Stub,
        "DeleteAccount",
        privacy_pb2.DeleteConfirmation(confirmation=confirmation),
        token=token,
    )


def test_chat_retention_is_stored_and_validated(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")

    before = grpc_call(Stub, "GetSettings", Empty(), token=token)
    grpc_call(Stub, "SetChatRetention", privacy_pb2.ChatRetention(days=30), token=token)
    after = grpc_call(Stub, "GetSettings", Empty(), token=token)
    with pytest.raises(grpc.aio.AioRpcError) as bad:
        grpc_call(Stub, "SetChatRetention", privacy_pb2.ChatRetention(days=999), token=token)

    assert (before.chat_retention_days, after.chat_retention_days) == (0, 30)
    assert bad.value.code() is grpc.StatusCode.INVALID_ARGUMENT


def test_deleting_the_account_removes_the_data_and_the_session(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")
    grpc_call(
        wallets_pb2_grpc.WalletsControllerStub,
        "Create",
        wallets_pb2.WalletCreate(
            name="ملی", kind="bank", currency="IRT", opening_balance_minor=5, client_mutation_id="w"
        ),
        token=token,
    )

    grpc_call(
        Stub, "DeleteAccount", privacy_pb2.DeleteConfirmation(confirmation="DELETE"), token=token
    )

    with pytest.raises(grpc.aio.AioRpcError) as after:
        grpc_call(wallets_pb2_grpc.WalletsControllerStub, "List", Empty(), token=token)
    assert after.value.code() is grpc.StatusCode.UNAUTHENTICATED
    assert Client().post(
        "/api/v1/auth/password/signin",
        {"identifier": "zoe", "password": PASSWORD},
        content_type="application/json",
    ).status_code in {400, 401, 404}


def test_a_wrong_confirmation_keeps_everything(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")

    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(
            Stub, "DeleteAccount", privacy_pb2.DeleteConfirmation(confirmation="no"), token=token
        )

    assert refusal.value.code() is grpc.StatusCode.INVALID_ARGUMENT
    assert grpc_call(Stub, "GetSettings", Empty(), token=token).chat_retention_days == 0


def test_one_user_cannot_delete_another(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    zoe, ali = sign_up("zoe"), sign_up("ali")

    grpc_call(
        Stub, "DeleteAccount", privacy_pb2.DeleteConfirmation(confirmation="DELETE"), token=ali
    )

    assert grpc_call(Stub, "GetSettings", Empty(), token=zoe).chat_retention_days == 0


def test_no_credential_is_unauthenticated(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(Stub, "DeleteAccount", privacy_pb2.DeleteConfirmation(confirmation="DELETE"))

    assert refusal.value.code() is grpc.StatusCode.UNAUTHENTICATED
