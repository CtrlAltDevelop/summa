from collections.abc import Callable
from typing import Any

import grpc
import pytest
from django.test import Client
from google.protobuf.empty_pb2 import Empty

from apps.assistant.grpc import assistant_pb2, assistant_pb2_grpc
from apps.wallets.grpc import wallets_pb2, wallets_pb2_grpc

Stub = assistant_pb2_grpc.AssistantControllerStub
PASSWORD = "corr3ct-horse-battery"


def sign_up(name: str) -> str:
    response = Client().post(
        "/api/v1/auth/password/signup",
        {"identifier": name, "password": PASSWORD, "email": f"{name}@example.com"},
        content_type="application/json",
    )
    assert response.status_code == 200, response.content
    return response.json()["data"]["credentials"]["access_token"]


def test_send_returns_a_card_that_the_app_can_register(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")
    wallet = grpc_call(
        wallets_pb2_grpc.WalletsControllerStub,
        "Create",
        wallets_pb2.WalletCreate(
            name="ملی", kind="bank", currency="IRT", opening_balance_minor=0, client_mutation_id="w"
        ),
        token=token,
    ).wallet

    reply = grpc_call(
        Stub,
        "Send",
        assistant_pb2.MessageSend(text="۲۵۰ هزار تومن خرید نان", client_mutation_id="m1"),
        token=token,
    )
    card = reply.messages[1].card

    assert [m.role for m in reply.messages] == ["user", "assistant"]
    assert reply.messages[1].card_present and not reply.messages[0].card_present
    assert (card.kind, card.amount_minor, card.wallet_id) == ("expense", 250_000, wallet.id)

    # "Register" is the ordinary record request built from the card.
    entry = grpc_call(
        wallets_pb2_grpc.LedgerControllerStub,
        "Record",
        wallets_pb2.EntryRecord(
            wallet_id=card.wallet_id,
            kind=card.kind,
            amount_minor=card.amount_minor,
            category_id=card.category_id,
            note=card.note,
            client_mutation_id="reg1",
        ),
        token=token,
    ).entry
    assert entry.amount_minor == 250_000 and entry.category_id == card.category_id


def test_history_clear_and_privacy(transactional_db: None, grpc_call: Callable[..., Any]) -> None:
    zoe, ali = sign_up("zoe"), sign_up("ali")
    grpc_call(
        Stub, "Send", assistant_pb2.MessageSend(text="سلام", client_mutation_id="m"), token=zoe
    )

    assert len(grpc_call(Stub, "History", assistant_pb2.HistoryQuery(), token=zoe).messages) == 2
    assert list(grpc_call(Stub, "History", assistant_pb2.HistoryQuery(), token=ali).messages) == []
    grpc_call(Stub, "Clear", Empty(), token=zoe)
    assert list(grpc_call(Stub, "History", assistant_pb2.HistoryQuery(), token=zoe).messages) == []


def test_bad_input_and_missing_credential(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    with pytest.raises(grpc.aio.AioRpcError) as bad:
        grpc_call(
            Stub,
            "Send",
            assistant_pb2.MessageSend(text="  ", client_mutation_id="m"),
            token=sign_up("zoe"),
        )
    with pytest.raises(grpc.aio.AioRpcError) as anonymous:
        grpc_call(Stub, "History", assistant_pb2.HistoryQuery())

    assert bad.value.code() is grpc.StatusCode.INVALID_ARGUMENT
    assert anonymous.value.code() is grpc.StatusCode.UNAUTHENTICATED
