from datetime import UTC, datetime
from decimal import Decimal

import pytest

from apps.assistant.calendar import jalali_to_gregorian, tehran_to_utc
from apps.assistant.sms_parser import parse_sms


def test_jalali_conversion_matches_known_dates() -> None:
    assert jalali_to_gregorian(1405, 9, 1) == (2026, 11, 22)
    assert jalali_to_gregorian(1403, 1, 1) == (2024, 3, 20)
    assert jalali_to_gregorian(1404, 12, 29) == (2026, 3, 20)


def test_tehran_time_becomes_utc() -> None:
    assert tehran_to_utc(1405, 9, 1, 14, 30) == datetime(2026, 11, 22, 11, 0, tzinfo=UTC)


@pytest.mark.parametrize("bad", [(1405, 13, 1), (1405, 0, 1), (1405, 7, 31), (1405, 1, 32)])
def test_impossible_dates_are_none(bad: tuple[int, int, int]) -> None:
    assert tehran_to_utc(*bad) is None


WITHDRAWAL = "برداشت 500,000 ریال\nکارت 1234****\nمانده 2,500,000 ریال\n1405/09/01-14:30"


def test_a_withdrawal_is_fully_understood() -> None:
    facts = parse_sms(WITHDRAWAL)

    assert facts.ignored == ""
    assert (facts.kind, facts.amount, facts.unit) == ("expense", Decimal(500_000), "IRR")
    assert facts.last4 == "1234"
    assert facts.balance == Decimal(2_500_000)
    assert facts.occurred_at == datetime(2026, 11, 22, 11, 0, tzinfo=UTC)


@pytest.mark.parametrize(
    ("sms", "kind", "amount", "unit", "last4"),
    [
        ("واریز ۱۲٬۰۰۰٬۰۰۰ ریال به حساب ...۵۶۷۸", "income", 12_000_000, "IRR", "5678"),
        ("+2,000,000\nحساب 4321\nمانده: 9,000,000", "income", 2_000_000, "IRR", "4321"),
        ("-150,000\nکارت ****9876", "expense", 150_000, "IRR", "9876"),
        ("خرید 250,000 ریال\nکارت ****9876", "expense", 250_000, "IRR", "9876"),
        ("مبلغ 50,000 تومان پرداخت شد", "expense", 50_000, "IRT", ""),
        ("سپرده 3,000,000 ریال", "income", 3_000_000, "IRR", ""),
    ],
)
def test_common_message_shapes(sms: str, kind: str, amount: int, unit: str, last4: str) -> None:
    facts = parse_sms(sms)

    assert (facts.kind, facts.amount, facts.unit, facts.last4) == (
        kind,
        Decimal(amount),
        unit,
        last4,
    )


def test_the_amount_is_not_the_balance_the_time_or_the_card() -> None:
    facts = parse_sms("برداشت 500,000 ریال کارت 1234**** مانده 2,500,000 ریال 14:30")

    assert facts.amount == Decimal(500_000)
    assert "500" in facts.evidence


@pytest.mark.parametrize(
    ("sms", "reason"),
    [
        ("رمز پویا 123456 مبلغ 500,000 ریال", "otp"),
        ("رمز یکبار مصرف شما 884211", "otp"),
        ("تراکنش ناموفق بود 500,000 ریال", "failed"),
        ("با کد تخفیف 20 درصد خرید کنید 500,000", "ad"),
        ("سلام", "no_amount"),
        ("", "no_amount"),
        ("کارت 1234**** 14:30", "no_amount"),
    ],
)
def test_messages_that_must_not_be_registered(sms: str, reason: str) -> None:
    assert parse_sms(sms).ignored == reason


def test_an_unknown_direction_is_left_blank_for_the_user() -> None:
    facts = parse_sms("تراکنش 500,000 ریال کارت 1234****")

    assert facts.ignored == "" and facts.kind == ""


def test_a_message_without_a_date_has_no_time() -> None:
    assert parse_sms("برداشت 500,000 ریال").occurred_at is None


def test_an_impossible_date_is_dropped_not_trusted() -> None:
    assert parse_sms("برداشت 500,000 ریال 1405/13/40").occurred_at is None
