import uuid

from django.conf import settings
from django.db import models
from django.db.models import Q


class Rate(models.Model):
    """The last known price of one symbol, in toman per unit. One row per symbol."""

    symbol = models.CharField(max_length=16, unique=True)
    price = models.DecimalField(max_digits=30, decimal_places=6)
    source = models.CharField(max_length=40)
    fetched_at = models.DateTimeField()

    def __str__(self) -> str:
        return f"{self.symbol} {self.price} ({self.source})"


class Asset(models.Model):
    """Something the user holds: a catalog symbol priced by the rates, or a custom one."""

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="+")
    # Empty for a custom asset, which is valued by manual_price_minor.
    symbol = models.CharField(max_length=16, blank=True)
    name = models.CharField(max_length=60)
    manual_price_minor = models.BigIntegerField(default=0)
    realized_minor = models.BigIntegerField(default=0)
    client_mutation_id = models.CharField(max_length=64)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["created_at", "id"]
        constraints = [
            models.UniqueConstraint(
                fields=["user", "client_mutation_id"], name="asset_mutation_once_per_user"
            )
        ]

    def __str__(self) -> str:
        return self.name


class Lot(models.Model):
    """One purchase: how much, at what unit price (toman), when."""

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    asset = models.ForeignKey(Asset, on_delete=models.CASCADE, related_name="lots")
    quantity = models.DecimalField(max_digits=24, decimal_places=8)
    unit_price_minor = models.BigIntegerField()
    bought_on = models.DateField()
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["bought_on", "created_at", "id"]
        constraints = [
            models.CheckConstraint(condition=Q(quantity__gt=0), name="lot_quantity_positive"),
            models.CheckConstraint(
                condition=Q(unit_price_minor__gte=0), name="lot_price_not_negative"
            ),
        ]

    def __str__(self) -> str:
        return f"{self.quantity} @ {self.unit_price_minor}"
