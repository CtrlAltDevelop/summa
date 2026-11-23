from datetime import UTC, datetime, timedelta
from typing import Any

import pytest
from django.contrib.auth import get_user_model

from apps.billing.models import Payment, Plan, Subscription
from apps.billing.providers import FakeProvider
from apps.billing.service import billing_service
from infrastructure.common.errors import ApiError

pytestmark = pytest.mark.django_db

NOW = datetime(2026, 11, 22, 9, 0, tzinfo=UTC)


def make_user(name: str = "zoe") -> Any:
    return get_user_model()._default_manager.create_user(username=name)


def plan(code: str = "monthly", days: int = 30, price: int = 100_000, active: bool = True) -> Plan:
    return Plan.objects.create(
        code=code, name=code, price_minor=price, period_days=days, active=active, sort=days
    )


def status(user: Any, now: datetime = NOW) -> Any:
    return billing_service.status(user, now)


@pytest.fixture(autouse=True)
def _defaults(settings: Any) -> None:
    settings.BILLING_TRIAL_DAYS = 14
    settings.BILLING_ENFORCED = False
    FakeProvider.approved.clear()


# --- plans -------------------------------------------------------------------------


def test_only_active_plans_are_listed_in_order() -> None:
    plan("yearly", 365)
    plan("monthly", 30)
    plan("old", 90, active=False)

    assert [p.code for p in billing_service.plans()] == ["monthly", "yearly"]


def test_nothing_is_seeded() -> None:
    assert billing_service.plans() == []


# --- trial and status --------------------------------------------------------------


def test_a_new_user_has_no_subscription_but_may_start_a_trial() -> None:
    result = status(make_user())

    assert (result.status, result.trial_available, result.days_left) == ("none", True, 0)


def test_the_trial_runs_for_the_configured_days() -> None:
    user = make_user()

    started = billing_service.start_trial(user, NOW)

    assert (started.status, started.days_left, started.can_write) == ("trial", 14, True)
    assert started.ends_at == NOW + timedelta(days=14)
    assert status(user, NOW + timedelta(days=13)).status == "trial"
    assert status(user, NOW + timedelta(days=13)).days_left == 1


def test_the_trial_is_once_only() -> None:
    user = make_user()
    billing_service.start_trial(user, NOW)

    with pytest.raises(ApiError) as again:
        billing_service.start_trial(user, NOW + timedelta(days=30))

    assert again.value.status == 400
    assert status(user, NOW + timedelta(days=30)).trial_available is False


def test_a_disabled_trial_is_refused(settings: Any) -> None:
    settings.BILLING_TRIAL_DAYS = 0

    with pytest.raises(ApiError) as refusal:
        billing_service.start_trial(make_user(), NOW)

    assert refusal.value.status == 400
    assert status(make_user("ali")).trial_available is False


def test_an_ended_trial_is_expired_and_cannot_write_when_enforced(settings: Any) -> None:
    user = make_user()
    billing_service.start_trial(user, NOW)
    later = NOW + timedelta(days=15)

    assert status(user, later).status == "expired"
    assert status(user, later).can_write is True  # enforcement is off
    settings.BILLING_ENFORCED = True
    assert status(user, later).can_write is False
    assert status(user, NOW + timedelta(days=1)).can_write is True


def test_without_any_subscription_a_user_is_not_read_only_unless_enforced(settings: Any) -> None:
    user = make_user()

    assert status(user).can_write is True
    settings.BILLING_ENFORCED = True
    assert status(user).can_write is False


def test_the_boundary_second_is_expired() -> None:
    user = make_user()
    billing_service.start_trial(user, NOW)

    assert status(user, NOW + timedelta(days=14)).status == "expired"


# --- buying ------------------------------------------------------------------------


def test_checkout_makes_a_pending_payment_with_a_gateway_reference() -> None:
    user = make_user()
    plan()

    checkout = billing_service.checkout(user, "monthly", NOW)

    payment = Payment.objects.get(pk=checkout.payment_id)
    assert (payment.status, payment.amount_minor, payment.user_id) == ("pending", 100_000, user.pk)
    assert checkout.reference == payment.reference and checkout.pay_url.endswith(payment.reference)


def test_a_verified_payment_activates_the_subscription() -> None:
    user = make_user()
    plan()
    checkout = billing_service.checkout(user, "monthly", NOW)

    result = billing_service.verify(user, checkout.reference, NOW)

    assert (result.status, result.days_left, result.plan_code) == ("active", 30, "monthly")
    assert Payment.objects.get(reference=checkout.reference).status == "paid"


def test_verifying_twice_extends_only_once() -> None:
    user = make_user()
    plan()
    checkout = billing_service.checkout(user, "monthly", NOW)

    billing_service.verify(user, checkout.reference, NOW)
    again = billing_service.verify(user, checkout.reference, NOW + timedelta(days=1))

    assert again.days_left == 29  # one month from NOW, not two


def test_buying_on_an_active_subscription_adds_to_its_end() -> None:
    user = make_user()
    plan()
    first = billing_service.checkout(user, "monthly", NOW)
    billing_service.verify(user, first.reference, NOW)
    second = billing_service.checkout(user, "monthly", NOW + timedelta(days=10))

    result = billing_service.verify(user, second.reference, NOW + timedelta(days=10))

    assert result.ends_at == NOW + timedelta(days=60)


def test_buying_after_expiry_starts_from_now() -> None:
    user = make_user()
    plan()
    billing_service.start_trial(user, NOW)
    late = NOW + timedelta(days=40)
    checkout = billing_service.checkout(user, "monthly", late)

    result = billing_service.verify(user, checkout.reference, late)

    assert (result.status, result.ends_at) == ("active", late + timedelta(days=30))


def test_buying_during_the_trial_adds_to_the_trials_end() -> None:
    user = make_user()
    plan()
    billing_service.start_trial(user, NOW)
    checkout = billing_service.checkout(user, "monthly", NOW + timedelta(days=2))

    result = billing_service.verify(user, checkout.reference, NOW + timedelta(days=2))

    assert result.ends_at == NOW + timedelta(days=14 + 30) and result.status == "active"


def test_a_payment_the_gateway_did_not_confirm_changes_nothing(settings: Any) -> None:
    user = make_user()
    plan()
    FakeProvider.decline = True
    try:
        checkout = billing_service.checkout(user, "monthly", NOW)
        result = billing_service.verify(user, checkout.reference, NOW)
    finally:
        FakeProvider.decline = False

    assert result.status == "none"
    assert Payment.objects.get(reference=checkout.reference).status == "failed"
    assert Subscription.objects.filter(user=user).count() == 0


def test_a_failed_payment_can_be_paid_by_a_new_checkout() -> None:
    user = make_user()
    plan()
    FakeProvider.decline = True
    try:
        failed = billing_service.checkout(user, "monthly", NOW)
        billing_service.verify(user, failed.reference, NOW)
    finally:
        FakeProvider.decline = False

    retry = billing_service.checkout(user, "monthly", NOW)

    assert billing_service.verify(user, retry.reference, NOW).status == "active"


def test_checkout_refuses_unknown_and_inactive_plans() -> None:
    plan("old", active=False)
    user = make_user()

    with pytest.raises(ApiError) as unknown:
        billing_service.checkout(user, "nope", NOW)
    with pytest.raises(ApiError) as inactive:
        billing_service.checkout(user, "old", NOW)

    assert (unknown.value.status, inactive.value.status) == (404, 400)


def test_verify_is_private_and_needs_a_known_reference() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    plan()
    checkout = billing_service.checkout(zoe, "monthly", NOW)

    for who, reference in ((ali, checkout.reference), (zoe, "no-such-reference")):
        with pytest.raises(ApiError) as refusal:
            billing_service.verify(who, reference, NOW)
        assert refusal.value.status == 404
    assert status(zoe).status == "none"


def test_each_user_has_their_own_subscription() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    billing_service.start_trial(zoe, NOW)

    assert (status(zoe).status, status(ali).status) == ("trial", "none")
