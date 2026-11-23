from typing import Any

import pytest
from django.contrib.auth import get_user_model

from apps.wallets.ledger import ledger_service
from apps.wallets.services import wallets_service
from apps.wallets.transfers import transfer_service
from infrastructure.common.errors import ApiError

pytestmark = pytest.mark.django_db


def make_user(name: str = "zoe") -> Any:
    return get_user_model()._default_manager.create_user(username=name)


def wallet(user: Any, mutation: str, currency: str = "IRT", balance: int = 10_000) -> Any:
    return wallets_service.create(
        user,
        name=mutation,
        kind="bank",
        currency=currency,
        bank="",
        opening_balance_minor=balance,
        client_mutation_id=mutation,
    )


def transfer(user: Any, src: Any, dst: Any, **overrides: Any) -> list[Any]:
    fields: dict[str, Any] = {
        "from_wallet_id": src.id,
        "to_wallet_id": dst.id,
        "amount_minor": 1_000,
        "rate": "",
        "fee_minor": 0,
        "occurred_at": None,
        "note": "",
        "client_mutation_id": "t1",
    } | overrides
    return transfer_service.transfer(user, **fields)


def balances(user: Any) -> dict[str, int]:
    return {w.name: w.balance_minor for w in wallets_service.list(user).wallets}


def test_same_currency_moves_money_between_wallets() -> None:
    user = make_user()
    a, b = wallet(user, "a"), wallet(user, "b")

    legs = transfer(user, a, b)

    assert balances(user) == {"a": 9_000, "b": 11_000}
    assert [leg.kind for leg in legs] == ["transfer_out", "transfer_in"]


def test_fee_comes_only_from_the_source_as_an_expense() -> None:
    user = make_user()
    a, b = wallet(user, "a"), wallet(user, "b")

    legs = transfer(user, a, b, fee_minor=50)

    assert balances(user) == {"a": 8_950, "b": 11_000}
    assert [leg.kind for leg in legs] == ["transfer_out", "transfer_in", "expense"]


def test_cross_currency_uses_the_users_rate_with_half_up_rounding() -> None:
    user = make_user()
    toman = wallet(user, "toman", balance=100_000_000)
    usd = wallet(user, "usd", currency="USD", balance=0)

    legs = transfer(user, toman, usd, amount_minor=1_000_000, rate="0.0000165")

    # 1,000,000 toman * 0.0000165 = 16.5 USD = 1650 cents
    assert legs[1].amount_minor == 1_650
    assert balances(user) == {"toman": 99_000_000, "usd": 1_650}


def test_rounding_goes_half_up() -> None:
    user = make_user()
    toman = wallet(user, "toman")
    usd = wallet(user, "usd", currency="USD", balance=0)

    legs = transfer(user, toman, usd, amount_minor=1_000, rate="0.00001")  # 0.01 USD

    assert legs[1].amount_minor == 1


@pytest.mark.parametrize(
    "bad",
    [
        {"amount_minor": 0},
        {"fee_minor": -1},
        {"rate": "1.5"},  # same currency takes no rate
        {"client_mutation_id": ""},
        {"note": "x" * 201},
    ],
)
def test_invalid_same_currency_input_is_refused(bad: dict[str, Any]) -> None:
    user = make_user()
    a, b = wallet(user, "a"), wallet(user, "b")

    with pytest.raises(ApiError) as refusal:
        transfer(user, a, b, **bad)

    assert refusal.value.status == 400
    assert balances(user) == {"a": 10_000, "b": 10_000}


@pytest.mark.parametrize("rate", ["", "0", "-2", "abc", "1e400", "NaN"])
def test_cross_currency_needs_a_positive_numeric_rate(rate: str) -> None:
    user = make_user()
    toman = wallet(user, "toman")
    usd = wallet(user, "usd", currency="USD")

    with pytest.raises(ApiError) as refusal:
        transfer(user, toman, usd, rate=rate)

    assert refusal.value.status == 400


def test_an_amount_that_rounds_to_zero_is_refused() -> None:
    user = make_user()
    toman = wallet(user, "toman")
    usd = wallet(user, "usd", currency="USD")

    with pytest.raises(ApiError) as refusal:
        transfer(user, toman, usd, amount_minor=1, rate="0.0000001")

    assert refusal.value.status == 400


def test_same_wallet_and_archived_wallet_are_refused() -> None:
    user = make_user()
    a, b = wallet(user, "a"), wallet(user, "b")

    with pytest.raises(ApiError) as same:
        transfer(user, a, a)
    wallets_service.archive(user, b.id)
    with pytest.raises(ApiError) as archived:
        transfer(user, a, b)

    assert (same.value.status, archived.value.status) == (400, 400)


def test_someone_elses_wallet_is_not_found() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    a, b = wallet(zoe, "a"), wallet(zoe, "b")
    mine = wallet(ali, "m")

    for src, dst in ((a, mine), (mine, b)):
        with pytest.raises(ApiError) as refusal:
            transfer(ali, src, dst)
        assert refusal.value.status == 404


def test_repeating_a_mutation_transfers_once() -> None:
    user = make_user()
    a, b = wallet(user, "a"), wallet(user, "b")

    first = transfer(user, a, b, fee_minor=10)
    again = transfer(user, a, b, fee_minor=10)

    assert [x.id for x in again] == [x.id for x in first]
    assert balances(user) == {"a": 8_990, "b": 11_000}


def test_deleting_any_leg_voids_the_whole_transfer() -> None:
    user = make_user()
    a, b = wallet(user, "a"), wallet(user, "b")
    legs = transfer(user, a, b, fee_minor=10)

    ledger_service.delete(user, legs[1].id)  # the incoming leg

    assert balances(user) == {"a": 10_000, "b": 10_000}
    assert ledger_service.list(user, wallet_id=None, limit=50) == []


def test_a_transfer_leg_cannot_be_edited() -> None:
    user = make_user()
    a, b = wallet(user, "a"), wallet(user, "b")
    legs = transfer(user, a, b, fee_minor=10)

    for leg in legs:
        with pytest.raises(ApiError) as refusal:
            ledger_service.edit(user, leg.id, amount_minor=1, occurred_at=None, note="")
        assert refusal.value.status == 400


def test_list_shows_transfer_legs() -> None:
    user = make_user()
    a, b = wallet(user, "a"), wallet(user, "b")
    transfer(user, a, b)

    kinds = {e.kind for e in ledger_service.list(user, wallet_id=None, limit=50)}

    assert kinds == {"transfer_out", "transfer_in"}
