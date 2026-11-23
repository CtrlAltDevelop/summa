"""Shamsi (Jalali) to Gregorian, and Tehran wall-clock time to UTC."""

from datetime import UTC, datetime
from zoneinfo import ZoneInfo

TEHRAN = ZoneInfo("Asia/Tehran")


def jalali_to_gregorian(jy: int, jm: int, jd: int) -> tuple[int, int, int]:
    """The standard arithmetic conversion; valid for the years people write."""
    jy += 1595
    days = (
        -355668
        + 365 * jy
        + (jy // 33) * 8
        + ((jy % 33) + 3) // 4
        + jd
        + ((jm - 1) * 31 if jm < 7 else (jm - 7) * 30 + 186)
    )
    gy = 400 * (days // 146097)
    days %= 146097
    if days > 36524:
        days -= 1
        gy += 100 * (days // 36524)
        days %= 36524
        if days >= 365:
            days += 1
    gy += 4 * (days // 1461)
    days %= 1461
    if days > 365:
        gy += (days - 1) // 365
        days = (days - 1) % 365
    gd = days + 1
    leap = (gy % 4 == 0 and gy % 100 != 0) or gy % 400 == 0
    month_lengths = [0, 31, 29 if leap else 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    gm = 0
    while gm < 13 and gd > month_lengths[gm]:
        gd -= month_lengths[gm]
        gm += 1
    return gy, gm, gd


def tehran_to_utc(jy: int, jm: int, jd: int, hour: int = 0, minute: int = 0) -> datetime | None:
    """A Shamsi date and Tehran clock time as UTC; ``None`` if it is not a real date."""
    if not (1 <= jm <= 12 and 1 <= jd <= 31 and 0 <= hour <= 23 and 0 <= minute <= 59):
        return None
    if jm > 6 and jd > 30 or (jm == 12 and jd > 30):
        return None
    year, month, day = jalali_to_gregorian(jy, jm, jd)
    try:
        return datetime(year, month, day, hour, minute, tzinfo=TEHRAN).astimezone(UTC)
    except ValueError:
        return None


def gregorian_to_jalali(gy: int, gm: int, gd: int) -> tuple[int, int, int]:
    """The standard arithmetic conversion, inverse of :func:`jalali_to_gregorian`."""
    cumulative = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]
    gy2 = gy + 1 if gm > 2 else gy
    days = (
        355666
        + 365 * gy
        + (gy2 + 3) // 4
        - (gy2 + 99) // 100
        + (gy2 + 399) // 400
        + gd
        + cumulative[gm - 1]
    )
    jy = -1595 + 33 * (days // 12053)
    days %= 12053
    jy += 4 * (days // 1461)
    days %= 1461
    if days > 365:
        jy += (days - 1) // 365
        days = (days - 1) % 365
    if days < 186:
        jm, jd = 1 + days // 31, 1 + days % 31
    else:
        jm, jd = 7 + (days - 186) // 30, 1 + (days - 186) % 30
    return jy, jm, jd


def jalali_month_length(jy: int, jm: int) -> int:
    if jm <= 6:
        return 31
    if jm <= 11:
        return 30
    return 30 if gregorian_to_jalali(*jalali_to_gregorian(jy, 12, 30)) == (jy, 12, 30) else 29
