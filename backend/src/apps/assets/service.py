"""Assets, their purchases (lots), valuation and FIFO selling."""

import re
from dataclasses import dataclass
from datetime import date, datetime
from decimal import ROUND_HALF_UP, Decimal
from typing import Any, Final

from django.db import IntegrityError, transaction

from apps.assets.models import Asset, Lot
from apps.assets.profile import CATALOG, MAX_QUANTITY_DECIMALS, NAME_MAX_LENGTH
from apps.assets.rates import rate_service
from apps.wallets.validation import not_found, parse_uuid, refuse

_QUANTITY: Final = re.compile(rf"\d{{1,16}}(\.\d{{1,{MAX_QUANTITY_DECIMALS}}})?")
_ZERO: Final = Decimal(0)


@dataclass(frozen=True, slots=True)
class AssetView:
    id: str
    symbol: str
    name: str
    unit: str
    quantity: str
    cost_minor: int
    value_minor: int
    profit_minor: int
    realized_minor: int
    price: str  # the unit price used for the value, as text; empty if unknown
    price_known: bool
    stale: bool


@dataclass(frozen=True, slots=True)
class AssetList:
    assets: list[AssetView]
    #: Over the assets whose price is known (toman); unknown ones are left out.
    value_minor: int
    cost_minor: int
    profit_minor: int
    realized_minor: int


def _quantity(text: str, what: str = "The quantity") -> Decimal:
    if not _QUANTITY.fullmatch(text.strip()):
        raise refuse(f"{what} must be a number with at most {MAX_QUANTITY_DECIMALS} decimals.")
    value = Decimal(text.strip())
    if value <= 0:
        raise refuse(f"{what} must be greater than zero.")
    return value


def _text(value: Decimal) -> str:
    return format(value.normalize(), "f")


def _round(value: Decimal) -> int:
    return int(value.quantize(Decimal(1), rounding=ROUND_HALF_UP))


def _own(user: Any, asset_id: str) -> Asset:
    asset = Asset.objects.filter(user=user, id=parse_uuid(asset_id, "Asset")).first()
    if asset is None:
        raise not_found("Asset")
    return asset


def _view(asset: Asset, now: datetime) -> AssetView:
    lots = list(asset.lots.all())
    quantity = sum((lot.quantity for lot in lots), _ZERO)
    cost = _round(sum((lot.quantity * lot.unit_price_minor for lot in lots), _ZERO))
    entry = CATALOG.get(asset.symbol)
    if entry is not None:
        price = rate_service.price_of(asset.symbol)
        stale = rate_service.is_stale(asset.symbol, now)
    else:
        price = Decimal(asset.manual_price_minor) if asset.manual_price_minor > 0 else None
        stale = False
    known = price is not None
    value = _round(quantity * price) if price is not None else 0
    return AssetView(
        id=str(asset.id),
        symbol=asset.symbol,
        name=asset.name,
        unit=entry.unit if entry else "",
        quantity=_text(quantity),
        cost_minor=cost,
        value_minor=value,
        profit_minor=value - cost if known else 0,
        realized_minor=asset.realized_minor,
        price=_text(price) if price is not None else "",
        price_known=known,
        stale=stale,
    )


class AssetService:
    def create(
        self,
        user: Any,
        *,
        symbol: str,
        name: str,
        quantity: str,
        unit_price_minor: int,
        manual_price_minor: int,
        bought_on: date | None,
        client_mutation_id: str,
        now: datetime,
    ) -> AssetView:
        name = name.strip()
        if not client_mutation_id or len(client_mutation_id) > 64:
            raise refuse("client_mutation_id is required (at most 64 characters).")
        if symbol and symbol not in CATALOG:
            raise refuse(f"Unknown symbol: {symbol}.")
        if symbol:
            name = name or CATALOG[symbol].name
            if manual_price_minor:
                raise refuse("A listed asset is priced by the rates, not by hand.")
        elif not name or manual_price_minor <= 0:
            raise refuse("A custom asset needs a name and a price.")
        if len(name) > NAME_MAX_LENGTH:
            raise refuse(f"The name is at most {NAME_MAX_LENGTH} characters.")
        amount = _quantity(quantity)
        if unit_price_minor < 0:
            raise refuse("The purchase price cannot be negative.")
        try:
            with transaction.atomic():
                asset = Asset.objects.create(
                    user=user,
                    symbol=symbol,
                    name=name,
                    manual_price_minor=manual_price_minor,
                    client_mutation_id=client_mutation_id,
                )
                Lot.objects.create(
                    asset=asset,
                    quantity=amount,
                    unit_price_minor=unit_price_minor,
                    bought_on=bought_on or now.date(),
                )
        except IntegrityError:
            asset = Asset.objects.get(user=user, client_mutation_id=client_mutation_id)
        return _view(asset, now)

    def list(self, user: Any, now: datetime) -> AssetList:
        views = [_view(a, now) for a in Asset.objects.filter(user=user).prefetch_related("lots")]
        known = [v for v in views if v.price_known]
        return AssetList(
            assets=views,
            value_minor=sum(v.value_minor for v in known),
            cost_minor=sum(v.cost_minor for v in known),
            profit_minor=sum(v.profit_minor for v in known),
            realized_minor=sum(v.realized_minor for v in views),
        )

    def add_lot(
        self, user: Any, asset_id: str, *, quantity: str, unit_price_minor: int, bought_on: date
    ) -> None:
        amount = _quantity(quantity)
        if unit_price_minor < 0:
            raise refuse("The purchase price cannot be negative.")
        asset = _own(user, asset_id)
        Lot.objects.create(
            asset=asset, quantity=amount, unit_price_minor=unit_price_minor, bought_on=bought_on
        )

    def sell(self, user: Any, asset_id: str, *, quantity: str, unit_price_minor: int) -> None:
        """Sell the oldest purchases first; the profit over what they cost is booked."""
        amount = _quantity(quantity)
        if unit_price_minor < 0:
            raise refuse("The selling price cannot be negative.")
        with transaction.atomic():
            asset = _own(user, asset_id)
            lots = list(Lot.objects.select_for_update().filter(asset=asset))
            if amount > sum((lot.quantity for lot in lots), _ZERO):
                raise refuse("You do not hold that much.")
            remaining, profit = amount, _ZERO
            for lot in lots:
                if remaining <= 0:
                    break
                take = min(lot.quantity, remaining)
                profit += (Decimal(unit_price_minor) - lot.unit_price_minor) * take
                remaining -= take
                if take == lot.quantity:
                    lot.delete()
                else:
                    lot.quantity -= take
                    lot.save(update_fields=["quantity"])
            asset.realized_minor += _round(profit)
            asset.save(update_fields=["realized_minor"])

    def delete(self, user: Any, asset_id: str) -> None:
        _own(user, asset_id).delete()


asset_service = AssetService()
