from datetime import UTC, date, datetime, timedelta
from decimal import Decimal
from typing import Any

import pytest
from django.contrib.auth import get_user_model

from apps.assets.rates import rate_service
from apps.assets.service import asset_service
from apps.debts.service import debt_service
from apps.networth.service import MAX_BASKETS, BasketItemRef, networth_service
from apps.wallets.services import wallets_service
from infrastructure.common.errors import ApiError

pytestmark = pytest.mark.django_db

NOW = datetime(2026, 11, 22, 9, 0, tzinfo=UTC)


def make_user(name: str = "zoe") -> Any:
    return get_user_model()._default_manager.create_user(username=name)


def wallet(user: Any, name: str, balance: int, currency: str = "IRT") -> Any:
    return wallets_service.create(
        user,
        name=name,
        kind="bank",
        currency=currency,
        bank="",
        opening_balance_minor=balance,
        client_mutation_id=f"w-{name}",
    )


def rate(symbol: str, value: int, at: datetime = NOW) -> None:
    rate_service.set_manual(symbol, Decimal(value), now=at)


def gold(user: Any, quantity: str = "10", mutation: str = "g1") -> Any:
    return asset_service.create(
        user,
        symbol="GOLD18",
        name="",
        quantity=quantity,
        unit_price_minor=7_000_000,
        manual_price_minor=0,
        bought_on=date(2026, 11, 1),
        client_mutation_id=mutation,
        now=NOW,
    )


def loan(user: Any, currency: str = "IRT", count: int = 3, amount: int = 1_000_000) -> Any:
    return debt_service.create(
        user,
        kind="bank_loan",
        title="وام",
        currency=currency,
        installment_minor=amount,
        count=count,
        first_due=date(2026, 12, 6),
        principal_minor=0,
        wallet_id=None,
        category_id=None,
        client_mutation_id=f"d-{currency}",
        now=NOW,
    )


def worth(user: Any, now: datetime = NOW) -> Any:
    return networth_service.net_worth(user, now)


# --- net worth ----------------------------------------------------------------


def test_an_empty_account_is_worth_nothing() -> None:
    result = worth(make_user())

    assert (result.total_minor, result.wallets_minor, result.assets_minor, result.debts_minor) == (
        0,
        0,
        0,
        0,
    )
    assert result.unconverted == [] and result.stale is False


def test_wallets_assets_and_debts_combine_into_toman() -> None:
    user = make_user()
    rate("GOLD18", 8_000_000)
    wallet(user, "a", 5_000_000)
    gold(user)  # 10 g * 8M = 80M
    loan(user)  # 3M remaining

    result = worth(user)

    assert (result.wallets_minor, result.assets_minor, result.debts_minor) == (
        5_000_000,
        80_000_000,
        3_000_000,
    )
    assert result.total_minor == 82_000_000


def test_paid_installments_reduce_the_debt() -> None:
    user = make_user()
    w = wallet(user, "a", 10_000_000)
    debt = loan(user)
    debt_service.pay(user, debt.installments[0].id, wallet_id=w.id, amount_minor=0, now=NOW)

    result = worth(user)

    assert (result.debts_minor, result.wallets_minor) == (2_000_000, 9_000_000)


def test_a_dollar_wallet_is_converted_with_the_rate() -> None:
    user = make_user()
    rate("USD", 60_000)
    wallet(user, "usd", 20_000, "USD")  # 200.00 USD

    assert worth(user).wallets_minor == 12_000_000


def test_a_foreign_debt_is_converted_too() -> None:
    user = make_user()
    rate("USD", 60_000)
    loan(user, currency="USD", count=2, amount=10_000)  # 2 x 100.00 USD

    assert worth(user).debts_minor == 12_000_000


def test_a_currency_without_a_rate_is_left_out_and_reported() -> None:
    user = make_user()
    wallet(user, "a", 1_000_000)
    wallet(user, "eur", 5_000, "EUR")
    loan(user, currency="AED", count=1, amount=100)

    result = worth(user)

    assert result.wallets_minor == 1_000_000
    assert result.debts_minor == 0
    assert result.unconverted == ["AED", "EUR"]


def test_rials_need_no_rate() -> None:
    user = make_user()
    wallet(user, "r", 100_000, "IRR")

    assert worth(user).wallets_minor == 10_000


def test_assets_without_a_price_are_counted_not_valued() -> None:
    user = make_user()
    gold(user)

    result = worth(user)

    assert (result.assets_minor, result.unpriced_assets) == (0, 1)


def test_archived_wallets_do_not_count() -> None:
    user = make_user()
    gone = wallet(user, "gone", 9_000_000)
    wallet(user, "kept", 1_000_000)
    wallets_service.archive(user, gone.id)

    assert worth(user).wallets_minor == 1_000_000


def test_the_same_currency_is_summed_before_it_is_converted() -> None:
    user = make_user()
    rate("USD", 60_005)
    for index in range(3):
        wallet(user, f"u{index}", 1, "USD")  # three 0.01 USD wallets

    # 3 cents = 0.03 USD = 1800.15 toman -> 1800; converting each (600.05 -> 600) loses 0.15
    assert worth(user).wallets_minor == 1_800


def test_the_dollar_and_gold_equivalents() -> None:
    user = make_user()
    rate("USD", 60_000)
    rate("GOLD18", 8_000_000)
    wallet(user, "a", 12_000_000)

    result = worth(user)

    assert result.usd_minor == 20_000  # 200.00 USD
    assert result.gold_grams == "1.5"  # 12M / 8M


def test_equivalents_are_blank_without_rates() -> None:
    user = make_user()
    wallet(user, "a", 12_000_000)

    result = worth(user)

    assert (result.usd_minor, result.gold_grams) == (None, "")


def test_a_negative_net_worth_is_possible() -> None:
    user = make_user()
    rate("USD", 60_000)
    wallet(user, "a", 1_000_000)
    loan(user, amount=5_000_000)

    result = worth(user)

    assert result.total_minor == 1_000_000 - 15_000_000 and result.usd_minor == -23_333


def test_an_old_rate_marks_the_result_stale() -> None:
    user = make_user()
    rate("USD", 60_000)
    wallet(user, "usd", 100, "USD")

    assert worth(user).stale is False
    assert worth(user, NOW + timedelta(hours=7)).stale is True


def test_users_are_independent() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    wallet(zoe, "a", 5_000_000)

    assert worth(ali).total_minor == 0


# --- baskets ------------------------------------------------------------------


def basket(user: Any, **overrides: Any) -> Any:
    fields: dict[str, Any] = {
        "name": "پیش‌پرداخت خانه",
        "target_minor": 100_000_000,
        "items": [],
        "client_mutation_id": "b1",
        "now": NOW,
    } | overrides
    return networth_service.create_basket(user, **fields)


def test_a_basket_measures_progress_from_its_items() -> None:
    user = make_user()
    rate("GOLD18", 8_000_000)
    cash = wallet(user, "a", 10_000_000)
    held = gold(user)  # 80M

    made = basket(user, items=[BasketItemRef("wallet", cash.id), BasketItemRef("asset", held.id)])

    assert (made.value_minor, made.percent) == (90_000_000, 90)
    assert {(i.kind, i.value_minor) for i in made.items} == {
        ("wallet", 10_000_000),
        ("asset", 80_000_000),
    }
    assert {i.name for i in made.items} == {"a", "طلای ۱۸ عیار"}


def test_progress_can_pass_one_hundred_percent() -> None:
    user = make_user()
    cash = wallet(user, "a", 150_000_000)

    assert basket(user, items=[BasketItemRef("wallet", cash.id)]).percent == 150


def test_an_empty_basket_starts_at_zero() -> None:
    made = basket(make_user())

    assert (made.value_minor, made.percent, made.items) == (0, 0, [])


def test_a_foreign_currency_item_is_valued_in_toman() -> None:
    user = make_user()
    rate("USD", 60_000)
    usd = wallet(user, "usd", 10_000, "USD")  # 100 USD = 6M

    assert basket(user, items=[BasketItemRef("wallet", usd.id)]).value_minor == 6_000_000


def test_an_archived_or_unpriced_item_counts_as_zero() -> None:
    user = make_user()
    gone = wallet(user, "gone", 9_000_000)
    wallets_service.archive(user, gone.id)
    unpriced = gold(user)

    made = basket(
        user, items=[BasketItemRef("wallet", gone.id), BasketItemRef("asset", unpriced.id)]
    )

    assert made.value_minor == 0 and len(made.items) == 2


@pytest.mark.parametrize(
    "bad",
    [
        {"name": "  "},
        {"name": "x" * 61},
        {"target_minor": 0},
        {"target_minor": -5},
        {"client_mutation_id": ""},
    ],
)
def test_invalid_baskets_are_refused(bad: dict[str, Any]) -> None:
    with pytest.raises(ApiError) as refusal:
        basket(make_user(), **bad)

    assert refusal.value.status == 400


def test_items_must_be_valid_unique_and_the_users_own() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    mine = wallet(zoe, "a", 1)
    theirs = wallet(ali, "b", 1)

    with pytest.raises(ApiError) as bad_kind:
        basket(zoe, items=[BasketItemRef("house", mine.id)])
    with pytest.raises(ApiError) as twice:
        basket(zoe, items=[BasketItemRef("wallet", mine.id)] * 2, client_mutation_id="b2")
    with pytest.raises(ApiError) as foreign:
        basket(zoe, items=[BasketItemRef("wallet", theirs.id)], client_mutation_id="b3")
    with pytest.raises(ApiError) as junk:
        basket(zoe, items=[BasketItemRef("asset", "not-a-uuid")], client_mutation_id="b4")

    assert (bad_kind.value.status, twice.value.status) == (400, 400)
    assert (foreign.value.status, junk.value.status) == (404, 404)
    assert networth_service.list_baskets(zoe, NOW) == []


def test_one_item_may_sit_in_two_baskets() -> None:
    user = make_user()
    cash = wallet(user, "a", 1_000)

    basket(user, items=[BasketItemRef("wallet", cash.id)])
    basket(user, items=[BasketItemRef("wallet", cash.id)], client_mutation_id="b2")

    assert len(networth_service.list_baskets(user, NOW)) == 2


def test_the_number_of_baskets_is_limited() -> None:
    user = make_user()
    for index in range(MAX_BASKETS):
        basket(user, client_mutation_id=f"b{index}")

    with pytest.raises(ApiError) as refusal:
        basket(user, client_mutation_id="one-too-many")

    assert refusal.value.status == 400


def test_creating_twice_with_one_mutation_id_makes_one() -> None:
    user = make_user()

    first, again = basket(user), basket(user)

    assert first.id == again.id and len(networth_service.list_baskets(user, NOW)) == 1


def test_deleting_a_basket_keeps_what_it_pointed_to() -> None:
    user = make_user()
    cash = wallet(user, "a", 1_000)
    made = basket(user, items=[BasketItemRef("wallet", cash.id)])

    networth_service.delete_basket(user, made.id)

    assert networth_service.list_baskets(user, NOW) == []
    assert worth(user).wallets_minor == 1_000


def test_other_users_cannot_see_or_delete_a_basket() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    made = basket(zoe)

    assert networth_service.list_baskets(ali, NOW) == []
    for target in (made.id, "not-a-uuid"):
        with pytest.raises(ApiError) as refusal:
            networth_service.delete_basket(ali, target)
        assert refusal.value.status == 404


def test_a_deleted_asset_simply_leaves_the_basket() -> None:
    user = make_user()
    rate("GOLD18", 8_000_000)
    held = gold(user)
    basket(user, items=[BasketItemRef("asset", held.id)])

    asset_service.delete(user, held.id)

    [only] = networth_service.list_baskets(user, NOW)
    assert only.items == [] and only.value_minor == 0
