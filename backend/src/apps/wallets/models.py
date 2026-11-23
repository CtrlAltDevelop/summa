import uuid

from django.conf import settings
from django.db import models
from django.db.models import Q
from django.utils import timezone

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
    INCOME = "income"
    EXPENSE = "expense"
    TRANSFER_OUT = "transfer_out"
    TRANSFER_IN = "transfer_in"


class Direction(models.TextChoices):
    IN = "in"
    OUT = "out"


class LedgerEvent(models.Model):
    """One append-only movement.

    An edit adds a replacement (``replaces``) and voids the old row; a delete only
    voids. Balances ignore voided rows, so history stays and totals stay right.
    """

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="+")
    wallet = models.ForeignKey(Wallet, on_delete=models.CASCADE, related_name="events")
    kind = models.CharField(max_length=20, choices=EventKind.choices)
    direction = models.CharField(max_length=3, choices=Direction.choices)
    amount_minor = models.BigIntegerField()
    occurred_at = models.DateTimeField(default=timezone.now)
    note = models.CharField(max_length=200, blank=True)
    voided = models.BooleanField(default=False)
    replaces = models.ForeignKey(
        "self", null=True, blank=True, on_delete=models.SET_NULL, related_name="+"
    )
    # Legs of one transfer (out, in, optional fee) share this id.
    transfer_id = models.UUIDField(null=True, blank=True, db_index=True)
    # The user-entered rate of a cross-currency transfer, kept as typed.
    rate = models.CharField(max_length=32, blank=True)
    client_mutation_id = models.CharField(max_length=64, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["created_at", "id"]
        constraints = [
            models.CheckConstraint(condition=Q(amount_minor__gt=0), name="event_amount_positive"),
            models.UniqueConstraint(
                fields=["user", "client_mutation_id"],
                condition=~Q(client_mutation_id=""),
                name="event_mutation_once_per_user",
            ),
        ]

    def __str__(self) -> str:
        return f"{self.kind} {self.direction} {self.amount_minor}"
