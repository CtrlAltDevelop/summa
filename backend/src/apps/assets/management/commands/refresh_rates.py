"""Refresh every rate from the configured sources (run it every few hours, e.g. from cron)."""

from typing import Any

from django.core.management.base import BaseCommand

from apps.assets.rates import rate_service


class Command(BaseCommand):
    help = "Fetch prices from DJANGO_ASSETS_SOURCES and store the valid ones."

    def handle(self, *args: Any, **options: Any) -> None:
        sources = rate_service.configured_sources()
        if not sources:
            self.stdout.write("No sources configured: rates are set by hand (set_rate).")
            return
        result = rate_service.refresh(sources)
        self.stdout.write(f"Updated: {', '.join(result.updated) or '-'}")
        for symbol, reason in result.rejected.items():
            self.stdout.write(f"Rejected {symbol}: {reason}")
        for name in result.failed_sources:
            self.stdout.write(f"Source down: {name}")
