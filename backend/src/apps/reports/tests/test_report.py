from datetime import UTC, date, datetime, timedelta
from typing import Any

import pytest
from django.contrib.auth import get_user_model

from apps.reports.service import MAX_DAYS, report_service
from apps.wallets.categories import category_service
from apps.wallets.ledger import SplitPart, ledger_service
from apps.wallets.services import wallets_service
from apps.wallets.transfers import transfer_service
from infrastructure.common.errors import ApiError

pytestmark = pytest.mark.django_db

# Azar 1405: 2026-11-22 00:00 Tehran .. 2026-12-22 00:00 Tehran (as UTC)
START = datetime(2026, 11, 21, 20, 30, tzinfo=UTC)
END = datetime(2026, 12, 21, 20, 30, tzinfo=UTC)
MID = datetime(2026, 12, 1, 8, 0, tzinfo=UTC)


def make_user(name: str = "zoe") -> Any:
    return get_user_model()._default_manager.create_user(username=name)


def wallet(user: Any, name: str = "a", currency: str = "IRT", balance: int = 10_000_000) -> Any:
    return wallets_service.create(
        user,
        name=name,
        kind="bank",
        currency=currency,
        bank="",
        opening_balance_minor=balance,
        client_mutation_id=f"w-{name}",
    )


def cat(user: Any, name: str, kind: str = "expense") -> str:
    return next(c.id for c in category_service.list(user) if c.name == name and c.kind == kind)


def record(user: Any, w: Any, kind: str, amount: int, mutation: str, **kw: Any) -> Any:
    return ledger_service.record(
        user,
        wallet_id=w.id,
        kind=kind,
        amount_minor=amount,
        occurred_at=kw.pop("when", MID),
        note=kw.pop("note", ""),
        client_mutation_id=mutation,
        **kw,
    )


def monthly(user: Any, currency: str = "IRT", start: datetime = START, end: datetime = END) -> Any:
    return report_service.monthly(user, start, end, currency)


def test_an_empty_month_is_all_zeros_not_an_error() -> None:
    result = monthly(make_user())

    assert (result.income_minor, result.expense_minor, result.net_minor) == (0, 0, 0)
    assert result.by_category == [] and result.top_expense_category == ""
    assert result.currencies == [] and result.entries == 0
    assert len(result.daily) == 30


def test_income_expense_and_net() -> None:
    user = make_user()
    w = wallet(user)
    record(user, w, "income", 5_000, "i1")
    record(user, w, "expense", 1_200, "e1")
    record(user, w, "expense", 300, "e2")

    result = monthly(user)

    assert (result.income_minor, result.expense_minor, result.net_minor, result.entries) == (
        5_000,
        1_500,
        3_500,
        3,
    )


def test_the_opening_balance_is_not_income() -> None:
    user = make_user()
    wallet(user, balance=9_999_999)

    assert monthly(user).income_minor == 0


def test_outside_the_totals_is_not_counted() -> None:
    user = make_user()
    w = wallet(user)
    record(user, w, "expense", 1_000, "in")
    record(user, w, "expense", 700, "out", outside_totals=True)

    assert monthly(user).expense_minor == 1_000


def test_a_refund_lowers_the_expense_in_its_category() -> None:
    user = make_user()
    w = wallet(user)
    food = cat(user, "خوراک و سوپرمارکت")
    expense = record(user, w, "expense", 1_000, "e1", category_id=food)
    ledger_service.refund(
        user,
        expense.id,
        wallet_id=None,
        amount_minor=400,
        occurred_at=MID,
        note="",
        client_mutation_id="r1",
    )

    result = monthly(user)

    assert result.expense_minor == 600
    assert [(c.name, c.total_minor) for c in result.by_category] == [("خوراک و سوپرمارکت", 600)]


def test_a_refund_of_an_outside_expense_is_not_counted_either() -> None:
    user = make_user()
    w = wallet(user)
    record(user, w, "expense", 1_000, "in")
    out = record(user, w, "expense", 700, "out", outside_totals=True)
    ledger_service.refund(
        user,
        out.id,
        wallet_id=None,
        amount_minor=0,
        occurred_at=MID,
        note="",
        client_mutation_id="r",
    )

    assert monthly(user).expense_minor == 1_000


def test_transfers_are_ignored_but_their_fee_is_an_expense() -> None:
    user = make_user()
    a, b = wallet(user, "a"), wallet(user, "b")
    transfer_service.transfer(
        user,
        from_wallet_id=a.id,
        to_wallet_id=b.id,
        amount_minor=5_000,
        rate="",
        fee_minor=30,
        occurred_at=MID,
        note="",
        client_mutation_id="t",
    )

    result = monthly(user)

    assert (result.expense_minor, result.income_minor) == (30, 0)
    assert [(c.name, c.total_minor) for c in result.by_category] == [("بدون دسته", 30)]


def test_a_split_counts_each_part_in_its_own_category() -> None:
    user = make_user()
    w = wallet(user)
    ledger_service.record_split(
        user,
        wallet_id=w.id,
        parts=[
            SplitPart(cat(user, "رستوران و کافه"), 300, False),
            SplitPart(cat(user, "تفریح و اشتراک"), 100, False),
            SplitPart(cat(user, "رستوران و کافه"), 50, True),  # someone else's share
        ],
        occurred_at=MID,
        note="شام",
        client_mutation_id="s",
    )

    result = monthly(user)

    assert result.expense_minor == 400
    assert {c.name: c.total_minor for c in result.by_category} == {
        "رستوران و کافه": 300,
        "تفریح و اشتراک": 100,
    }


def test_deleted_entries_do_not_count() -> None:
    user = make_user()
    w = wallet(user)
    gone = record(user, w, "expense", 999, "e1")
    ledger_service.delete(user, gone.id)

    assert monthly(user).expense_minor == 0


def test_the_window_is_half_open() -> None:
    user = make_user()
    w = wallet(user)
    record(user, w, "expense", 1, "at-start", when=START)
    record(user, w, "expense", 10, "just-before-end", when=END - timedelta(seconds=1))
    record(user, w, "expense", 100, "at-end", when=END)
    record(user, w, "expense", 1_000, "before", when=START - timedelta(seconds=1))

    assert monthly(user).expense_minor == 11


def test_each_currency_is_reported_on_its_own() -> None:
    user = make_user()
    record(user, wallet(user, "t"), "expense", 500, "e1")
    record(user, wallet(user, "u", "USD"), "expense", 7_00, "e2")

    toman, dollars = monthly(user, "IRT"), monthly(user, "USD")

    assert (toman.expense_minor, dollars.expense_minor) == (500, 700)
    assert toman.currencies == ["IRT", "USD"] == dollars.currencies


def test_categories_are_sorted_by_total_and_the_top_one_named() -> None:
    user = make_user()
    w = wallet(user)
    record(user, w, "expense", 100, "e1", category_id=cat(user, "سلامت"))
    record(user, w, "expense", 900, "e2", category_id=cat(user, "آموزش"))
    record(user, w, "expense", 400, "e3", category_id=cat(user, "قبض و شارژ"))
    record(user, w, "income", 5_000, "i1", category_id=cat(user, "حقوق", "income"))

    result = monthly(user)

    expenses = [c for c in result.by_category if c.kind == "expense"]
    assert [c.name for c in expenses] == ["آموزش", "قبض و شارژ", "سلامت"]
    assert result.top_expense_category == "آموزش"
    assert [(c.name, c.total_minor) for c in result.by_category if c.kind == "income"] == [
        ("حقوق", 5_000)
    ]


def test_the_daily_series_uses_tehran_days() -> None:
    user = make_user()
    w = wallet(user)
    # 21:00 UTC on Nov 22 is 00:30 on Nov 23 in Tehran
    record(user, w, "expense", 100, "late", when=datetime(2026, 11, 22, 21, 0, tzinfo=UTC))
    record(user, w, "income", 40, "early", when=datetime(2026, 11, 22, 1, 0, tzinfo=UTC))

    result = monthly(user)
    days = {d.day: d for d in result.daily}

    assert (days[date(2026, 11, 22)].income_minor, days[date(2026, 11, 22)].expense_minor) == (
        40,
        0,
    )
    assert days[date(2026, 11, 23)].expense_minor == 100
    assert result.daily[0].day == date(2026, 11, 22) and result.daily[-1].day == date(2026, 12, 21)


@pytest.mark.parametrize(
    ("start", "end"),
    [
        (END, START),
        (START, START),
        (START, START + timedelta(days=MAX_DAYS + 1)),
        (START.replace(tzinfo=None), END),
    ],
)
def test_bad_windows_are_refused(start: datetime, end: datetime) -> None:
    with pytest.raises(ApiError) as refusal:
        monthly(make_user(), start=start, end=end)

    assert refusal.value.status == 400


def test_an_unknown_currency_is_refused() -> None:
    with pytest.raises(ApiError) as refusal:
        monthly(make_user(), "XXX")

    assert refusal.value.status == 400


def test_users_do_not_see_each_other() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    record(zoe, wallet(zoe), "expense", 500, "e1")

    result = monthly(ali)

    assert (result.expense_minor, result.entries, result.currencies) == (0, 0, [])
