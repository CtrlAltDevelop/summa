import uuid

from django.conf import settings
from django.db import models
from django.db.models import Q


class Recurring(models.Model):
    """An expense or income that repeats; each cycle becomes an Occurrence to answer."""

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="+")
    wallet = models.ForeignKey("wallets.Wallet", on_delete=models.CASCADE, related_name="+")
    kind = models.CharField(max_length=10, choices=[("expense", "expense"), ("income", "income")])
    # Null: a variable amount, asked for each time.
    amount_minor = models.BigIntegerField(null=True, blank=True)
    category = models.ForeignKey(
        "wallets.Category", null=True, blank=True, on_delete=models.SET_NULL, related_name="+"
    )
    note = models.CharField(max_length=200, blank=True)
    period = models.CharField(max_length=10)
    day = models.PositiveSmallIntegerField()
    auto_confirm = models.BooleanField(default=False)
    active = models.BooleanField(default=True)
    next_due = models.DateField()
    client_mutation_id = models.CharField(max_length=64)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["created_at", "id"]
        constraints = [
            models.UniqueConstraint(
                fields=["user", "client_mutation_id"], name="recurring_mutation_once_per_user"
            ),
            models.CheckConstraint(
                condition=Q(amount_minor__isnull=True) | Q(amount_minor__gt=0),
                name="recurring_amount_positive",
            ),
        ]

    def __str__(self) -> str:
        return f"{self.note or self.kind} ({self.period} {self.day})"


class Occurrence(models.Model):
    """One cycle of a Recurring: a date and a question the user answers once."""

    PENDING, CONFIRMED, CANCELLED = "pending", "confirmed", "cancelled"

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="+")
    recurring = models.ForeignKey(Recurring, on_delete=models.CASCADE, related_name="occurrences")
    due_date = models.DateField()
    amount_minor = models.BigIntegerField(null=True, blank=True)
    status = models.CharField(max_length=10, default=PENDING)
    entry_id = models.UUIDField(null=True, blank=True)

    class Meta:
        ordering = ["due_date", "id"]
        constraints = [
            models.UniqueConstraint(
                fields=["recurring", "due_date"], name="one_occurrence_per_due_date"
            )
        ]

    def __str__(self) -> str:
        return f"{self.recurring_id} {self.due_date} {self.status}"
