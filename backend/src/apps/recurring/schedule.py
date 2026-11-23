"""When a recurring entry next falls due. Pure date arithmetic, no I/O.

Monthly means a day of the *Shamsi* month; a day the month does not have (the
31st in a 30-day month, the 30th in Esfand) falls on the month's last day.
Weekly uses Python's weekday (0 = Monday).
"""

from datetime import date

from apps.assistant.calendar import gregorian_to_jalali, jalali_month_length, jalali_to_gregorian

MONTHLY = "monthly"
WEEKLY = "weekly"
PERIODS = (MONTHLY, WEEKLY)
_DAYS_IN_WEEK = 7
_MONTHS_IN_YEAR = 12


def valid_day(period: str, day: int) -> bool:
    if period == MONTHLY:
        return 1 <= day <= 31
    return period == WEEKLY and 0 <= day < _DAYS_IN_WEEK


def _clamped(jy: int, jm: int, day: int) -> date:
    year, month, dom = jalali_to_gregorian(jy, jm, min(day, jalali_month_length(jy, jm)))
    return date(year, month, dom)


def next_due(period: str, day: int, from_date: date) -> date:
    """The first due date on or after ``from_date``."""
    if period == WEEKLY:
        from datetime import timedelta

        return from_date + timedelta(days=(day - from_date.weekday()) % _DAYS_IN_WEEK)
    jy, jm, _ = gregorian_to_jalali(from_date.year, from_date.month, from_date.day)
    candidate = _clamped(jy, jm, day)
    if candidate >= from_date:
        return candidate
    jy, jm = (jy + 1, 1) if jm == _MONTHS_IN_YEAR else (jy, jm + 1)
    return _clamped(jy, jm, day)
