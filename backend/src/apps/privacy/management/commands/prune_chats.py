"""Delete chat messages older than each user's retention setting (run it daily)."""

from typing import Any

from django.core.management.base import BaseCommand
from django.utils import timezone

from apps.privacy.service import privacy_service


class Command(BaseCommand):
    help = "Apply every user's chat retention."

    def handle(self, *args: Any, **options: Any) -> None:
        deleted = privacy_service.prune_chats(timezone.now())
        self.stdout.write(f"Deleted {deleted} chat message(s).")
