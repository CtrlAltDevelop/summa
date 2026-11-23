from datetime import UTC, date, datetime, timedelta
from decimal import Decimal
from typing import Any

import pytest
from django.contrib.auth import get_user_model

from apps.assets.rates import rate_service
from apps.assets.service import asset_service
from infrastructure.common.errors import ApiError

pytestmark = pytest.mark.django_db

NOW = datetime(2026, 11, 22, 9, 0, tzinfo=UTC)
DAY = date(2026, 11, 1)


def make_user(name: str = "zoe") -> Any:
    return get_user_model()._default_manager.create_user(username=name)


def rate(symbol: str, value: int, at: datetime = NOW) -> None:
    rate_service.set_manual(symbol, Decimal(value), now=at)


def create(user: Any, **overrides: Any) -> Any:
    fields: dict[str, Any] = {
        "symbol": "GOLD18",
        "name": "",
        "quantity": "10",
        "unit_price_minor": 7_000_000,
        "manual_price_minor": 0,
        "bought_on": DAY,
        "client_mutation_id": "a1",
        "now": NOW,
    } | overrides
    return asset_service.create(user, **fields)


def only(user: Any, now: datetime = NOW) -> Any:
    [asset] = asset_service.list(user, now).assets
    return asset


def test_value_cost_and_profit_use_the_current_rate() -> None:
    user = make_user()
    rate("GOLD18", 8_000_000)

    create(user)

    asset = only(user)
    assert (asset.value_minor, asset.cost_minor, asset.profit_minor) == (
        80_000_000,
        70_000_000,
        10_000_000,
    )
    assert (asset.name, asset.unit, asset.price_known, asset.stale) == (
        "طلای ۱۸ عیار",
        "گرم",
        True,
        False,
    )


def test_a_loss_is_negative() -> None:
    user = make_user()
    rate("GOLD18", 6_000_000)

    create(user)

    assert only(user).profit_minor == -10_000_000


def test_fractional_quantities_are_exact_and_rounded_half_up() -> None:
    user = make_user()
    rate("USD", 60_005)

    create(user, symbol="USD", quantity="0.333", unit_price_minor=60_000)

    asset = only(user)
    assert asset.quantity == "0.333"
    assert asset.value_minor == 19_982  # 19_981.665 -> half up


def test_an_unknown_rate_gives_no_value_and_stays_out_of_the_totals() -> None:
    user = make_user()
    create(user)

    listing = asset_service.list(user, NOW)

    assert listing.assets[0].price_known is False and listing.assets[0].value_minor == 0
    assert (listing.value_minor, listing.cost_minor, listing.profit_minor) == (0, 0, 0)


def test_an_old_rate_marks_the_asset_stale() -> None:
    user = make_user()
    rate("GOLD18", 8_000_000)
    create(user)

    assert only(user, NOW + timedelta(hours=7)).stale is True


def test_totals_add_the_known_assets_only() -> None:
    user = make_user()
    rate("GOLD18", 8_000_000)
    create(user)
    create(user, symbol="BTC", quantity="1", unit_price_minor=1, client_mutation_id="a2")

    listing = asset_service.list(user, NOW)

    assert (listing.value_minor, listing.cost_minor, listing.profit_minor) == (
        80_000_000,
        70_000_000,
        10_000_000,
    )


def test_a_custom_asset_uses_its_manual_price() -> None:
    user = make_user()

    create(
        user,
        symbol="",
        name="زمین",
        quantity="2",
        unit_price_minor=100,
        manual_price_minor=150,
    )

    asset = only(user)
    assert (asset.name, asset.value_minor, asset.price_known, asset.unit) == ("زمین", 300, True, "")


@pytest.mark.parametrize(
    "bad",
    [
        {"symbol": "DOGE"},
        {"symbol": "", "name": "x", "manual_price_minor": 0},
        {"symbol": "", "name": "", "manual_price_minor": 5},
        {"name": "x" * 61},
        {"quantity": "0"},
        {"quantity": "-1"},
        {"quantity": "1.123456789"},
        {"quantity": "abc"},
        {"quantity": "1e3"},
        {"quantity": ""},
        {"unit_price_minor": -1},
        {"client_mutation_id": ""},
    ],
)
def test_invalid_assets_are_refused(bad: dict[str, Any]) -> None:
    with pytest.raises(ApiError) as refusal:
        create(make_user(), **bad)

    assert refusal.value.status == 400


def test_creating_twice_with_one_mutation_id_makes_one() -> None:
    user = make_user()

    first, again = create(user), create(user)

    assert first.id == again.id and len(asset_service.list(user, NOW).assets) == 1
    assert only(user).quantity == "10"


def test_another_lot_changes_the_quantity_and_the_cost() -> None:
    user = make_user()
    rate("GOLD18", 8_000_000)
    first = create(user)

    asset_service.add_lot(user, first.id, quantity="5", unit_price_minor=7_600_000, bought_on=DAY)

    asset = only(user)
    assert (asset.quantity, asset.cost_minor, asset.value_minor) == (
        "15",
        108_000_000,
        120_000_000,
    )


def test_selling_consumes_the_oldest_lot_first_and_books_realized_profit() -> None:
    user = make_user()
    rate("GOLD18", 8_000_000)
    first = create(user)  # 10 g at 7.0M
    asset_service.add_lot(
        user, first.id, quantity="5", unit_price_minor=7_600_000, bought_on=DAY + timedelta(days=1)
    )

    asset_service.sell(user, first.id, quantity="12", unit_price_minor=8_100_000)

    asset = only(user)
    # 10 g at 7.0M and 2 g at 7.6M: (1.1M*10) + (0.5M*2) = 12M
    assert asset.realized_minor == 12_000_000
    assert (asset.quantity, asset.cost_minor, asset.value_minor) == ("3", 22_800_000, 24_000_000)


def test_selling_everything_leaves_an_empty_asset_with_its_history() -> None:
    user = make_user()
    rate("GOLD18", 8_000_000)
    asset = create(user)

    asset_service.sell(user, asset.id, quantity="10", unit_price_minor=7_500_000)

    after = only(user)
    assert (after.quantity, after.value_minor, after.cost_minor, after.realized_minor) == (
        "0",
        0,
        0,
        5_000_000,
    )


@pytest.mark.parametrize(
    "bad", [{"quantity": "10.1"}, {"quantity": "0"}, {"quantity": "x"}, {"unit_price_minor": -1}]
)
def test_invalid_sales_are_refused(bad: dict[str, Any]) -> None:
    user = make_user()
    asset = create(user)

    with pytest.raises(ApiError) as refusal:
        asset_service.sell(
            user,
            asset.id,
            quantity=str(bad.get("quantity", "1")),
            unit_price_minor=int(bad.get("unit_price_minor", 1)),
        )

    assert refusal.value.status == 400
    assert only(user).quantity == "10"


def test_invalid_lots_are_refused() -> None:
    user = make_user()
    asset = create(user)

    for quantity, price in (("0", 1), ("-1", 1), ("1", -1)):
        with pytest.raises(ApiError) as refusal:
            asset_service.add_lot(
                user, asset.id, quantity=quantity, unit_price_minor=price, bought_on=DAY
            )
        assert refusal.value.status == 400


def test_other_users_see_and_touch_nothing() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    asset = create(zoe)

    assert asset_service.list(ali, NOW).assets == []
    for call in (
        lambda: asset_service.add_lot(
            ali, asset.id, quantity="1", unit_price_minor=1, bought_on=DAY
        ),
        lambda: asset_service.sell(ali, asset.id, quantity="1", unit_price_minor=1),
        lambda: asset_service.delete(ali, asset.id),
        lambda: asset_service.delete(ali, "not-a-uuid"),
    ):
        with pytest.raises(ApiError) as refusal:
            call()
        assert refusal.value.status == 404


def test_deleting_removes_the_asset_and_its_lots() -> None:
    user = make_user()
    asset = create(user)

    asset_service.delete(user, asset.id)

    assert asset_service.list(user, NOW).assets == []
