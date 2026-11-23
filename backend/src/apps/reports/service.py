"""Monthly reports and the CSV export, read straight from the ledger.

Reports are per currency: amounts in different currencies are never added,
because there is no policy yet for which day's rate to use. The window comes
from the client (a Shamsi month), so the server needs no calendar for it.
"""

import csv
import io
from dataclasses import dataclass
from datetime import date, datetime, timedelta
from typing import Any, Final

from apps.assistant.calendar import TEHRAN, gregorian_to_jalali
from apps.wallets.models import EventKind, LedgerEvent
from apps.wallets.profile import CURRENCIES
from apps.wallets.validation import refuse

MAX_DAYS: Final = 366
MAX_EXPORT_ROWS: Final = 50_000
NO_CATEGORY: Final = "بدون دسته"
_FORMULA_STARTS: Final = ("=", "+", "-", "@", "\t", "\r")
_COUNTED: Final = (EventKind.INCOME, EventKind.EXPENSE, EventKind.REFUND)


@dataclass(frozen=True, slots=True)
class CategoryTotal:
    category_id: str  # empty for entries without a category
    name: str
    kind: str  # expense | income
    total_minor: int


@dataclass(frozen=True, slots=True)
class DayTotal:
    day: date
    income_minor: int
    expense_minor: int


@dataclass(frozen=True, slots=True)
class Report:
    currency: str
    income_minor: int
    expense_minor: int
    net_minor: int
    entries: int
    by_category: list[CategoryTotal]
    daily: list[DayTotal]
    top_expense_category: str
    #: Currencies that have counted activity in the window.
    currencies: list[str]


def _check_window(start: datetime, end: datetime) -> None:
    if start.tzinfo is None or end.tzinfo is None:
        raise refuse("The window needs a time zone offset.")
    if start >= end:
        raise refuse("The window must start before it ends.")
    if end - start > timedelta(days=MAX_DAYS):
        raise refuse(f"The window is at most {MAX_DAYS} days.")


def _tehran_day(moment: datetime) -> date:
    return moment.astimezone(TEHRAN).date()


class ReportService:
    def monthly(self, user: Any, start: datetime, end: datetime, currency: str) -> Report:
        _check_window(start, end)
        if currency not in CURRENCIES:
            raise refuse(f"Unsupported currency: {currency}.")
        events = [
            e
            for e in LedgerEvent.objects.filter(
                user=user,
                voided=False,
                kind__in=_COUNTED,
                occurred_at__gte=start,
                occurred_at__lt=end,
            ).select_related("wallet", "category")
            if not e.outside_totals
        ]
        mine = [e for e in events if e.wallet.currency == currency]
        income = sum(e.amount_minor for e in mine if e.kind == EventKind.INCOME)
        expense = sum(
            e.amount_minor if e.kind == EventKind.EXPENSE else -e.amount_minor
            for e in mine
            if e.kind != EventKind.INCOME
        )
        by_category = self._by_category(mine)
        top = next((c.name for c in by_category if c.kind == "expense" and c.total_minor > 0), "")
        return Report(
            currency=currency,
            income_minor=income,
            expense_minor=expense,
            net_minor=income - expense,
            entries=len(mine),
            by_category=by_category,
            daily=self._daily(mine, start, end),
            top_expense_category=top,
            currencies=sorted({e.wallet.currency for e in events}),
        )

    @staticmethod
    def _by_category(events: list[LedgerEvent]) -> list[CategoryTotal]:
        totals: dict[tuple[str, str], int] = {}
        names: dict[str, str] = {}
        for e in events:
            category_id = str(e.category_id or "")
            names[category_id] = e.category.name if e.category else NO_CATEGORY
            kind = "income" if e.kind == EventKind.INCOME else "expense"
            sign = -1 if e.kind == EventKind.REFUND else 1
            totals[(kind, category_id)] = totals.get((kind, category_id), 0) + sign * e.amount_minor
        rows = [
            CategoryTotal(category_id, names[category_id], kind, total)
            for (kind, category_id), total in totals.items()
        ]
        return sorted(rows, key=lambda r: (r.kind != "expense", -r.total_minor, r.name))

    @staticmethod
    def _daily(events: list[LedgerEvent], start: datetime, end: datetime) -> list[DayTotal]:
        first = _tehran_day(start)
        last = _tehran_day(end - timedelta(microseconds=1))
        days = {first + timedelta(days=n): [0, 0] for n in range((last - first).days + 1)}
        for e in events:
            bucket = days.get(_tehran_day(e.occurred_at))
            if bucket is None:  # cannot happen inside the window; never crash a report
                continue
            if e.kind == EventKind.INCOME:
                bucket[0] += e.amount_minor
            else:
                bucket[1] += e.amount_minor if e.kind == EventKind.EXPENSE else -e.amount_minor
        return [DayTotal(day, inc, exp) for day, (inc, exp) in days.items()]

    # --- CSV ----------------------------------------------------------------------

    def export_csv(self, user: Any, start: datetime | None, end: datetime | None) -> str:
        if (start is None) != (end is None):
            raise refuse("Give both ends of the range, or neither.")
        query = LedgerEvent.objects.filter(user=user, voided=False).select_related(
            "wallet", "category"
        )
        if start is not None and end is not None:
            _check_window(start, end)
            query = query.filter(occurred_at__gte=start, occurred_at__lt=end)
        events = list(query.order_by("occurred_at", "created_at", "id")[: MAX_EXPORT_ROWS + 1])
        if len(events) > MAX_EXPORT_ROWS:
            raise refuse(f"More than {MAX_EXPORT_ROWS} rows: choose a shorter range.")
        out = io.StringIO()
        writer = csv.writer(out, lineterminator="\r\n")
        writer.writerow(
            [
                "date_shamsi", "datetime_utc", "kind", "direction", "amount", "currency",
                "wallet", "category", "note", "outside_totals", "split_id", "transfer_id",
                "refund_of",
            ]
        )  # fmt: skip
        for e in events:
            writer.writerow(self._row(e))
        return "﻿" + out.getvalue()

    @staticmethod
    def _row(e: LedgerEvent) -> list[str]:
        decimals = CURRENCIES[e.wallet.currency]
        whole, fraction = divmod(e.amount_minor, 10**decimals)
        amount = f"{whole}.{fraction:0{decimals}d}" if decimals else str(whole)
        local = e.occurred_at.astimezone(TEHRAN)
        jy, jm, jd = gregorian_to_jalali(local.year, local.month, local.day)
        return [
            f"{jy:04d}/{jm:02d}/{jd:02d}",
            e.occurred_at.isoformat(),
            e.kind,
            e.direction,
            amount,
            e.wallet.currency,
            _safe(e.wallet.name),
            _safe(e.category.name if e.category else ""),
            _safe(e.note),
            "1" if e.outside_totals else "0",
            str(e.split_id or ""),
            str(e.transfer_id or ""),
            str(e.refund_of_id or ""),
        ]


def _safe(text: str) -> str:
    """Stop a spreadsheet from running a cell as a formula (CSV injection)."""
    return "'" + text if text.startswith(_FORMULA_STARTS) else text


report_service = ReportService()
