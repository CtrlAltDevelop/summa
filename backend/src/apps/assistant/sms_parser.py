"""Facts out of one bank SMS. Pure: no I/O, no clock, no storage of the text.

It extracts and never decides: confidence, wallet and category are the
service's job. The amount is always read from the SMS's own digits, so a figure
that is not in the text cannot come out.
"""

import re
from dataclasses import dataclass
from datetime import datetime
from decimal import Decimal
from typing import Final

from apps.assistant.calendar import tehran_to_utc
from apps.assistant.parser import _normalize

_IGNORE: Final = {
    "otp": ("رمز پویا", "رمز یکبار", "رمز یک بار", "رمز دوم", "کد فعال", "کد تایید", "کد تأیید"),
    "failed": ("ناموفق", "لغو شد", "رد شد", "نا موفق"),
    "ad": ("تخفیف", "جایزه", "قرعه", "هدیه ویژه"),
}
_INCOME: Final = ("واریز", "دریافت", "سپرده", "حقوق", "برگشت به حساب")
_EXPENSE: Final = ("برداشت", "خرید", "پرداخت", "انتقال", "کارمزد", "قسط", "شارژ", "پایا", "ساتنا")
_BALANCE: Final = re.compile(r"(?:مانده|موجودی)[^\d]{0,12}(\d[\d.]*)(?:\s*(?:ریال|تومان|تومن))?")
_DATE: Final = re.compile(r"(\d{4})/(\d{1,2})/(\d{1,2})(?:[\s\-]+(\d{1,2}):(\d{2}))?")
_TIME: Final = re.compile(r"\b(\d{1,2}):(\d{2})\b")
_LAST4: Final = re.compile(
    r"(\d{4})\*+|\*+(\d{4})|\.{2,}\s*(\d{4})\b|(?:حساب|کارت)[^\d\n]{0,12}(?:\d{6,12})?(\d{4})\b"
)
_AMOUNT: Final = re.compile(r"([+\-]?)(\d[\d.]*)(?:\s*(ریال|تومان|تومن))?")
_MIN_AMOUNT_DIGITS: Final = 3


@dataclass(frozen=True, slots=True)
class SmsFacts:
    ignored: str = ""  # "", otp, failed, ad, no_amount
    kind: str = ""  # expense | income | "" when unknown
    amount: Decimal = Decimal(0)
    unit: str = "IRR"  # IRR | IRT, as the SMS says (rial by default)
    last4: str = ""
    balance: Decimal | None = None
    occurred_at: datetime | None = None
    evidence: str = ""  # the exact text the amount came from


def _kind(text: str, sign: str) -> str:
    if sign == "+":
        return "income"
    if sign == "-":
        return "expense"
    income = any(w in text for w in _INCOME)
    expense = any(w in text for w in _EXPENSE)
    if income and not expense:
        return "income"
    if expense and not income:
        return "expense"
    return ""


def _strip(pattern: re.Pattern[str], text: str) -> str:
    return pattern.sub(" ", text)


def parse_sms(sms: str) -> SmsFacts:
    text = _normalize(sms)
    for reason, words in _IGNORE.items():
        if any(w in text for w in words):
            return SmsFacts(ignored=reason)

    balance_match = _BALANCE.search(text)
    balance = Decimal(balance_match.group(1)) if balance_match else None
    last4_match = _LAST4.search(text)
    last4 = next((g for g in last4_match.groups() if g), "") if last4_match else ""
    date_match = _DATE.search(text)
    when = None
    if date_match:
        year, month, day, hour, minute = date_match.groups()
        when = tehran_to_utc(int(year), int(month), int(day), int(hour or 0), int(minute or 0))

    rest = text
    for pattern in (_BALANCE, _DATE, _LAST4, _TIME):
        rest = _strip(pattern, rest)
    candidates = [
        m for m in _AMOUNT.finditer(rest) if len(m.group(2).rstrip(".")) >= _MIN_AMOUNT_DIGITS
    ]
    chosen = next((m for m in candidates if m.group(3)), candidates[0] if candidates else None)
    if chosen is None:
        return SmsFacts(ignored="no_amount")
    try:
        amount = Decimal(chosen.group(2).rstrip("."))
    except ArithmeticError:
        return SmsFacts(ignored="no_amount")
    if amount <= 0:
        return SmsFacts(ignored="no_amount")
    unit = "IRT" if chosen.group(3) in ("تومان", "تومن") else "IRR"
    return SmsFacts(
        kind=_kind(rest, chosen.group(1)),
        amount=amount,
        unit=unit,
        last4=last4,
        balance=balance,
        occurred_at=when,
        evidence=chosen.group(0).strip(),
    )
