"""The private chat: store the user's message, answer with a suggestion card.

The assistant never writes to the ledger. Its card is a suggestion; the app's
"register" button sends the ordinary record (or transfer) request.
"""

import time
from dataclasses import dataclass
from datetime import datetime
from typing import Any

from django.core.cache import cache
from django.db import IntegrityError, transaction
from django.utils import timezone

from apps.assistant.models import ChatMessage
from apps.assistant.parser import CategoryRef, ParseContext, ParsedCard, WalletRef, parse
from apps.wallets.categories import category_service
from apps.wallets.models import Wallet
from apps.wallets.profile import CURRENCIES
from apps.wallets.validation import refuse
from infrastructure.common.errors import ApiError
from infrastructure.common.responses import ResponseTitle

MAX_TEXT_LENGTH = 500
RATE_LIMIT_PER_MINUTE = 30
DEFAULT_LIMIT = 50
MAX_LIMIT = 200
_SECONDS_PER_MINUTE = 60

_FA_DIGITS = str.maketrans("0123456789", "۰۱۲۳۴۵۶۷۸۹")
_CURRENCY_FA = {
    "IRT": "تومان",
    "IRR": "ریال",
    "USD": "دلار",
    "EUR": "یورو",
    "AED": "درهم",
    "TRY": "لیر",
    "USDT": "تتر",
}
_KIND_FA = {"expense": "خرج", "income": "درآمد", "transfer": "انتقال"}
_HELP = "مبلغی پیدا نکردم. مثلاً بنویس: «۲۵۰ هزار تومن خرید نان» یا «حقوق گرفتم ۲۰ میلیون تومن»."
_CROSS_HELP = "برای انتقال بین دو ارز از فرم «انتقال بین کیف‌ها» استفاده کن تا نرخ را خودت بنویسی."


@dataclass(frozen=True, slots=True)
class MessageView:
    id: str
    role: str
    text: str
    created_at: datetime
    card: dict[str, Any] | None


def _view(message: ChatMessage) -> MessageView:
    return MessageView(
        str(message.id), message.role, message.text, message.created_at, message.card
    )


def _fa_amount(minor: int, currency: str) -> str:
    decimals = CURRENCIES[currency]
    whole, fraction = divmod(minor, 10**decimals)
    text = f"{whole:,}".replace(",", "٬")
    if decimals:
        text += f"٫{fraction:0{decimals}d}"
    return f"{text} {_CURRENCY_FA[currency]}".translate(_FA_DIGITS)


def _card(card: ParsedCard) -> dict[str, Any]:
    return {
        "kind": card.kind,
        "amount_minor": card.amount_minor,
        "currency": card.currency,
        "wallet_id": card.wallet_id,
        "to_wallet_id": card.to_wallet_id,
        "category_id": card.category_id,
        "note": card.note,
        "occurred_at": card.occurred_at.isoformat(),
    }


def _reply_text(card: ParsedCard | None, text: str, context: ParseContext) -> str:
    if card is None:
        crossing = "انتقال" in text and len(context.wallets) > 1
        return _CROSS_HELP if crossing else _HELP
    names = {w.id: w.name for w in context.wallets} | {c.id: c.name for c in context.categories}
    parts = [f"{_KIND_FA[card.kind]} {_fa_amount(card.amount_minor, card.currency)}"]
    if card.kind == "transfer":
        parts.append(f"از {names[card.wallet_id]} به {names[card.to_wallet_id]}")
    else:
        if card.category_id:
            parts.append(names[card.category_id])
        parts.append(names[card.wallet_id] if card.wallet_id else "کیف را خودت انتخاب کن")
    return "این را ثبت کنم؟\n" + " — ".join(parts)


def _context(user: Any) -> ParseContext:
    wallets = [
        WalletRef(str(w.id), w.name, w.bank, w.currency)
        for w in Wallet.objects.filter(user=user, archived=False)
    ]
    categories = [
        CategoryRef(c.id, c.name, c.kind, c.is_other) for c in category_service.list(user)
    ]
    return ParseContext(wallets=wallets, categories=categories, now=timezone.now())


def _check_rate(user: Any) -> None:
    key = f"assistant:rate:{user.pk}:{int(time.time() // _SECONDS_PER_MINUTE)}"
    cache.add(key, 0, timeout=_SECONDS_PER_MINUTE * 2)
    if cache.incr(key) > RATE_LIMIT_PER_MINUTE:
        raise ApiError("Too many messages. Wait a moment.", 429, title=ResponseTitle.RATE_LIMITED)


class ChatService:
    def send(self, user: Any, *, text: str, client_mutation_id: str) -> list[MessageView]:
        text = text.strip()
        if not text or len(text) > MAX_TEXT_LENGTH:
            raise refuse(f"The message must be 1 to {MAX_TEXT_LENGTH} characters.")
        if not client_mutation_id or len(client_mutation_id) > 64:
            raise refuse("client_mutation_id is required (at most 64 characters).")
        existing = self._pair(user, client_mutation_id)
        if existing:
            return existing
        _check_rate(user)

        context = _context(user)
        card = parse(text, context)
        try:
            with transaction.atomic():
                mine = ChatMessage.objects.create(
                    user=user, role="user", text=text, client_mutation_id=client_mutation_id
                )
                reply = ChatMessage.objects.create(
                    user=user,
                    role="assistant",
                    text=_reply_text(card, text, context),
                    card=_card(card) if card else None,
                    reply_to=mine,
                )
        except IntegrityError:
            return self._pair(user, client_mutation_id)
        return [_view(mine), _view(reply)]

    def history(self, user: Any, *, limit: int) -> list[MessageView]:
        size = min(limit, MAX_LIMIT) if limit > 0 else DEFAULT_LIMIT
        rows = ChatMessage.objects.filter(user=user).order_by("-created_at", "-id")[:size]
        return [_view(m) for m in reversed(list(rows))]

    def clear(self, user: Any) -> None:
        ChatMessage.objects.filter(user=user).delete()

    @staticmethod
    def _pair(user: Any, client_mutation_id: str) -> list[MessageView]:
        mine = ChatMessage.objects.filter(user=user, client_mutation_id=client_mutation_id).first()
        if mine is None:
            return []
        reply = ChatMessage.objects.filter(user=user, reply_to=mine).first()
        return [_view(m) for m in (mine, reply) if m is not None]


chat_service = ChatService()
