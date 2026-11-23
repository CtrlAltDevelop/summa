from datetime import UTC, datetime, timedelta

import pytest

from apps.assistant.parser import CategoryRef, ParseContext, WalletRef, parse

NOW = datetime(2026, 11, 20, 12, 0, tzinfo=UTC)

MELLI = WalletRef("w-melli", "ملی", "ملی", "IRT")
CASH = WalletRef("w-cash", "نقد", "", "IRT")
USD = WalletRef("w-usd", "دلاری", "", "USD")

CATS = [
    CategoryRef("c-food", "خوراک و سوپرمارکت", "expense", False),
    CategoryRef("c-trans", "رفت‌وآمد", "expense", False),
    CategoryRef("c-bill", "قبض و شارژ", "expense", False),
    CategoryRef("c-health", "سلامت", "expense", False),
    CategoryRef("c-other", "سایر", "expense", True),
    CategoryRef("c-salary", "حقوق", "income", False),
    CategoryRef("c-other-in", "سایر", "income", True),
]


def ctx(*wallets: WalletRef, categories: list[CategoryRef] | None = None) -> ParseContext:
    return ParseContext(wallets=list(wallets) or [MELLI], categories=categories or CATS, now=NOW)


@pytest.mark.parametrize(
    ("text", "minor", "currency"),
    [
        ("۲۵۰ هزار تومن خرید نان", 250_000, "IRT"),
        ("250 هزار تومان نان", 250_000, "IRT"),
        ("۱.۵ میلیون تومن اجاره", 1_500_000, "IRT"),
        ("۲ میلیارد تومن", 2_000_000_000, "IRT"),
        ("۲۵۰٬۰۰۰ تومان نان", 250_000, "IRT"),
        ("250,000 تومان نان", 250_000, "IRT"),
        ("۵۰۰۰۰۰ ریال شارژ", 500_000, "IRR"),
        ("۱۲.۵ دلار قهوه", 1_250, "USD"),
        ("۳ یورو", 300, "EUR"),
        ("۱۰۰ تتر", 10_000, "USDT"),
        ("نان ۴۰ هزار", 40_000, "IRT"),
    ],
)
def test_amounts_and_units(text: str, minor: int, currency: str) -> None:
    result = parse(text, ctx(MELLI, USD))

    assert result is not None
    assert (result.amount_minor, result.currency) == (minor, currency)


@pytest.mark.parametrize("text", ["سلام", "", "   ", "خرید نان", "۱.۵ تومن", "۰ تومن نان"])
def test_nothing_to_register_gives_no_card(text: str) -> None:
    assert parse(text, ctx()) is None


def test_the_amount_digits_are_in_the_text() -> None:
    text = "۲۵۰ هزار تومن خرید نان"

    result = parse(text, ctx())

    assert result is not None and "250" in result.evidence.replace("۲۵۰", "250")


@pytest.mark.parametrize(
    ("text", "kind"),
    [
        ("۲۵۰ هزار تومن خرید نان", "expense"),
        ("۵۰ هزار تومن تاکسی دادم", "expense"),
        ("حقوق گرفتم ۲۰ میلیون تومن", "income"),
        ("۲ میلیون تومن واریز شد", "income"),
        ("۱۰۰ هزار تومن", "expense"),
    ],
)
def test_kind_from_keywords(text: str, kind: str) -> None:
    result = parse(text, ctx())

    assert result is not None and result.kind == kind


@pytest.mark.parametrize(
    ("text", "category"),
    [
        ("۲۵۰ هزار تومن خرید نان", "c-food"),
        ("۸۰ هزار تومن اسنپ", "c-trans"),
        ("۳۰۰ هزار تومن قبض برق", "c-bill"),
        ("۱۰۰ هزار تومن دارو", "c-health"),
        ("۱۰۰ هزار تومن یه چیز عجیب", "c-other"),
        ("حقوق ۲۰ میلیون تومن گرفتم", "c-salary"),
    ],
)
def test_category_from_keywords_falls_back_to_other(text: str, category: str) -> None:
    result = parse(text, ctx())

    assert result is not None and result.category_id == category


def test_a_deleted_default_category_falls_back_to_other() -> None:
    without_food = [c for c in CATS if c.id != "c-food"]

    result = parse("۲۵۰ هزار تومن نان", ctx(categories=without_food))

    assert result is not None and result.category_id == "c-other"


@pytest.mark.parametrize(
    ("text", "days_ago"),
    [("دیروز ۵۰ هزار تومن نان", 1), ("پریروز ۵۰ هزار تومن نان", 2), ("۵۰ هزار تومن نان", 0)],
)
def test_relative_day_words(text: str, days_ago: int) -> None:
    result = parse(text, ctx())

    assert result is not None and result.occurred_at == NOW - timedelta(days=days_ago)


def test_wallet_by_name_or_bank_otherwise_the_only_match() -> None:
    by_name = parse("۵۰ هزار تومن نان با کارت ملی", ctx(MELLI, CASH))
    only_one = parse("۵۰ هزار تومن نان", ctx(MELLI, USD))
    ambiguous = parse("۵۰ هزار تومن نان", ctx(MELLI, CASH))

    assert by_name is not None and by_name.wallet_id == "w-melli"
    assert only_one is not None and only_one.wallet_id == "w-melli"
    assert ambiguous is not None and ambiguous.wallet_id == ""


def test_the_wallet_must_match_the_currency() -> None:
    result = parse("۱۰ دلار قهوه از ملی", ctx(MELLI, USD))

    assert result is not None and result.wallet_id == "w-usd"


def test_a_same_currency_transfer_between_named_wallets() -> None:
    result = parse("۲ میلیون تومن انتقال از ملی به نقد", ctx(MELLI, CASH))

    assert result is not None
    assert (result.kind, result.wallet_id, result.to_wallet_id) == (
        "transfer",
        "w-melli",
        "w-cash",
    )
    assert result.amount_minor == 2_000_000 and result.category_id == ""


def test_a_cross_currency_transfer_makes_no_card() -> None:
    assert parse("۱۰۰ دلار انتقال از ملی به دلاری", ctx(MELLI, USD)) is None


def test_a_transfer_needs_two_distinct_known_wallets() -> None:
    assert parse("۲ میلیون تومن انتقال از ملی به ملی", ctx(MELLI, CASH)) is None
    assert parse("۲ میلیون تومن انتقال از ملی", ctx(MELLI, CASH)) is None


def test_the_note_keeps_the_users_words_trimmed() -> None:
    result = parse("  ۲۵۰ هزار تومن خرید نان  ", ctx())

    assert result is not None and result.note == "خرید نان"
