"""Prices: pluggable sources, a validated refresh, and currency conversion.

The server owns the rates and every client reads them from here; a price is
approximate (this app is not an exchange). With no source configured, prices
are set by hand with ``manage.py set_rate``.
"""

import json
import statistics
import urllib.request
from collections.abc import Sequence
from dataclasses import dataclass, field
from datetime import datetime
from decimal import ROUND_HALF_UP, Decimal, InvalidOperation
from typing import Any, Final, Protocol

from django.conf import settings
from django.utils import timezone

from apps.assets.models import Rate
from apps.assets.profile import CATALOG, RIAL_PER_TOMAN
from apps.wallets.profile import CURRENCIES
from apps.wallets.validation import not_found, refuse

_TIMEOUT_SECONDS: Final = 15
_DEFAULT_STALE_SECONDS: Final = 21600
_ONE: Final = Decimal(1)


class RateSource(Protocol):
    name: str

    def fetch(self, symbols: Sequence[str]) -> dict[str, Decimal]:
        """Prices (toman per unit) for the symbols it knows. Raise ``OSError`` if it is down."""
        ...


class HttpJsonSource:
    """A JSON endpoint whose fields are picked out by dotted path."""

    def __init__(self, name: str, url: str, mapping: dict[str, str]) -> None:
        self.name, self._url, self._mapping = name, url, mapping

    def fetch(self, symbols: Sequence[str]) -> dict[str, Decimal]:
        try:
            with urllib.request.urlopen(self._url, timeout=_TIMEOUT_SECONDS) as response:  # noqa: S310
                data: Any = json.loads(response.read())
        except ValueError as error:  # not JSON: a source that answers nonsense is down
            raise OSError("The source did not return JSON.") from error
        found: dict[str, Decimal] = {}
        for symbol in symbols:
            path = self._mapping.get(symbol)
            node: Any = data
            for part in path.split(".") if path else ():
                node = node.get(part) if isinstance(node, dict) else None
            if node is None or isinstance(node, bool):
                continue
            try:
                found[symbol] = Decimal(str(node))
            except InvalidOperation:
                continue
        return found


@dataclass(frozen=True, slots=True)
class RefreshResult:
    updated: list[str] = field(default_factory=list)
    rejected: dict[str, str] = field(default_factory=dict)
    failed_sources: list[str] = field(default_factory=list)


@dataclass(frozen=True, slots=True)
class RateView:
    symbol: str
    name: str
    unit: str
    group: str
    price: Decimal | None
    known: bool
    source: str
    fetched_at: datetime | None
    age_seconds: int
    stale: bool


@dataclass(frozen=True, slots=True)
class Conversion:
    amount_minor: int
    stale: bool


def _stale_after() -> int:
    return int(getattr(settings, "ASSETS_STALE_SECONDS", _DEFAULT_STALE_SECONDS))


def _valid(value: Decimal) -> bool:
    return value.is_finite() and value > 0


class RateService:
    def configured_sources(self) -> list[RateSource]:
        return [
            HttpJsonSource(entry["name"], entry["url"], entry.get("map", {}))
            for entry in getattr(settings, "ASSETS_SOURCES", [])
        ]

    def refresh(
        self, sources: Sequence[RateSource] | None = None, now: datetime | None = None
    ) -> RefreshResult:
        now = now or timezone.now()
        used = list(self.configured_sources() if sources is None else sources)
        answers: dict[str, list[tuple[str, Decimal]]] = {}
        failed: list[str] = []
        rejected: dict[str, str] = {}
        for source in used:
            try:
                got = source.fetch(list(CATALOG))
            except OSError:
                failed.append(source.name)
                continue
            for symbol, value in got.items():
                if symbol not in CATALOG:
                    continue
                if _valid(value):
                    answers.setdefault(symbol, []).append((source.name, value))
                else:
                    rejected[symbol] = "invalid"
        updated: list[str] = []
        max_jump = Decimal(str(getattr(settings, "ASSETS_MAX_JUMP", "0.5")))
        for symbol, found in answers.items():
            if CATALOG[symbol].strategy == "median":
                name, price = "median", statistics.median(v for _, v in found)
            else:
                name, price = found[0]
            previous = self.price_of(symbol)
            if previous is not None and abs(price - previous) / previous > max_jump:
                rejected[symbol] = "jump"
                continue
            Rate.objects.update_or_create(
                symbol=symbol, defaults={"price": price, "source": name, "fetched_at": now}
            )
            updated.append(symbol)
        return RefreshResult(updated, rejected, failed)

    def set_manual(self, symbol: str, price: Decimal, *, now: datetime | None = None) -> None:
        if symbol not in CATALOG:
            raise refuse(f"Unknown symbol: {symbol}.")
        if not _valid(price):
            raise refuse("The price must be a number greater than zero.")
        Rate.objects.update_or_create(
            symbol=symbol,
            defaults={"price": price, "source": "manual", "fetched_at": now or timezone.now()},
        )

    def price_of(self, symbol: str) -> Decimal | None:
        rate = Rate.objects.filter(symbol=symbol).first()
        return rate.price if rate else None

    def list(self, now: datetime) -> list[RateView]:
        stored = {r.symbol: r for r in Rate.objects.all()}
        views = []
        for symbol, entry in CATALOG.items():
            rate = stored.get(symbol)
            age = int((now - rate.fetched_at).total_seconds()) if rate else 0
            views.append(
                RateView(
                    symbol=symbol,
                    name=entry.name,
                    unit=entry.unit,
                    group=entry.group,
                    price=rate.price if rate else None,
                    known=rate is not None,
                    source=rate.source if rate else "",
                    fetched_at=rate.fetched_at if rate else None,
                    age_seconds=age,
                    stale=rate is None or age > _stale_after(),
                )
            )
        return views

    def is_stale(self, symbol: str, now: datetime) -> bool:
        rate = Rate.objects.filter(symbol=symbol).first()
        return rate is None or (now - rate.fetched_at).total_seconds() > _stale_after()

    def convert(self, amount_minor: int, source: str, target: str, *, now: datetime) -> Conversion:
        """``amount_minor`` of ``source`` in ``target``'s minor units, through toman."""
        for code in (source, target):
            if code not in CURRENCIES:
                raise refuse(f"Unsupported currency: {code}.")
        if source == target:
            return Conversion(amount_minor, stale=False)
        stale = False

        def toman_per_unit(code: str) -> Decimal:
            nonlocal stale
            if code == "IRT":
                return _ONE
            if code == "IRR":
                return _ONE / RIAL_PER_TOMAN
            price = self.price_of(code)
            if price is None:
                raise not_found(f"No rate for {code}")
            stale = stale or self.is_stale(code, now)
            return price

        major = Decimal(amount_minor) / (Decimal(10) ** CURRENCIES[source])
        converted = major * toman_per_unit(source) / toman_per_unit(target)
        minor = (converted * (Decimal(10) ** CURRENCIES[target])).quantize(
            _ONE, rounding=ROUND_HALF_UP
        )
        return Conversion(int(minor), stale)


rate_service = RateService()
