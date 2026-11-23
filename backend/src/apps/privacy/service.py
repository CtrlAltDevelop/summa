"""Privacy: how long chat is kept, and deleting an account for real."""

from datetime import datetime, timedelta
from typing import Any, Final

from django.db import transaction

from apps.assistant.models import ChatMessage
from apps.billing.models import Payment
from apps.privacy.models import UserPrivacy
from apps.wallets.validation import refuse

MAX_RETENTION_DAYS: Final = 365
CONFIRMATION: Final = "DELETE"


class PrivacyService:
    def chat_retention_days(self, user: Any) -> int:
        row = UserPrivacy.objects.filter(user=user).first()
        return row.chat_retention_days if row else 0

    def set_chat_retention(self, user: Any, days: int) -> None:
        if not 0 <= days <= MAX_RETENTION_DAYS:
            raise refuse(f"Keep chat for 0 (forever) to {MAX_RETENTION_DAYS} days.")
        UserPrivacy.objects.update_or_create(user=user, defaults={"chat_retention_days": days})

    def prune_chats(self, now: datetime) -> int:
        """Delete every user's chat messages older than that user's own limit."""
        deleted = 0
        for row in UserPrivacy.objects.filter(chat_retention_days__gt=0):
            cutoff = now - timedelta(days=row.chat_retention_days)
            count, _ = ChatMessage.objects.filter(
                user_id=row.user_id, created_at__lt=cutoff
            ).delete()
            deleted += count
        return deleted

    def delete_account(self, user: Any, confirmation: str) -> None:
        """Remove the account and everything it owns. Only the payment receipts stay.

        Every table that points at the user cascades, so this is one delete rather
        than a list of tables to remember. Receipts are the exception by design:
        the payment keeps ``user_ref`` and loses the user.
        """
        if confirmation != CONFIRMATION:
            raise refuse(f'Type "{CONFIRMATION}" to confirm. Nothing was deleted.')
        with transaction.atomic():
            Payment.objects.filter(user=user).update(user=None, user_ref=str(user.pk))
            user.delete()


privacy_service = PrivacyService()
