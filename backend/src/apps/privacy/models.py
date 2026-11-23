from django.conf import settings
from django.db import models


class UserPrivacy(models.Model):
    """Per-user privacy choices that the server enforces."""

    user = models.OneToOneField(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="+", primary_key=True
    )
    # Chat messages older than this many days are deleted by `prune_chats`; 0 keeps them.
    chat_retention_days = models.PositiveSmallIntegerField(default=0)

    def __str__(self) -> str:
        return f"{self.user_id}: chat kept {self.chat_retention_days or 'forever'} days"
