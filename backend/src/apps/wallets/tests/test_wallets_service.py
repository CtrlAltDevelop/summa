from typing import Any

import pytest
from django.contrib.auth import get_user_model

from apps.wallets.services import wallets_service
from infrastructure.common.errors import ApiError

pytestmark = pytest.mark.django_db


def make_user(name: str = "zoe") -> Any:
    return get_user_model()._default_manager.create_user(username=name)


def create(user: Any, **overrides: Any) -> Any:
    fields: dict[str, Any] = {
        "name": "کیف نقد",
        "kind": "cash",
        "currency": "IRT",
        "bank": "",
        "opening_balance_minor": 0,
        "client_mutation_id": "m1",
    } | overrides
    return wallets_service.create(user, **fields)


def test_opening_balance_becomes_the_balance() -> None:
    user = make_user()

    wallet = create(user, opening_balance_minor=150_000)

    assert wallet.balance_minor == 150_000
    assert wallets_service.list(user).wallets[0].balance_minor == 150_000


def test_zero_opening_balance_records_no_event() -> None:
    user = make_user()

    wallet = create(user)

    assert wallet.balance_minor == 0


def test_a_credit_card_may_open_in_debt() -> None:
    user = make_user()

    wallet = create(user, kind="credit_card", bank="ملت", opening_balance_minor=-500_000)

    assert wallet.balance_minor == -500_000


def test_a_cash_wallet_may_not_open_in_debt() -> None:
    with pytest.raises(ApiError) as refusal:
        create(make_user(), opening_balance_minor=-1)

    assert refusal.value.status == 400


def test_repeating_a_mutation_returns_the_same_wallet_without_a_second_opening() -> None:
    user = make_user()

    first = create(user, opening_balance_minor=100)
    again = create(user, opening_balance_minor=100)

    assert again.id == first.id
    assert again.balance_minor == 100


@pytest.mark.parametrize(
    "bad",
    [
        {"currency": "XXX"},
        {"kind": "piggybank"},
        {"name": "   "},
        {"name": "x" * 61},
        {"bank": "y" * 41},
        {"client_mutation_id": ""},
    ],
)
def test_invalid_input_is_refused(bad: dict) -> None:
    with pytest.raises(ApiError) as refusal:
        create(make_user(), **bad)

    assert refusal.value.status == 400


def test_a_user_sees_only_their_own_wallets() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    create(zoe, opening_balance_minor=10)
    create(ali, client_mutation_id="m2", opening_balance_minor=99)

    mine = wallets_service.list(zoe)

    assert [w.balance_minor for w in mine.wallets] == [10]


def test_archiving_someone_elses_wallet_is_not_found() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    wallet = create(zoe)

    with pytest.raises(ApiError) as refusal:
        wallets_service.archive(ali, str(wallet.id))

    assert refusal.value.status == 404


def test_malformed_wallet_id_is_not_found() -> None:
    with pytest.raises(ApiError) as refusal:
        wallets_service.archive(make_user(), "not-a-uuid")

    assert refusal.value.status == 404


def test_totals_sum_per_currency_and_skip_archived_wallets() -> None:
    user = make_user()
    create(user, client_mutation_id="a", opening_balance_minor=100)
    create(user, client_mutation_id="b", opening_balance_minor=50)
    create(user, client_mutation_id="c", currency="USD", opening_balance_minor=1_000)
    gone = create(user, client_mutation_id="d", opening_balance_minor=7)
    wallets_service.archive(user, str(gone.id))

    result = wallets_service.list(user)

    assert {t.currency: t.balance_minor for t in result.totals} == {"IRT": 150, "USD": 1_000}
    assert [w.archived for w in result.wallets].count(True) == 1
