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


def test_parse_sms_link_card_and_register_over_the_wire(
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
    sms = "برداشت 500,000 ریال\nکارت 1234****\nمانده 2,500,000 ریال"

    first = grpc_call(Stub, "ParseSms", assistant_pb2.SmsText(text=sms), token=token)
    grpc_call(
        Stub, "LinkCard", assistant_pb2.CardLink(last4="1234", wallet_id=wallet.id), token=token
    )
    linked = grpc_call(Stub, "ParseSms", assistant_pb2.SmsText(text=sms), token=token)

    assert (first.wallet_id, first.confidence) == ("", "medium")
    assert (linked.kind, linked.amount_minor, linked.currency) == ("expense", 50_000, "IRT")
    assert linked.wallet_id == wallet.id and linked.balance_present
    assert linked.balance_minor == 250_000
    assert len(linked.suggested_category_ids) == 3
    # the app registers it with the ordinary record request
    entry = grpc_call(
        wallets_pb2_grpc.LedgerControllerStub,
        "Record",
        wallets_pb2.EntryRecord(
            wallet_id=linked.wallet_id,
            kind=linked.kind,
            amount_minor=linked.amount_minor,
            category_id=linked.suggested_category_ids[0],
            occurred_at=linked.occurred_at,
            client_mutation_id="reg",
        ),
        token=token,
    ).entry
    assert entry.amount_minor == 50_000


def test_an_otp_sms_is_reported_as_ignored(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    reply = grpc_call(
        Stub, "ParseSms", assistant_pb2.SmsText(text="رمز پویا 123456"), token=sign_up("zoe")
    )

    assert reply.ignored == "otp" and reply.amount_minor == 0


def test_link_card_is_private_and_validated(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    zoe, ali = sign_up("zoe"), sign_up("ali")
    wallet = grpc_call(
        wallets_pb2_grpc.WalletsControllerStub,
        "Create",
        wallets_pb2.WalletCreate(
            name="ملی", kind="bank", currency="IRT", opening_balance_minor=0, client_mutation_id="w"
        ),
        token=zoe,
    ).wallet

    with pytest.raises(grpc.aio.AioRpcError) as foreign:
        grpc_call(
            Stub, "LinkCard", assistant_pb2.CardLink(last4="1234", wallet_id=wallet.id), token=ali
        )
    with pytest.raises(grpc.aio.AioRpcError) as bad:
        grpc_call(
            Stub, "LinkCard", assistant_pb2.CardLink(last4="12", wallet_id=wallet.id), token=zoe
        )

    assert foreign.value.code() is grpc.StatusCode.NOT_FOUND
    assert bad.value.code() is grpc.StatusCode.INVALID_ARGUMENT


def test_hour_and_digest_over_the_wire(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")

    before = grpc_call(Stub, "Digest", Empty(), token=token)
    grpc_call(Stub, "SetAccountingHour", assistant_pb2.AccountingHour(hour=0), token=token)
    after = grpc_call(Stub, "Digest", Empty(), token=token)

    assert (before.accounting_hour, before.should_remind) == (-1, False)
    assert (after.accounting_hour, after.entries_today) == (0, 0)
    assert after.should_remind is True  # hour 0 has passed, nothing recorded today


def test_a_bad_hour_is_invalid_argument(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(
            Stub,
            "SetAccountingHour",
            assistant_pb2.AccountingHour(hour=24),
            token=sign_up("zoe"),
        )

    assert refusal.value.code() is grpc.StatusCode.INVALID_ARGUMENT
