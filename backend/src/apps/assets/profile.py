"""The Iran profile for assets: which symbols exist and how their prices are combined.

Every price is in toman per one unit of the symbol.
"""

from dataclasses import dataclass
from typing import Final


@dataclass(frozen=True, slots=True)
class Symbol:
    name: str  # Persian display name
    unit: str  # Persian unit label
    group: str  # gold | coin | currency | crypto
    strategy: str = "first"  # first: first source that answers; median: median of all


CATALOG: Final[dict[str, Symbol]] = {
    "GOLD18": Symbol("طلای ۱۸ عیار", "گرم", "gold"),
    "COIN_EMAMI": Symbol("سکه امامی", "عدد", "coin"),
    "COIN_BAHAR": Symbol("سکه بهار آزادی", "عدد", "coin"),
    "COIN_HALF": Symbol("نیم‌سکه", "عدد", "coin"),
    "COIN_QUARTER": Symbol("ربع‌سکه", "عدد", "coin"),
    "COIN_GRAM": Symbol("سکه گرمی", "عدد", "coin"),
    "USD": Symbol("دلار", "دلار", "currency"),
    "EUR": Symbol("یورو", "یورو", "currency"),
    "AED": Symbol("درهم", "درهم", "currency"),
    "TRY": Symbol("لیر", "لیر", "currency"),
    "USDT": Symbol("تتر", "تتر", "crypto", strategy="median"),
    "BTC": Symbol("بیت‌کوین", "بیت‌کوین", "crypto", strategy="median"),
    "ETH": Symbol("اتریوم", "اتریوم", "crypto", strategy="median"),
}

#: Currency codes whose rate is the symbol of the same name (IRT is the unit itself).
CURRENCY_SYMBOLS: Final = ("USD", "EUR", "AED", "TRY", "USDT")
RIAL_PER_TOMAN: Final = 10
MAX_QUANTITY_DECIMALS: Final = 8
NAME_MAX_LENGTH: Final = 60
