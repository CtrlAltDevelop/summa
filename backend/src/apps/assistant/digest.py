"""The daily accounting hour and the digest the reminder is built from.

All "today" arithmetic is Tehran time. The server only says *whether and what*
to remind; showing a notification is the device's job.
"""

from dataclasses import dataclass
from datetime import UTC, datetime, time, timedelta
from typing import Any, Final

from django.db.models import Q

from apps.assistant.calendar import TEHRAN
from apps.assistant.models import UserPreference
from apps.recurring.service import recurring_service
from apps.wallets.models import EventKind, LedgerEvent
from apps.wallets.validation import refuse

NO_REMINDER: Final = -1
_LAST_HOUR: Final = 23
_RECORDED: Final = (EventKind.INCOME, EventKind.EXPENSE)


@dataclass(frozen=True, slots=True)
class DigestView:
    accounting_hour: int  # -1 = off
    entries_today: int
    uncategorized_today: int
    due_questions: int
    low_balance_warnings: int
    should_remind: bool


class DigestService:
    def accounting_hour(self, user: Any) -> int:
        pref = UserPreference.objects.filter(user=user).first()
        return NO_REMINDER if pref is None or pref.accounting_hour is None else pref.accounting_hour

    def set_accounting_hour(self, user: Any, hour: int) -> None:
        if hour != NO_REMINDER and not 0 <= hour <= _LAST_HOUR:
            raise refuse("The hour is 0 to 23, or -1 to turn the reminder off.")
        UserPreference.objects.update_or_create(
            user=user, defaults={"accounting_hour": None if hour == NO_REMINDER else hour}
        )

    def digest(self, user: Any, now: datetime) -> DigestView:
        local = now.astimezone(TEHRAN)
        start = datetime.combine(local.date(), time(0), TEHRAN).astimezone(UTC)
        today = LedgerEvent.objects.filter(
            user=user,
            voided=False,
            kind__in=_RECORDED,
            occurred_at__gte=start,
            occurred_at__lt=start + timedelta(days=1),
        )
        entries = today.count()
        uncategorized = today.filter(Q(category__isnull=True) | Q(category__is_other=True)).count()
        cycles = recurring_service.list(user, now).occurrences
        due = sum(1 for c in cycles if c.status == "due")
        low = sum(1 for c in cycles if c.low_balance)
        hour = self.accounting_hour(user)
        needs_attention = due > 0 or uncategorized > 0 or entries == 0
        return DigestView(
            accounting_hour=hour,
            entries_today=entries,
            uncategorized_today=uncategorized,
            due_questions=due,
            low_balance_warnings=low,
            should_remind=hour != NO_REMINDER and local.hour >= hour and needs_attention,
        )


digest_service = DigestService()
