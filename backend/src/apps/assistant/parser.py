"""Turn one Persian sentence into a suggested entry. Pure: no I/O, no clock.

The parser only *suggests*: its result becomes a card the user confirms, and the
confirmation is the ordinary record request. The amount is read straight out of
the sentence's own digits, so a figure that is not in the text cannot appear.
Rule-based on purpose; a language model, if one is added later, must go through
the same validation (phase 05).
"""

import re
from dataclasses import dataclass
from datetime import datetime, timedelta
from decimal import Decimal
from typing import Final

from apps.wallets.profile import CURRENCIES

_DIGITS: Final = str.maketrans("۰۱۲۳۴۵۶۷۸۹٠١٢٣٤٥٦٧٨٩", "01234567890123456789")
_LETTERS: Final = str.maketrans({"ي": "ی", "ك": "ک", "‌": " "})

_MULTIPLIERS: Final = {"هزار": 1_000, "میلیون": 1_000_000, "میلیارد": 1_000_000_000}
_UNITS: Final = {
    "تومن": "IRT",
    "تومان": "IRT",
    "ریال": "IRR",
    "دلار": "USD",
    "یورو": "EUR",
    "درهم": "AED",
    "لیر": "TRY",
    "تتر": "USDT",
}
_AMOUNT: Final = re.compile(
    r"(\d+(?:\.\d+)?)\s*(" + "|".join(_MULTIPLIERS) + r")?\s*(" + "|".join(_UNITS) + r")?"
)

_INCOME_WORDS: Final = (
    "حقوق", "دریافت", "درآمد", "واریز", "گرفتم", "فروختم", "سود", "پاداش", "عیدی", "دستمزد",
)  # fmt: skip
_TRANSFER_WORDS: Final = ("انتقال", "منتقل", "جابجایی", "جابه‌جایی")
_DAYS_AGO: Final = (("پریروز", 2), ("دیروز", 1))

#: (kind, default category name) -> keywords. Matched as whole words, or as a
#: prefix for keywords of three or more letters (plural and suffix forms).
_CATEGORY_WORDS: Final[dict[tuple[str, str], tuple[str, ...]]] = {
    ("expense", "خوراک و سوپرمارکت"): (
        "نان", "سوپر", "میوه", "غذا", "گوشت", "مرغ", "لبنیات", "شیر", "ماست", "برنج", "خواربار",
    ),
    ("expense", "رستوران و کافه"): (
        "رستوران", "کافه", "قهوه", "ناهار", "شام", "صبحانه", "پیتزا", "ساندویچ",
    ),
    ("expense", "رفت‌وآمد"): ("تاکسی", "اسنپ", "تپسی", "بنزین", "مترو", "اتوبوس", "کرایه"),
    ("expense", "قبض و شارژ"): ("قبض", "شارژ", "برق", "آب", "گاز", "اینترنت"),
    ("expense", "اجاره و خانه"): ("اجاره", "رهن", "خانه"),
    ("expense", "اقساط"): ("قسط", "اقساط", "وام"),
    ("expense", "سلامت"): ("دارو", "دکتر", "درمان", "بیمارستان", "ویزیت", "آزمایش", "دندان"),
    ("expense", "آموزش"): ("کلاس", "دوره", "کتاب", "شهریه", "آموزش"),
    ("expense", "تفریح و اشتراک"): ("سینما", "نتفلیکس", "فیلیمو", "اشتراک", "بازی", "کنسرت"),
    ("expense", "خرید و پوشاک"): ("لباس", "کفش", "پوشاک"),
    ("expense", "هدیه و مهمانی"): ("هدیه", "کادو", "مهمانی"),
    ("expense", "کارمزد بانکی"): ("کارمزد",),
    ("income", "حقوق"): ("حقوق", "دستمزد"),
    ("income", "پروژه"): ("پروژه", "فریلنس"),
    ("income", "سود"): ("سود",),
    ("income", "هدیه"): ("عیدی", "هدیه"),
    ("income", "فروش دارایی"): ("فروختم", "فروش"),
}  # fmt: skip


@dataclass(frozen=True, slots=True)
class WalletRef:
    id: str
    name: str
    bank: str
    currency: str


@dataclass(frozen=True, slots=True)
class CategoryRef:
    id: str
    name: str
    kind: str
    is_other: bool


@dataclass(frozen=True, slots=True)
class ParseContext:
    wallets: list[WalletRef]
    categories: list[CategoryRef]
    now: datetime


@dataclass(frozen=True, slots=True)
class ParsedCard:
    kind: str  # expense | income | transfer
    amount_minor: int
    currency: str
    wallet_id: str  # "" when the user must choose
    to_wallet_id: str  # transfers only
    category_id: str  # "" for transfers
    note: str
    occurred_at: datetime
    evidence: str  # the exact text the amount came from


def _normalize(text: str) -> str:
    text = text.translate(_DIGITS).translate(_LETTERS).replace("٬", "").replace("٫", ".")
    text = re.sub(r"(?<=\d),(?=\d{3})", "", text)
    return re.sub(r"\s+", " ", text).strip()


def _amount(text: str) -> tuple[re.Match[str], Decimal, str | None] | None:
    """The first number that carries a unit or multiplier, else the first number."""
    matches = list(_AMOUNT.finditer(text))
    if not matches:
        return None
    chosen = next((m for m in matches if m.group(2) or m.group(3)), matches[0])
    value = Decimal(chosen.group(1)) * _MULTIPLIERS.get(chosen.group(2) or "", 1)
    return chosen, value, _UNITS.get(chosen.group(3) or "")


def _minor(value: Decimal, currency: str) -> int | None:
    minor = value * (Decimal(10) ** CURRENCIES[currency])
    if minor != minor.to_integral_value() or minor <= 0:
        return None
    return int(minor)


def _tokens(text: str) -> list[str]:
    return re.findall(r"[^\s.,!?؟،:;()\"«»]+", text)


def _word_hit(tokens: list[str], word: str) -> bool:
    return any(t == word or (len(word) >= 3 and t.startswith(word)) for t in tokens)


def _category(kind: str, tokens: list[str], categories: list[CategoryRef]) -> str:
    mine = [c for c in categories if c.kind == kind]
    for (word_kind, name), words in _CATEGORY_WORDS.items():
        if word_kind != kind or not any(_word_hit(tokens, w) for w in words):
            continue
        found = next((c for c in mine if c.name == name), None)
        if found:
            return found.id
    other = next((c for c in mine if c.is_other), None)
    return other.id if other else ""


def _mentioned(text: str, tokens: list[str], wallet: WalletRef) -> bool:
    return (len(wallet.name) >= 2 and wallet.name in text) or (
        len(wallet.bank) >= 2 and wallet.bank in tokens
    )


def _pick_wallet(
    text: str, tokens: list[str], wallets: list[WalletRef], currency: str | None
) -> WalletRef | None:
    usable = [w for w in wallets if currency is None or w.currency == currency]
    named = [w for w in usable if _mentioned(text, tokens, w)]
    for group in (named, usable):
        if len(group) == 1:
            return group[0]
        if group:
            return None
    return None


def _transfer_ends(text: str, wallets: list[WalletRef]) -> tuple[WalletRef, WalletRef] | None:
    src = next((w for w in wallets if f"از {w.name}" in text), None)
    dst = next((w for w in wallets if f"به {w.name}" in text), None)
    if src is None or dst is None or src.id == dst.id:
        return None
    return src, dst


def parse(sentence: str, context: ParseContext) -> ParsedCard | None:
    """A suggested entry for ``sentence``, or ``None`` when there is nothing to suggest."""
    text = _normalize(sentence)
    found = _amount(text) if text else None
    if found is None:
        return None
    match, value, unit = found
    tokens = _tokens(text)
    note = re.sub(r"\s+", " ", (text[: match.start()] + " " + text[match.end() :])).strip()
    when = context.now
    for word, days in _DAYS_AGO:
        if word in tokens:
            when = context.now - timedelta(days=days)
            note = re.sub(rf"\b{word}\b", "", note).strip()
            break

    if any(_word_hit(tokens, w) for w in _TRANSFER_WORDS):
        return _transfer(text, match, value, unit, context, note, when)

    kind = "income" if any(_word_hit(tokens, w) for w in _INCOME_WORDS) else "expense"
    wallet = _pick_wallet(text, tokens, context.wallets, unit)
    currency = unit or (wallet.currency if wallet else "IRT")
    if unit is None and wallet is None:
        wallet = _pick_wallet(text, tokens, context.wallets, currency)
    minor = _minor(value, currency)
    if minor is None:
        return None
    return ParsedCard(
        kind=kind,
        amount_minor=minor,
        currency=currency,
        wallet_id=wallet.id if wallet else "",
        to_wallet_id="",
        category_id=_category(kind, tokens, context.categories),
        note=note,
        occurred_at=when,
        evidence=match.group(0).strip(),
    )


def _transfer(
    text: str,
    match: re.Match[str],
    value: Decimal,
    unit: str | None,
    context: ParseContext,
    note: str,
    when: datetime,
) -> ParsedCard | None:
    ends = _transfer_ends(text, context.wallets)
    if ends is None:
        return None
    src, dst = ends
    if src.currency != dst.currency or (unit is not None and unit != src.currency):
        return None  # a cross-currency transfer needs the user's rate: the form
    minor = _minor(value, src.currency)
    if minor is None:
        return None
    return ParsedCard(
        kind="transfer",
        amount_minor=minor,
        currency=src.currency,
        wallet_id=src.id,
        to_wallet_id=dst.id,
        category_id="",
        note=note,
        occurred_at=when,
        evidence=match.group(0).strip(),
    )
