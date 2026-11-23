from collections.abc import Callable
from typing import Any

import grpc
import pytest
from django.test import Client

from apps.sync.grpc import sync_pb2, sync_pb2_grpc
from apps.wallets.grpc import wallets_pb2, wallets_pb2_grpc

Stub = sync_pb2_grpc.SyncControllerStub
PASSWORD = "corr3ct-horse-battery"


def sign_up(name: str) -> str:
    response = Client().post(
        "/api/v1/auth/password/signup",
        {"identifier": name, "password": PASSWORD, "email": f"{name}@example.com"},
        content_type="application/json",
    )
    assert response.status_code == 200, response.content
    return response.json()["data"]["credentials"]["access_token"]


def seed(grpc_call: Callable[..., Any], token: str, entries: int = 3) -> Any:
    wallet = grpc_call(
        wallets_pb2_grpc.WalletsControllerStub,
        "Create",
        wallets_pb2.WalletCreate(
            name="ملی",
            kind="bank",
            currency="IRT",
            opening_balance_minor=5_000,
            client_mutation_id="w",
        ),
        token=token,
    ).wallet
    for i in range(entries):
        grpc_call(
            wallets_pb2_grpc.LedgerControllerStub,
            "Record",
            wallets_pb2.EntryRecord(
                wallet_id=wallet.id, kind="expense", amount_minor=10, client_mutation_id=f"e{i}"
            ),
            token=token,
        )
    return wallet


def test_a_second_device_pages_through_everything(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")
    wallet = seed(grpc_call, token)  # opening balance + 3 expenses = 4 events
    request = sync_pb2.ChangesRequest(limit=2)
    entries: dict[str, Any] = {}

    for _ in range(10):
        reply = grpc_call(Stub, "Changes", request, token=token)
        entries.update({e.id: e for e in reply.entries})
        request = sync_pb2.ChangesRequest(
            wallets_cursor=reply.wallets_cursor,
            categories_cursor=reply.categories_cursor,
            events_cursor=reply.events_cursor,
            limit=2,
        )
        if not reply.has_more:
            break

    assert len(entries) == 4
    assert {e.wallet_id for e in entries.values()} == {wallet.id}
    assert sorted(e.kind for e in entries.values()) == [
        "expense",
        "expense",
        "expense",
        "opening_balance",
    ]


def test_a_delete_reaches_the_other_device_as_a_void(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")
    wallet = seed(grpc_call, token, entries=1)
    first = grpc_call(Stub, "Changes", sync_pb2.ChangesRequest(limit=50), token=token)
    target = next(e for e in first.entries if e.kind == "expense")
    cursors = sync_pb2.ChangesRequest(
        wallets_cursor=first.wallets_cursor,
        categories_cursor=first.categories_cursor,
        events_cursor=first.events_cursor,
        limit=50,
    )

    grpc_call(
        wallets_pb2_grpc.LedgerControllerStub,
        "Delete",
        wallets_pb2.EntryRef(entry_id=target.id),
        token=token,
    )
    again = grpc_call(Stub, "Changes", cursors, token=token)

    assert {e.id: e.voided for e in again.entries}[target.id] is True
    assert wallet.id


def test_feeds_are_private(transactional_db: None, grpc_call: Callable[..., Any]) -> None:
    zoe, ali = sign_up("zoe"), sign_up("ali")
    seed(grpc_call, zoe)

    reply = grpc_call(Stub, "Changes", sync_pb2.ChangesRequest(), token=ali)

    assert (list(reply.wallets), list(reply.entries), reply.has_more) == ([], [], False)


def test_a_bad_cursor_is_invalid_argument(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(
            Stub,
            "Changes",
            sync_pb2.ChangesRequest(events_cursor="garbage"),
            token=sign_up("zoe"),
        )

    assert refusal.value.code() is grpc.StatusCode.INVALID_ARGUMENT


def test_no_credential_is_unauthenticated(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(Stub, "Changes", sync_pb2.ChangesRequest())

    assert refusal.value.code() is grpc.StatusCode.UNAUTHENTICATED
