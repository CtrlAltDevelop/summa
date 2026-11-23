import uuid

from django.conf import settings
from django.db import models
from django.db.models import Q

KINDS = ("bank_loan", "installment_purchase", "personal")


class Debt(models.Model):
    """Money the user owes, repaid in installments."""

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="+")
    kind = models.CharField(max_length=24, choices=[(k, k) for k in KINDS])
    title = models.CharField(max_length=60)
    currency = models.CharField(max_length=8)
    installment_minor = models.BigIntegerField()
    count = models.PositiveSmallIntegerField()
    # Informational: what was borrowed. Zero when not given.
    principal_minor = models.BigIntegerField(default=0)
    wallet = models.ForeignKey(
        "wallets.Wallet", null=True, blank=True, on_delete=models.SET_NULL, related_name="+"
    )
    category = models.ForeignKey(
        "wallets.Category", null=True, blank=True, on_delete=models.SET_NULL, related_name="+"
    )
    client_mutation_id = models.CharField(max_length=64)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["created_at", "id"]
        constraints = [
            models.UniqueConstraint(
                fields=["user", "client_mutation_id"], name="debt_mutation_once_per_user"
            ),
            models.CheckConstraint(
                condition=Q(installment_minor__gt=0), name="debt_installment_positive"
            ),
        ]

    def __str__(self) -> str:
        return f"{self.title} ({self.count} x {self.installment_minor} {self.currency})"


class Installment(models.Model):
    PENDING, PAID = "pending", "paid"

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="+")
    debt = models.ForeignKey(Debt, on_delete=models.CASCADE, related_name="installments")
    number = models.PositiveSmallIntegerField()
    due_date = models.DateField()
    amount_minor = models.BigIntegerField()
    status = models.CharField(max_length=10, default=PENDING)
    entry_id = models.UUIDField(null=True, blank=True)
    # Counts payments of this installment, so paying again after an undo is a new entry.
    pay_attempts = models.PositiveSmallIntegerField(default=0)

    class Meta:
        ordering = ["debt", "number"]
        constraints = [
            models.UniqueConstraint(fields=["debt", "number"], name="one_installment_per_number")
        ]

    def __str__(self) -> str:
        return f"{self.debt_id} #{self.number} {self.due_date} {self.status}"
