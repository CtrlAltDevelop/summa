import uuid

from django.conf import settings
from django.db import models
from django.db.models import Q


class Plan(models.Model):
    """Something a user can buy. Created and priced in the admin; none ship with the app."""

    code = models.SlugField(max_length=40, unique=True)
    name = models.CharField(max_length=60)
    description = models.TextField(blank=True)
    price_minor = models.BigIntegerField()  # toman
    period_days = models.PositiveIntegerField()
    active = models.BooleanField(default=True)
    sort = models.IntegerField(default=0)

    class Meta:
        ordering = ["sort", "id"]
        constraints = [
            models.CheckConstraint(condition=Q(price_minor__gte=0), name="plan_price_not_negative"),
            models.CheckConstraint(condition=Q(period_days__gt=0), name="plan_period_positive"),
        ]

    def __str__(self) -> str:
        return f"{self.name} ({self.period_days} days)"


class Subscription(models.Model):
    """One per user: a trial or a paid period ending at ``ends_at``. Data is never deleted."""

    TRIAL, ACTIVE = "trial", "active"

    user = models.OneToOneField(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="+", primary_key=True
    )
    status = models.CharField(max_length=10, choices=[(TRIAL, TRIAL), (ACTIVE, ACTIVE)])
    plan = models.ForeignKey(Plan, null=True, blank=True, on_delete=models.SET_NULL)
    started_at = models.DateTimeField()
    ends_at = models.DateTimeField()

    def __str__(self) -> str:
        return f"{self.user_id} {self.status} until {self.ends_at:%Y-%m-%d}"


class Payment(models.Model):
    PENDING, PAID, FAILED = "pending", "paid", "failed"

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="+")
    plan = models.ForeignKey(Plan, on_delete=models.PROTECT, related_name="+")
    amount_minor = models.BigIntegerField()
    period_days = models.PositiveIntegerField()
    status = models.CharField(max_length=10, default=PENDING)
    # The gateway's token; what the server verifies. Unique so one payment cannot be reused.
    reference = models.CharField(max_length=120, unique=True, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    paid_at = models.DateTimeField(null=True, blank=True)

    class Meta:
        ordering = ["-created_at"]

    def __str__(self) -> str:
        return f"{self.status} {self.amount_minor} ({self.reference})"
