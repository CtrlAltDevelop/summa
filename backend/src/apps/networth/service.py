"""Net worth across wallets, assets and debts, and goal baskets measured by it."""

from collections import defaultdict
from dataclasses import dataclass
from datetime import datetime
from decimal import ROUND_HALF_UP, Decimal
from typing import Any, Final

from django.db import IntegrityError, transaction

from apps.assets.models import Asset
from apps.assets.rates import rate_service
from apps.assets.service import AssetView, asset_service
from apps.debts.service import debt_service
from apps.networth.models import Basket, BasketItem
from apps.wallets.models import Wallet
from apps.wallets.services import wallets_service
from apps.wallets.validation import not_found, parse_uuid, refuse
from infrastructure.common.errors import ApiError

BASE: Final = "IRT"
MAX_BASKETS: Final = 20
NAME_MAX_LENGTH: Final = 60
_GRAM_PLACES: Final = Decimal("0.001")


@dataclass(frozen=True, slots=True)
class NetWorth:
    total_minor: int
    wallets_minor: int
    assets_minor: int
    debts_minor: int
    usd_minor: int | None
    gold_grams: str  # empty when there is no gold rate
    stale: bool
    unconverted: list[str]  # currencies without a rate, left out of the totals
    unpriced_assets: int


@dataclass(frozen=True, slots=True)
class BasketItemRef:
    kind: str
    ref_id: str


@dataclass(frozen=True, slots=True)
class BasketItemView:
    kind: str
    ref_id: str
    name: str
    value_minor: int


@dataclass(frozen=True, slots=True)
class BasketView:
    id: str
    name: str
    target_minor: int
    value_minor: int
    percent: int
    items: list[BasketItemView]


class _Converter:
    """Toman conversions that remember which rates were missing or old."""

    def __init__(self, now: datetime) -> None:
        self._now = now
        self.stale = False
        self.missing: set[str] = set()

    def toman(self, amount_minor: int, currency: str) -> int:
        if currency == BASE or amount_minor == 0:
            return amount_minor
        try:
            result = rate_service.convert(amount_minor, currency, BASE, now=self._now)
        except ApiError as error:
            if error.status != 404:
                raise
            self.missing.add(currency)
            return 0
        self.stale = self.stale or result.stale
        return result.amount_minor


def _sum_by_currency(rows: list[tuple[str, int]]) -> dict[str, int]:
    totals: dict[str, int] = defaultdict(int)
    for currency, minor in rows:
        totals[currency] += minor
    return totals


def _value_of_wallet(wallet: Wallet, balance: int, converter: _Converter) -> int:
    return 0 if wallet.archived else converter.toman(balance, wallet.currency)


class NetWorthService:
    def net_worth(self, user: Any, now: datetime) -> NetWorth:
        converter = _Converter(now)
        wallets = wallets_service.list(user).wallets
        wallet_rows = [(w.currency, w.balance_minor) for w in wallets if not w.archived]
        wallets_minor = sum(
            converter.toman(minor, currency)
            for currency, minor in _sum_by_currency(wallet_rows).items()
        )
        listing = asset_service.list(user, now)
        priced = [a for a in listing.assets if a.price_known]
        converter.stale = converter.stale or any(a.stale for a in priced)
        debt_rows = [(d.currency, d.remaining_minor) for d in debt_service.list(user, now)]
        debts_minor = sum(
            converter.toman(minor, currency)
            for currency, minor in _sum_by_currency(debt_rows).items()
        )
        total = wallets_minor + listing.value_minor - debts_minor
        usd = self._in_usd(total, converter, now)
        return NetWorth(
            total_minor=total,
            wallets_minor=wallets_minor,
            assets_minor=listing.value_minor,
            debts_minor=debts_minor,
            usd_minor=usd,
            gold_grams=self._in_gold(total, converter, now),
            stale=converter.stale,
            unconverted=sorted(converter.missing),
            unpriced_assets=len(listing.assets) - len(priced),
        )

    @staticmethod
    def _in_usd(total: int, converter: _Converter, now: datetime) -> int | None:
        try:
            result = rate_service.convert(total, BASE, "USD", now=now)
        except ApiError:
            return None
        converter.stale = converter.stale or result.stale
        return result.amount_minor

    @staticmethod
    def _in_gold(total: int, converter: _Converter, now: datetime) -> str:
        price = rate_service.price_of("GOLD18")
        if price is None:
            return ""
        converter.stale = converter.stale or rate_service.is_stale("GOLD18", now)
        grams = (Decimal(total) / price).quantize(_GRAM_PLACES, rounding=ROUND_HALF_UP)
        return format(grams.normalize(), "f")

    # --- baskets ----------------------------------------------------------------

    def create_basket(
        self,
        user: Any,
        *,
        name: str,
        target_minor: int,
        items: list[BasketItemRef],
        client_mutation_id: str,
        now: datetime,
    ) -> BasketView:
        name = name.strip()
        if not client_mutation_id or len(client_mutation_id) > 64:
            raise refuse("client_mutation_id is required (at most 64 characters).")
        if not name or len(name) > NAME_MAX_LENGTH:
            raise refuse(f"The name must be 1 to {NAME_MAX_LENGTH} characters.")
        if target_minor <= 0:
            raise refuse("The target must be greater than zero.")
        self._check_items(user, items)
        if (
            not Basket.objects.filter(user=user, client_mutation_id=client_mutation_id).exists()
            and Basket.objects.filter(user=user).count() >= MAX_BASKETS
        ):
            raise refuse(f"At most {MAX_BASKETS} baskets.")
        try:
            with transaction.atomic():
                basket = Basket.objects.create(
                    user=user,
                    name=name,
                    target_minor=target_minor,
                    client_mutation_id=client_mutation_id,
                )
                BasketItem.objects.bulk_create(
                    BasketItem(basket=basket, kind=i.kind, ref_id=parse_uuid(i.ref_id, "Item"))
                    for i in items
                )
        except IntegrityError:
            basket = Basket.objects.get(user=user, client_mutation_id=client_mutation_id)
        return self._view(user, basket, now)

    @staticmethod
    def _check_items(user: Any, items: list[BasketItemRef]) -> None:
        seen: set[tuple[str, str]] = set()
        for item in items:
            if item.kind not in (BasketItem.WALLET, BasketItem.ASSET):
                raise refuse(f"Unknown item kind: {item.kind}.")
            key = parse_uuid(item.ref_id, "Item")
            if (item.kind, str(key)) in seen:
                raise refuse("An item can be in a basket only once.")
            seen.add((item.kind, str(key)))
            model = Wallet if item.kind == BasketItem.WALLET else Asset
            if not model.objects.filter(user=user, id=key).exists():
                raise not_found("Item")

    def list_baskets(self, user: Any, now: datetime) -> list[BasketView]:
        return [
            self._view(user, b, now)
            for b in Basket.objects.filter(user=user).prefetch_related("items")
        ]

    def delete_basket(self, user: Any, basket_id: str) -> None:
        deleted, _ = Basket.objects.filter(user=user, id=parse_uuid(basket_id, "Basket")).delete()
        if not deleted:
            raise not_found("Basket")

    def _view(self, user: Any, basket: Basket, now: datetime) -> BasketView:
        converter = _Converter(now)
        balances = {str(w.id): w.balance_minor for w in wallets_service.list(user).wallets}
        wallets = {str(w.id): w for w in Wallet.objects.filter(user=user)}
        assets: dict[str, AssetView] = {a.id: a for a in asset_service.list(user, now).assets}
        views: list[BasketItemView] = []
        for item in basket.items.all():
            ref = str(item.ref_id)
            if item.kind == BasketItem.WALLET and ref in wallets:
                wallet = wallets[ref]
                value = _value_of_wallet(wallet, balances.get(ref, 0), converter)
                views.append(BasketItemView(item.kind, ref, wallet.name, value))
            elif item.kind == BasketItem.ASSET and ref in assets:
                asset = assets[ref]
                views.append(BasketItemView(item.kind, ref, asset.name, asset.value_minor))
            # a deleted asset simply leaves the basket
        total = sum(v.value_minor for v in views)
        return BasketView(
            id=str(basket.id),
            name=basket.name,
            target_minor=basket.target_minor,
            value_minor=total,
            percent=max(total, 0) * 100 // basket.target_minor,
            items=views,
        )


networth_service = NetWorthService()
