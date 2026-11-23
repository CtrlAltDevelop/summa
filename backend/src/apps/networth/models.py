import uuid

from django.conf import settings
from django.db import models
from django.db.models import Q


class Basket(models.Model):
    """A goal: a target in toman measured by the wallets and assets linked to it."""

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="+")
    name = models.CharField(max_length=60)
    target_minor = models.BigIntegerField()
    client_mutation_id = models.CharField(max_length=64)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["created_at", "id"]
        constraints = [
            models.UniqueConstraint(
                fields=["user", "client_mutation_id"], name="basket_mutation_once_per_user"
            ),
            models.CheckConstraint(condition=Q(target_minor__gt=0), name="basket_target_positive"),
        ]

    def __str__(self) -> str:
        return f"{self.name} ({self.target_minor})"


class BasketItem(models.Model):
    """A wallet or an asset counted toward a basket. It is a reference, never a copy."""

    WALLET, ASSET = "wallet", "asset"

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    basket = models.ForeignKey(Basket, on_delete=models.CASCADE, related_name="items")
    kind = models.CharField(max_length=10, choices=[(WALLET, WALLET), (ASSET, ASSET)])
    ref_id = models.UUIDField()

    class Meta:
        ordering = ["id"]
        constraints = [
            models.UniqueConstraint(fields=["basket", "kind", "ref_id"], name="one_ref_per_basket")
        ]

    def __str__(self) -> str:
        return f"{self.kind}:{self.ref_id}"
