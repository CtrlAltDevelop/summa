"""A stateless demo of the sentence parser for the public site.

It runs the real parser against a fixed sample account (two wallets and the
default categories), keeps nothing, and needs no sign-in, so a visitor can try the
product before making an account. Never reads or writes anyone's data.
"""

from dataclasses import dataclass
from datetime import datetime
from typing import Final

from django.core.cache import cache
from django.utils import timezone

from apps.assistant.chat import _fa_amount, _reply_text
from apps.assistant.parser import CategoryRef, ParseContext, WalletRef, parse
from apps.wallets.profile import DEFAULT_CATEGORIES, OTHER_NAME
from apps.wallets.validation import refuse
from infrastructure.common.errors import ApiError
from infrastructure.common.responses import ResponseTitle

MAX_DEMO_LENGTH: Final = 200
DEMO_RATE_PER_MINUTE: Final = 20
_SECONDS_PER_MINUTE: Final = 60

_WALLETS: Final = [
    WalletRef("sample-melli", "ملی", "ملی", "IRT"),
    WalletRef("sample-cash", "نقد", "", "IRT"),
]
_CATEGORIES: Final = [
    CategoryRef(f"{kind}-{index}", name, kind, name == OTHER_NAME)
    for kind, names in DEFAULT_CATEGORIES.items()
    for index, name in enumerate(names)
]


@dataclass(frozen=True, slots=True)
class DemoCard:
    kind: str
    amount_minor: int
    currency: str
    amount_text: str
    wallet: str
    to_wallet: str
    category: str
    note: str
    occurred_at: datetime


@dataclass(frozen=True, slots=True)
class DemoAnswer:
    reply: str
    card: DemoCard | None


def _check_rate(client: str, now: datetime) -> None:
    key = f"assistant:demo:{client}:{int(now.timestamp() // _SECONDS_PER_MINUTE)}"
    cache.add(key, 0, timeout=_SECONDS_PER_MINUTE * 2)
    if cache.incr(key) > DEMO_RATE_PER_MINUTE:
        raise ApiError("Too many tries. Wait a moment.", 429, title=ResponseTitle.RATE_LIMITED)


def demo_reply(text: str, client: str, now: datetime | None = None) -> DemoAnswer:
    text = text.strip()
    if not text or len(text) > MAX_DEMO_LENGTH:
        raise refuse(f"Write 1 to {MAX_DEMO_LENGTH} characters.")
    now = now or timezone.now()
    _check_rate(client, now)
    context = ParseContext(wallets=_WALLETS, categories=_CATEGORIES, now=now)
    card = parse(text, context)
    reply = _reply_text(card, text, context)
    if card is None:
        return DemoAnswer(reply, None)
    names = {w.id: w.name for w in _WALLETS} | {c.id: c.name for c in _CATEGORIES}
    return DemoAnswer(
        reply,
        DemoCard(
            kind=card.kind,
            amount_minor=card.amount_minor,
            currency=card.currency,
            amount_text=_fa_amount(card.amount_minor, card.currency),
            wallet=names.get(card.wallet_id, ""),
            to_wallet=names.get(card.to_wallet_id, ""),
            category=names.get(card.category_id, ""),
            note=card.note,
            occurred_at=card.occurred_at,
        ),
    )
