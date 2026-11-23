"""What the Summa app does with support: sign in like a user, open a ticket, talk, rate.

The desk's own tests cover who may do what; this checks the same calls work for an
account created through Summa's sign-in, with the tokens the app really holds.
"""

from collections.abc import Callable
from typing import Any

import grpc
import pytest
from django.test import Client

from apps.support.grpc import support_pb2, support_pb2_grpc

pytestmark = pytest.mark.django_db(transaction=True)

Stub = support_pb2_grpc.SupportControllerStub
PASSWORD = "corr3ct-horse-battery"


def sign_up(name: str) -> str:
    response = Client().post(
        "/api/v1/auth/password/signup",
        {"identifier": name, "password": PASSWORD, "email": f"{name}@example.com"},
        content_type="application/json",
    )
    assert response.status_code == 200, response.content
    return response.json()["data"]["credentials"]["access_token"]


def test_a_summa_user_opens_a_ticket_and_talks_in_it(grpc_call: Callable[..., Any]) -> None:
    token = sign_up("zoe")

    opened = grpc_call(
        Stub,
        "Open",
        support_pb2.OpenRequest(subject="مشکل در ثبت", body="خرج ثبت نمی‌شود"),
        token=token,
    )
    sent = grpc_call(
        Stub,
        "Send",
        support_pb2.SendRequest(ticket_id=opened.id, body="یک توضیح دیگر"),
        token=token,
    )
    thread = grpc_call(
        Stub, "Messages", support_pb2.MessagesRequest(ticket_id=opened.id), token=token
    )
    mine = grpc_call(Stub, "List", support_pb2.ListRequest(mine=True), token=token)

    assert opened.subject == "مشکل در ثبت" and opened.status
    assert [m.body for m in thread.messages] == ["خرج ثبت نمی‌شود", "یک توضیح دیگر"]
    assert sent.author.staff is False
    assert [t.id for t in mine.tickets] == [opened.id]


def test_another_summa_user_cannot_see_or_join_the_thread(grpc_call: Callable[..., Any]) -> None:
    zoe, ali = sign_up("zoe"), sign_up("ali")
    opened = grpc_call(
        Stub, "Open", support_pb2.OpenRequest(subject="خصوصی", body="متن"), token=zoe
    )

    mine = grpc_call(Stub, "List", support_pb2.ListRequest(mine=True), token=ali)
    with pytest.raises(grpc.aio.AioRpcError) as read:
        grpc_call(Stub, "Messages", support_pb2.MessagesRequest(ticket_id=opened.id), token=ali)
    with pytest.raises(grpc.aio.AioRpcError) as write:
        grpc_call(
            Stub, "Send", support_pb2.SendRequest(ticket_id=opened.id, body="سلام"), token=ali
        )

    assert list(mine.tickets) == []
    assert read.value.code() is grpc.StatusCode.NOT_FOUND
    assert write.value.code() is grpc.StatusCode.NOT_FOUND


def test_a_ticket_needs_a_subject_and_a_body(grpc_call: Callable[..., Any]) -> None:
    token = sign_up("zoe")

    for request in (
        support_pb2.OpenRequest(subject="", body="متن"),
        support_pb2.OpenRequest(subject="موضوع", body="  "),
    ):
        with pytest.raises(grpc.aio.AioRpcError) as refusal:
            grpc_call(Stub, "Open", request, token=token)
        assert refusal.value.code() is grpc.StatusCode.INVALID_ARGUMENT
