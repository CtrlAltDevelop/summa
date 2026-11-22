"""SMS-code sign-in over gRPC: refusals must carry a real status, not UNKNOWN."""

from collections.abc import Callable
from typing import Any

import grpc
import pytest

from infrastructure.auth.core import delivery
from infrastructure.auth.sms_code.grpc import auth_sms_code_pb2 as pb2
from infrastructure.auth.sms_code.grpc import auth_sms_code_pb2_grpc as pb2_grpc

Stub = pb2_grpc.SmsCodeControllerStub
PHONE = "09123456789"


def _start(grpc_call: Callable[..., Any], phone: str = PHONE) -> Any:
    return grpc_call(Stub, "LoginStart", pb2.LoginStartRequest(phone=phone))


def test_a_local_number_gets_a_masked_challenge(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    reply = _start(grpc_call)

    assert reply.destination == "***6789"
    assert delivery.outbox[-1].destination == "+989123456789"


def test_the_right_code_signs_in(transactional_db: None, grpc_call: Callable[..., Any]) -> None:
    ticket = _start(grpc_call).ticket
    code = delivery.outbox[-1].body.rsplit(": ", 1)[1]

    reply = grpc_call(Stub, "LoginVerify", pb2.LoginVerifyRequest(ticket=ticket, code=code))

    assert reply.credentials.access_token
    assert reply.credentials.refresh_token


def test_a_wrong_code_is_invalid_argument(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    ticket = _start(grpc_call).ticket

    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(Stub, "LoginVerify", pb2.LoginVerifyRequest(ticket=ticket, code="000000"))

    assert refusal.value.code() is grpc.StatusCode.INVALID_ARGUMENT
    assert "INVALID_CODE" in refusal.value.details()


def test_an_unreadable_number_is_invalid_argument(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    sent_before = len(delivery.outbox)

    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        _start(grpc_call, "not a number")

    assert refusal.value.code() is grpc.StatusCode.INVALID_ARGUMENT
    assert len(delivery.outbox) == sent_before


def test_asking_again_inside_the_cooldown_is_resource_exhausted(
    transactional_db: None, grpc_call: Callable[..., Any], settings: Any
) -> None:
    settings.AUTH_RESEND_COOLDOWN_SECONDS = 60
    _start(grpc_call)

    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        _start(grpc_call)

    assert refusal.value.code() is grpc.StatusCode.RESOURCE_EXHAUSTED
