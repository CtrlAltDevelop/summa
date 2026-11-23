"""The Iran profile for wallets: which kinds and currencies exist, and their precision.

Kept as one table rather than a multi-country system: Summa serves Iran only,
but wallets in several currencies stay. Amounts are integers in the currency's
smallest unit; ``decimals`` says how many digits of that are fractional.
"""

from typing import Final

#: code -> fractional digits. IRT (toman) is the display currency people think in.
CURRENCIES: Final[dict[str, int]] = {
    "IRT": 0,
    "IRR": 0,
    "USD": 2,
    "EUR": 2,
    "AED": 2,
    "TRY": 2,
    "USDT": 2,
}

BASE_CURRENCY: Final = "IRT"

#: The wallet kinds (data-model doc). Gold and crypto holdings come with phase 09.
KINDS: Final = ("cash", "bank", "credit_card", "bnpl", "gift_card", "crypto", "gold")

#: Kinds whose opening balance may be negative (what the user owes).
DEBT_KINDS: Final = frozenset({"credit_card", "bnpl"})

NAME_MAX_LENGTH: Final = 60
BANK_MAX_LENGTH: Final = 40

OTHER_NAME: Final = "سایر"
CATEGORY_NAME_MAX_LENGTH: Final = 40

#: Default categories every new user starts with (Iran profile). "Other" is last
#: in each list; it is the home of an entry whose category was deleted.
DEFAULT_CATEGORIES: Final[dict[str, tuple[str, ...]]] = {
    "expense": (
        "خوراک و سوپرمارکت",
        "رستوران و کافه",
        "رفت‌وآمد",
        "قبض و شارژ",
        "اجاره و خانه",
        "اقساط",
        "سلامت",
        "آموزش",
        "تفریح و اشتراک",
        "خرید و پوشاک",
        "هدیه و مهمانی",
        "کارمزد بانکی",
        OTHER_NAME,
    ),
    "income": ("حقوق", "پروژه", "هدیه", "سود", "فروش دارایی", OTHER_NAME),
}
