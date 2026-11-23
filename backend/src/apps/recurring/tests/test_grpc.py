from collections.abc import Callable
from typing import Any

import grpc
import pytest
from django.test import Client
from google.protobuf.empty_pb2 import Empty

from apps.recurring.grpc import recurring_pb2, recurring_pb2_grpc
from apps.wallets.grpc import wallets_pb2, wallets_pb2_grpc

Stub = recurring_pb2_grpc.RecurringControllerStub
PASSWORD = "corr3ct-horse-battery"


def sign_up(name: str) -> str:
    response = Client().post(
        "/api/v1/auth/password/signup",
        {"identifier": name, "password": PASSWORD, "email": f"{name}@example.com"},
        content_type="application/json",
    )
    assert response.status_code == 200, response.content
    return response.json()["data"]["credentials"]["access_token"]


def make_wallet(grpc_call: Callable[..., Any], token: str, balance: int = 1_000_000) -> Any:
    return grpc_call(
        wallets_pb2_grpc.WalletsControllerStub,
        "Create",
        wallets_pb2.WalletCreate(
            name="ملی",
            kind="bank",
            currency="IRT",
            opening_balance_minor=balance,
            client_mutation_id="w",
        ),
        token=token,
    ).wallet


def definition(wallet_id: str, **overrides: Any) -> Any:
    fields: dict[str, Any] = {
        "wallet_id": wallet_id,
        "kind": "expense",
        "amount_minor": 100_000,
        "note": "اجاره",
        "period": "weekly",
        "day": 0,
        "client_mutation_id": "r1",
    } | overrides
    return recurring_pb2.RecurringCreate(**fields)


def test_create_list_answer_and_the_entry_is_ordinary(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")
    wallet = make_wallet(grpc_call, token)
    # weekly on every weekday would always have a cycle in the 3-day window: use all days
    for day in range(7):
        grpc_call(
            Stub,
            "Create",
            definition(wallet.id, day=day, client_mutation_id=f"r{day}"),
            token=token,
        )

    listed = grpc_call(Stub, "List", Empty(), token=token)
    due = next(o for o in listed.occurrences if o.status == "due")
    grpc_call(
        Stub,
        "Resolve",
        recurring_pb2.OccurrenceAnswer(occurrence_id=due.id, action="confirm"),
        token=token,
    )

    entries = grpc_call(
        wallets_pb2_grpc.LedgerControllerStub, "List", wallets_pb2.EntryQuery(), token=token
    ).entries
    assert len(listed.recurrings) == 7
    assert [(e.kind, e.amount_minor, e.note) for e in entries] == [("expense", 100_000, "اجاره")]
    assert (
        grpc_call(wallets_pb2_grpc.WalletsControllerStub, "List", Empty(), token=token)
        .wallets[0]
        .balance_minor
        == 900_000
    )


def test_pause_delete_and_privacy(transactional_db: None, grpc_call: Callable[..., Any]) -> None:
    zoe, ali = sign_up("zoe"), sign_up("ali")
    wallet = make_wallet(grpc_call, zoe)
    created = grpc_call(Stub, "Create", definition(wallet.id), token=zoe).recurring

    with pytest.raises(grpc.aio.AioRpcError) as foreign:
        grpc_call(Stub, "Delete", recurring_pb2.RecurringRef(recurring_id=created.id), token=ali)
    grpc_call(
        Stub,
        "SetActive",
        recurring_pb2.RecurringActive(recurring_id=created.id, active=False),
        token=zoe,
    )
    paused = grpc_call(Stub, "List", Empty(), token=zoe).recurrings[0]
    grpc_call(Stub, "Delete", recurring_pb2.RecurringRef(recurring_id=created.id), token=zoe)

    assert foreign.value.code() is grpc.StatusCode.NOT_FOUND
    assert paused.active is False
    assert list(grpc_call(Stub, "List", Empty(), token=zoe).recurrings) == []


def test_invalid_input_and_missing_credential(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")
    wallet = make_wallet(grpc_call, token)

    with pytest.raises(grpc.aio.AioRpcError) as bad_day:
        grpc_call(Stub, "Create", definition(wallet.id, period="monthly", day=40), token=token)
    with pytest.raises(grpc.aio.AioRpcError) as anonymous:
        grpc_call(Stub, "List", Empty())

    assert bad_day.value.code() is grpc.StatusCode.INVALID_ARGUMENT
    assert anonymous.value.code() is grpc.StatusCode.UNAUTHENTICATED
