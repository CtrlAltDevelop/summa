import uuid

from django.conf import settings
from django.db import models
from django.db.models import Q


class ChatMessage(models.Model):
    """One message in a user's private chat. The assistant's replies live here too."""

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="+")
    role = models.CharField(max_length=10, choices=[("user", "user"), ("assistant", "assistant")])
    text = models.TextField()
    # A suggested entry (kind, amount, wallet, category...). The assistant only
    # suggests: registering it is the app's own ordinary request.
    card = models.JSONField(null=True, blank=True)
    reply_to = models.ForeignKey(
        "self", null=True, blank=True, on_delete=models.CASCADE, related_name="+"
    )
    client_mutation_id = models.CharField(max_length=64, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["created_at", "id"]
        constraints = [
            models.UniqueConstraint(
                fields=["user", "client_mutation_id"],
                condition=~Q(client_mutation_id=""),
                name="chat_mutation_once_per_user",
            )
        ]

    def __str__(self) -> str:
        return f"{self.role}: {self.text[:30]}"


class SmsCardLink(models.Model):
    """Which wallet a bank card (by its last four digits) belongs to, once confirmed.

    The only thing kept from an SMS: the SMS text itself is never stored.
    """

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="+")
    last4 = models.CharField(max_length=4)
    wallet = models.ForeignKey("wallets.Wallet", on_delete=models.CASCADE, related_name="+")

    class Meta:
        constraints = [
            models.UniqueConstraint(fields=["user", "last4"], name="sms_card_once_per_user")
        ]

    def __str__(self) -> str:
        return f"****{self.last4} -> {self.wallet_id}"
