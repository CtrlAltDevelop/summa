"""Plans, the trial, buying, and what an expired account may do."""

import math
from dataclasses import dataclass
from datetime import datetime, timedelta
from typing import Any

from django.conf import settings
from django.db import transaction
from django.utils.module_loading import import_string

from apps.billing.models import Payment, Plan, Subscription
from apps.billing.providers import PaymentProvider
from apps.wallets.validation import not_found, refuse

_SECONDS_PER_DAY = 86_400


@dataclass(frozen=True, slots=True)
class PlanView:
    code: str
    name: str
    description: str
    price_minor: int
    period_days: int


@dataclass(frozen=True, slots=True)
class StatusView:
    status: str  # none | trial | active | expired
    ends_at: datetime | None
    days_left: int
    plan_code: str
    can_write: bool
    trial_available: bool


@dataclass(frozen=True, slots=True)
class CheckoutView:
    payment_id: str
    reference: str
    pay_url: str


def _provider() -> PaymentProvider:
    provider: PaymentProvider = import_string(settings.BILLING_PROVIDER)()
    return provider


def _trial_days() -> int:
    return int(getattr(settings, "BILLING_TRIAL_DAYS", 14))


def _enforced() -> bool:
    return bool(getattr(settings, "BILLING_ENFORCED", False))


class BillingService:
    def plans(self) -> list[PlanView]:
        return [
            PlanView(p.code, p.name, p.description, p.price_minor, p.period_days)
            for p in Plan.objects.filter(active=True)
        ]

    def status(self, user: Any, now: datetime) -> StatusView:
        sub = Subscription.objects.filter(user=user).select_related("plan").first()
        if sub is None:
            return StatusView(
                status="none",
                ends_at=None,
                days_left=0,
                plan_code="",
                can_write=not _enforced(),
                trial_available=_trial_days() > 0,
            )
        running = sub.ends_at > now
        remaining = (sub.ends_at - now).total_seconds()
        return StatusView(
            status=sub.status if running else "expired",
            ends_at=sub.ends_at,
            days_left=math.ceil(remaining / _SECONDS_PER_DAY) if running else 0,
            plan_code=sub.plan.code if sub.plan else "",
            can_write=running or not _enforced(),
            trial_available=False,
        )

    def can_write(self, user: Any, now: datetime) -> bool:
        return self.status(user, now).can_write

    def start_trial(self, user: Any, now: datetime) -> StatusView:
        days = _trial_days()
        if days <= 0:
            raise refuse("There is no trial.")
        with transaction.atomic():
            _, created = Subscription.objects.get_or_create(
                user=user,
                defaults={
                    "status": Subscription.TRIAL,
                    "started_at": now,
                    "ends_at": now + timedelta(days=days),
                },
            )
        if not created:
            raise refuse("The trial can only be used once.")
        return self.status(user, now)

    def checkout(self, user: Any, plan_code: str, now: datetime) -> CheckoutView:
        plan = Plan.objects.filter(code=plan_code).first()
        if plan is None:
            raise not_found("Plan")
        if not plan.active:
            raise refuse("This plan is not for sale.")
        payment = Payment.objects.create(
            user=user,
            plan=plan,
            amount_minor=plan.price_minor,
            period_days=plan.period_days,
        )
        reference, pay_url = _provider().start(payment)
        payment.reference = reference
        payment.save(update_fields=["reference"])
        return CheckoutView(str(payment.id), reference, pay_url)

    def verify(self, user: Any, reference: str, now: datetime) -> StatusView:
        """Trust the gateway, never the client: ask it, then extend once."""
        with transaction.atomic():
            payment = (
                Payment.objects.select_for_update()
                .select_related("plan")
                .filter(user=user, reference=reference)
                .first()
            )
            if payment is None:
                raise not_found("Payment")
            if payment.status == Payment.PAID:
                return self.status(user, now)
            if not _provider().verify(reference):
                payment.status = Payment.FAILED
                payment.save(update_fields=["status"])
                return self.status(user, now)
            payment.status = Payment.PAID
            payment.paid_at = now
            payment.save(update_fields=["status", "paid_at"])
            self._extend(user, payment, now)
        return self.status(user, now)

    @staticmethod
    def _extend(user: Any, payment: Payment, now: datetime) -> None:
        sub = Subscription.objects.select_for_update().filter(user=user).first()
        start = max(now, sub.ends_at) if sub is not None else now
        ends = start + timedelta(days=payment.period_days)
        Subscription.objects.update_or_create(
            user=user,
            defaults={
                "status": Subscription.ACTIVE,
                "plan": payment.plan,
                "started_at": sub.started_at if sub else now,
                "ends_at": ends,
            },
        )


billing_service = BillingService()
