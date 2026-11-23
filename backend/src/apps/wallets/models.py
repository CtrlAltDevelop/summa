import uuid

from django.conf import settings
from django.db import models
from django.db.models import Q

from apps.wallets.profile import KINDS


class Wallet(models.Model):
    """A place money sits: cash, a bank account, a card. The balance is never stored."""

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="+")
    name = models.CharField(max_length=60)
    kind = models.CharField(max_length=20, choices=[(k, k) for k in KINDS])
    currency = models.CharField(max_length=8)
    bank = models.CharField(max_length=40, blank=True)
    archived = models.BooleanField(default=False)
    client_mutation_id = models.CharField(max_length=64)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["created_at", "id"]
        constraints = [
            models.UniqueConstraint(
                fields=["user", "client_mutation_id"], name="wallet_mutation_once_per_user"
            )
        ]

    def __str__(self) -> str:
        return f"{self.name} ({self.currency})"


class EventKind(models.TextChoices):
    OPENING_BALANCE = "opening_balance"


class Direction(models.TextChoices):
    IN = "in"
    OUT = "out"


class LedgerEvent(models.Model):
    """One append-only movement. Only the opening balance exists until phase 02."""

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="+")
    wallet = models.ForeignKey(Wallet, on_delete=models.CASCADE, related_name="events")
    kind = models.CharField(max_length=20, choices=EventKind.choices)
    direction = models.CharField(max_length=3, choices=Direction.choices)
    amount_minor = models.BigIntegerField()
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["created_at", "id"]
        constraints = [
            models.CheckConstraint(condition=Q(amount_minor__gt=0), name="event_amount_positive")
        ]

    def __str__(self) -> str:
        return f"{self.kind} {self.direction} {self.amount_minor}"
