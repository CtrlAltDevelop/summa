"""Bank SMS -> a suggestion card. The SMS text is parsed and dropped, never stored.

The result is a suggestion: registering it is the app's ordinary record request.
"""

import re
from dataclasses import dataclass, field, replace
from datetime import datetime, timedelta
from decimal import ROUND_HALF_UP, Decimal
from typing import Any, Final

from django.conf import settings
from django.db.models import Count
from django.utils import timezone

from apps.assistant import llm
from apps.assistant.chat import _check_rate
from apps.assistant.models import SmsCardLink
from apps.assistant.parser import _CATEGORY_WORDS, _normalize, _tokens, _word_hit
from apps.assistant.sms_parser import SmsFacts, parse_sms
from apps.wallets.categories import category_service
from apps.wallets.models import LedgerEvent, Wallet
from apps.wallets.validation import not_found, parse_uuid, refuse

MAX_SMS_LENGTH: Final = 1000
SUGGESTIONS: Final = 3
DUPLICATE_WINDOW: Final = timedelta(minutes=5)
_FUTURE_LIMIT: Final = timedelta(days=1)
_PAST_LIMIT: Final = timedelta(days=365)
_RIAL_PER_TOMAN: Final = 10
_LAST4: Final = re.compile(r"\d{4}")


@dataclass(frozen=True, slots=True)
class SmsResult:
    ignored: str = ""
    kind: str = ""
    amount_minor: int = 0
    currency: str = ""
    wallet_id: str = ""
    confidence: str = ""  # high | medium | low
    occurred_at: datetime | None = None
    balance_minor: int | None = None
    last4: str = ""
    category_id: str = ""
    suggested_category_ids: list[str] = field(default_factory=list)
    duplicate_entry_id: str = ""


def _convert(amount: Decimal, unit: str, currency: str) -> tuple[int, bool]:
    """``amount`` (in the SMS's ``unit``) as ``currency`` minor units, and whether exact."""
    if unit == currency:
        value = amount
    elif unit == "IRR" and currency == "IRT":
        value = amount / _RIAL_PER_TOMAN
    else:  # toman text on a rial wallet
        value = amount * _RIAL_PER_TOMAN
    rounded = value.quantize(Decimal(1), rounding=ROUND_HALF_UP)
    return int(rounded), rounded == value


def _wallet_for(user: Any, last4: str) -> Wallet | None:
    if not last4:
        return None
    link = SmsCardLink.objects.filter(user=user, last4=last4).select_related("wallet").first()
    if link is None or link.wallet.archived or link.wallet.currency not in ("IRT", "IRR"):
        return None
    return link.wallet


def _suggest(user: Any, text: str, kind: str) -> list[str]:
    kind = kind or "expense"
    tokens = _tokens(_normalize(text))
    categories = [c for c in category_service.list(user) if c.kind == kind]
    by_name = {c.name: c.id for c in categories}
    picked: list[str] = []

    def add(category_id: str | None) -> None:
        if category_id and category_id not in picked and len(picked) < SUGGESTIONS:
            picked.append(category_id)

    for (word_kind, name), words in _CATEGORY_WORDS.items():
        if word_kind == kind and any(_word_hit(tokens, w) for w in words):
            add(by_name.get(name))
    used = (
        LedgerEvent.objects.filter(user=user, voided=False, kind=kind, category__isnull=False)
        .values("category_id")
        .annotate(n=Count("id"))
        .order_by("-n")
    )
    for row in used:
        add(str(row["category_id"]))
    for category in categories:
        if not category.is_other:
            add(category.id)
    return picked


def _duplicate(user: Any, wallet: Wallet | None, kind: str, minor: int, when: datetime) -> str:
    if wallet is None or not kind:
        return ""
    event = LedgerEvent.objects.filter(
        user=user,
        wallet=wallet,
        kind=kind,
        amount_minor=minor,
        voided=False,
        occurred_at__gte=when - DUPLICATE_WINDOW,
        occurred_at__lte=when + DUPLICATE_WINDOW,
    ).first()
    return str(event.id) if event else ""


def _llm_facts(text: str) -> SmsFacts | None:
    url = getattr(settings, "ASSISTANT_LLM_URL", "")
    if not url:
        return None
    return llm.extract(text, llm.ollama_transport(url, settings.ASSISTANT_LLM_MODEL))


class SmsService:
    def parse(self, user: Any, text: str) -> SmsResult:
        text = text.strip()
        if not text or len(text) > MAX_SMS_LENGTH:
            raise refuse(f"The message must be 1 to {MAX_SMS_LENGTH} characters.")
        _check_rate(user)

        facts = parse_sms(text)
        from_model = False
        if facts.ignored == "no_amount" or (not facts.ignored and not facts.kind):
            model = _llm_facts(text)
            if model is not None and facts.ignored:
                facts, from_model = model, True
            elif model is not None and model.amount == facts.amount:
                facts, from_model = replace(facts, kind=model.kind), True
        if facts.ignored:
            return SmsResult(ignored=facts.ignored)

        now = timezone.now()
        wallet = _wallet_for(user, facts.last4)
        currency = wallet.currency if wallet else "IRT"
        minor, exact = _convert(facts.amount, facts.unit, currency)
        balance = None
        if facts.balance is not None:
            balance_minor, balance_exact = _convert(facts.balance, facts.unit, currency)
            balance = balance_minor if balance_exact else None
        when = facts.occurred_at or now
        plausible = now - _PAST_LIMIT <= when <= now + _FUTURE_LIMIT
        if not facts.kind or not exact or minor <= 0 or not plausible:
            confidence = "low"
        elif wallet is None or facts.occurred_at is None or from_model:
            confidence = "medium"
        else:
            confidence = "high"
        suggestions = _suggest(user, text, facts.kind)
        return SmsResult(
            kind=facts.kind,
            amount_minor=max(minor, 0),
            currency=currency,
            wallet_id=str(wallet.id) if wallet else "",
            confidence=confidence,
            occurred_at=when,
            balance_minor=balance,
            last4=facts.last4,
            category_id=suggestions[0] if suggestions else "",
            suggested_category_ids=suggestions,
            duplicate_entry_id=_duplicate(user, wallet, facts.kind, minor, when),
        )

    def link_card(self, user: Any, *, last4: str, wallet_id: str) -> None:
        if not _LAST4.fullmatch(last4):
            raise refuse("The card needs exactly its last four digits.")
        wallet = Wallet.objects.filter(user=user, id=parse_uuid(wallet_id, "Wallet")).first()
        if wallet is None:
            raise not_found("Wallet")
        if wallet.archived:
            raise refuse("This wallet is archived.")
        SmsCardLink.objects.update_or_create(user=user, last4=last4, defaults={"wallet": wallet})


sms_service = SmsService()
