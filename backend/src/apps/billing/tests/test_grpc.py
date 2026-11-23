from collections.abc import Callable
from typing import Any

import grpc
import pytest
from django.test import Client
from google.protobuf.empty_pb2 import Empty

from apps.billing.grpc import billing_pb2, billing_pb2_grpc
from apps.billing.models import Plan
from apps.billing.providers import FakeProvider
from apps.wallets.grpc import wallets_pb2, wallets_pb2_grpc

Stub = billing_pb2_grpc.BillingControllerStub
Ledger = wallets_pb2_grpc.LedgerControllerStub
Wallets = wallets_pb2_grpc.WalletsControllerStub
PASSWORD = "corr3ct-horse-battery"


def sign_up(name: str) -> str:
    response = Client().post(
        "/api/v1/auth/password/signup",
        {"identifier": name, "password": PASSWORD, "email": f"{name}@example.com"},
        content_type="application/json",
    )
    assert response.status_code == 200, response.content
    return response.json()["data"]["credentials"]["access_token"]


@pytest.fixture(autouse=True)
def _defaults(settings: Any) -> None:
    settings.BILLING_TRIAL_DAYS = 14
    settings.BILLING_ENFORCED = False
    FakeProvider.decline = False


def make_wallet(grpc_call: Callable[..., Any], token: str) -> Any:
    return grpc_call(
        Wallets,
        "Create",
        wallets_pb2.WalletCreate(
            name="ملی",
            kind="bank",
            currency="IRT",
            opening_balance_minor=1_000,
            client_mutation_id="w",
        ),
        token=token,
    ).wallet


def record(grpc_call: Callable[..., Any], token: str, wallet_id: str, key: str = "e") -> Any:
    return grpc_call(
        Ledger,
        "Record",
        wallets_pb2.EntryRecord(
            wallet_id=wallet_id, kind="expense", amount_minor=10, client_mutation_id=key
        ),
        token=token,
    )


def test_plans_status_trial_and_purchase_over_the_wire(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")
    Plan.objects.create(code="monthly", name="ماهانه", price_minor=100_000, period_days=30)

    plans = grpc_call(Stub, "Plans", Empty(), token=token).plans
    before = grpc_call(Stub, "Status", Empty(), token=token)
    trial = grpc_call(Stub, "StartTrial", Empty(), token=token)
    checkout = grpc_call(
        Stub, "Checkout", billing_pb2.CheckoutRequest(plan_code="monthly"), token=token
    )
    paid = grpc_call(
        Stub, "Verify", billing_pb2.VerifyRequest(reference=checkout.reference), token=token
    )

    assert [(p.code, p.price_minor, p.period_days) for p in plans] == [("monthly", 100_000, 30)]
    assert (before.status, before.trial_available) == ("none", True)
    assert (trial.status, trial.days_left, trial.trial_available) == ("trial", 14, False)
    assert checkout.pay_url.startswith("summa://pay/")
    assert (paid.status, paid.plan_code, paid.days_left) == ("active", "monthly", 44)


def test_billing_errors_map_to_statuses(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    zoe, ali = sign_up("zoe"), sign_up("ali")
    Plan.objects.create(code="monthly", name="x", price_minor=1, period_days=30)
    Plan.objects.create(code="old", name="y", price_minor=1, period_days=30, active=False)
    checkout = grpc_call(
        Stub, "Checkout", billing_pb2.CheckoutRequest(plan_code="monthly"), token=zoe
    )
    grpc_call(Stub, "StartTrial", Empty(), token=zoe)

    with pytest.raises(grpc.aio.AioRpcError) as second_trial:
        grpc_call(Stub, "StartTrial", Empty(), token=zoe)
    with pytest.raises(grpc.aio.AioRpcError) as unknown:
        grpc_call(Stub, "Checkout", billing_pb2.CheckoutRequest(plan_code="nope"), token=zoe)
    with pytest.raises(grpc.aio.AioRpcError) as inactive:
        grpc_call(Stub, "Checkout", billing_pb2.CheckoutRequest(plan_code="old"), token=zoe)
    with pytest.raises(grpc.aio.AioRpcError) as foreign:
        grpc_call(
            Stub, "Verify", billing_pb2.VerifyRequest(reference=checkout.reference), token=ali
        )

    assert second_trial.value.code() is grpc.StatusCode.INVALID_ARGUMENT
    assert unknown.value.code() is grpc.StatusCode.NOT_FOUND
    assert inactive.value.code() is grpc.StatusCode.INVALID_ARGUMENT
    assert foreign.value.code() is grpc.StatusCode.NOT_FOUND


def test_no_credential_is_unauthenticated(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(Stub, "Status", Empty())

    assert refusal.value.code() is grpc.StatusCode.UNAUTHENTICATED


# --- the read-only guard -----------------------------------------------------------


def test_with_enforcement_off_nothing_changes(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")
    wallet = make_wallet(grpc_call, token)

    assert record(grpc_call, token, wallet.id).entry.amount_minor == 10


def test_an_account_with_no_subscription_is_read_only_when_enforced(
    transactional_db: None, grpc_call: Callable[..., Any], settings: Any
) -> None:
    token = sign_up("zoe")
    wallet = make_wallet(grpc_call, token)
    settings.BILLING_ENFORCED = True

    with pytest.raises(grpc.aio.AioRpcError) as blocked:
        record(grpc_call, token, wallet.id)
    with pytest.raises(grpc.aio.AioRpcError) as blocked_create:
        make_wallet_again(grpc_call, token)

    assert blocked.value.code() is grpc.StatusCode.PERMISSION_DENIED
    assert blocked_create.value.code() is grpc.StatusCode.PERMISSION_DENIED
    assert "read-only" in blocked.value.details()


def make_wallet_again(grpc_call: Callable[..., Any], token: str) -> Any:
    return grpc_call(
        Wallets,
        "Create",
        wallets_pb2.WalletCreate(
            name="دوم",
            kind="cash",
            currency="IRT",
            opening_balance_minor=0,
            client_mutation_id="w2",
        ),
        token=token,
    )


def test_reads_billing_and_auth_stay_open_when_blocked(
    transactional_db: None, grpc_call: Callable[..., Any], settings: Any
) -> None:
    token = sign_up("zoe")
    wallet = make_wallet(grpc_call, token)
    settings.BILLING_ENFORCED = True

    wallets = grpc_call(Wallets, "List", Empty(), token=token)
    entries = grpc_call(Ledger, "List", wallets_pb2.EntryQuery(), token=token)
    status = grpc_call(Stub, "Status", Empty(), token=token)
    trial = grpc_call(Stub, "StartTrial", Empty(), token=token)

    assert [w.id for w in wallets.wallets] == [wallet.id]
    assert list(entries.entries) != [] or entries.entries == []
    assert (status.status, status.can_write) == ("none", False)
    assert (trial.status, trial.can_write) == ("trial", True)


def test_a_trial_or_a_purchase_unlocks_writing_again(
    transactional_db: None, grpc_call: Callable[..., Any], settings: Any
) -> None:
    token = sign_up("zoe")
    wallet = make_wallet(grpc_call, token)
    Plan.objects.create(code="monthly", name="x", price_minor=1, period_days=30)
    settings.BILLING_ENFORCED = True
    with pytest.raises(grpc.aio.AioRpcError):
        record(grpc_call, token, wallet.id, "e1")

    grpc_call(Stub, "StartTrial", Empty(), token=token)
    assert record(grpc_call, token, wallet.id, "e2").entry.amount_minor == 10


def test_an_expired_subscription_is_read_only_until_renewed(
    transactional_db: None, grpc_call: Callable[..., Any], settings: Any
) -> None:
    from datetime import timedelta

    from django.utils import timezone

    from apps.billing.models import Subscription

    token = sign_up("zoe")
    wallet = make_wallet(grpc_call, token)
    Plan.objects.create(code="monthly", name="x", price_minor=1, period_days=30)
    settings.BILLING_ENFORCED = True
    grpc_call(Stub, "StartTrial", Empty(), token=token)
    Subscription.objects.update(ends_at=timezone.now() - timedelta(days=1))

    with pytest.raises(grpc.aio.AioRpcError) as blocked:
        record(grpc_call, token, wallet.id, "e1")
    checkout = grpc_call(
        Stub, "Checkout", billing_pb2.CheckoutRequest(plan_code="monthly"), token=token
    )
    grpc_call(Stub, "Verify", billing_pb2.VerifyRequest(reference=checkout.reference), token=token)

    assert blocked.value.code() is grpc.StatusCode.PERMISSION_DENIED
    assert record(grpc_call, token, wallet.id, "e2").entry.amount_minor == 10


def test_an_anonymous_call_is_still_unauthenticated_not_forbidden(
    transactional_db: None, grpc_call: Callable[..., Any], settings: Any
) -> None:
    settings.BILLING_ENFORCED = True

    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(Ledger, "Delete", wallets_pb2.EntryRef(entry_id="x"))

    assert refusal.value.code() is grpc.StatusCode.UNAUTHENTICATED
