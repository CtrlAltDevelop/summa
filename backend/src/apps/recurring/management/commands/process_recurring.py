"""Open the due cycles of every user's recurring entries (run it daily, e.g. from cron)."""

from typing import Any

from django.core.management.base import BaseCommand
from django.utils import timezone

from apps.recurring.service import recurring_service


class Command(BaseCommand):
    help = "Generate due occurrences and auto-confirm the ones that ask for it."

    def handle(self, *args: Any, **options: Any) -> None:
        users = recurring_service.process_all(timezone.now())
        self.stdout.write(f"Processed recurring entries for {users} user(s).")
