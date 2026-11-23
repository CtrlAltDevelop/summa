from datetime import UTC, datetime
from typing import Any

import pytest
from django.contrib.auth import get_user_model

from apps.reports.importer import MAX_BYTES, MAX_ROWS, import_service
from apps.reports.service import report_service
from apps.wallets.categories import category_service
from apps.wallets.ledger import ledger_service
from apps.wallets.services import wallets_service
from apps.wallets.transfers import transfer_service
from infrastructure.common.errors import ApiError

pytestmark = pytest.mark.django_db

HEADER = "date,kind,amount,wallet,category,note"


def make_user(name: str = "zoe") -> Any:
    return get_user_model()._default_manager.create_user(username=name)


def wallet(user: Any, name: str = "ملی", currency: str = "IRT", balance: int = 0) -> Any:
    return wallets_service.create(
        user,
        name=name,
        kind="bank",
        currency=currency,
        bank="",
        opening_balance_minor=balance,
        client_mutation_id=f"w-{name}",
    )


def run(user: Any, *lines: str, commit: bool = True, header: str = HEADER) -> Any:
    return import_service.import_csv(user, "\r\n".join([header, *lines]), commit=commit)


def entries(user: Any) -> list[Any]:
    return sorted(
        ledger_service.list(user, wallet_id=None, limit=200),
        key=lambda e: (e.occurred_at, e.amount_minor),
    )


def test_a_preview_counts_and_changes_nothing() -> None:
    user = make_user()
    wallet(user)

    result = run(
        user, "2026-11-22,expense,1000,ملی,,نان", "2026-11-23,income,500,ملی,,حقوق", commit=False
    )

    assert (result.rows, result.importable, result.imported, result.skipped) == (2, 2, 0, 0)
    assert result.errors == [] and entries(user) == []


def test_a_clean_file_is_imported() -> None:
    user = make_user()
    w = wallet(user)
    food = next(c.id for c in category_service.list(user) if c.name == "خوراک و سوپرمارکت")

    result = run(user, "2026-11-22,expense,1000,ملی,خوراک و سوپرمارکت,نان")

    [entry] = entries(user)
    assert (result.imported, result.errors) == (1, [])
    assert (entry.wallet_id, entry.kind, entry.amount_minor) == (w.id, "expense", 1_000)
    assert (entry.note, entry.category_id) == ("نان", food)
    # a date without a time is noon in Tehran
    assert entry.occurred_at == datetime(2026, 11, 22, 8, 30, tzinfo=UTC)


@pytest.mark.parametrize(
    ("date", "expected"),
    [
        ("2026-11-22", datetime(2026, 11, 22, 8, 30, tzinfo=UTC)),
        ("2026-11-22T10:00:00+00:00", datetime(2026, 11, 22, 10, 0, tzinfo=UTC)),
        ("2026-11-22T12:00:00", datetime(2026, 11, 22, 8, 30, tzinfo=UTC)),  # naive = Tehran
        ("1405/09/01", datetime(2026, 11, 22, 8, 30, tzinfo=UTC)),
        ("۱۴۰۵/۰۹/۰۱", datetime(2026, 11, 22, 8, 30, tzinfo=UTC)),
    ],
)
def test_dates_in_iso_and_shamsi_forms(date: str, expected: datetime) -> None:
    user = make_user()
    wallet(user)

    run(user, f"{date},expense,1,ملی,,")

    assert entries(user)[0].occurred_at == expected


def test_persian_digits_and_decimals_in_amounts() -> None:
    user = make_user()
    wallet(user, "usd", "USD")

    run(user, "2026-11-22,income,۱۲٫۵۰,usd,,", "2026-11-22,income,3,usd,,")

    assert [e.amount_minor for e in entries(user)] == [300, 1_250]


@pytest.mark.parametrize(
    ("row", "fragment"),
    [
        ("2026-11-22,transfer,10,ملی,,", "kind"),
        ("2026-11-22,expense,abc,ملی,,", "amount"),
        ("2026-11-22,expense,-5,ملی,,", "amount"),
        ("2026-11-22,expense,0,ملی,,", "amount"),
        ("2026-11-22,expense,1.5,ملی,,", "decimals"),
        ("2026-11-22,expense,10,نامعلوم,,", "wallet"),
        ("2026-11-22,expense,10,ملی,سفر,", "category"),
        ("2026-11-22,income,10,ملی,رستوران و کافه,", "category"),
        ("not-a-date,expense,10,ملی,,", "date"),
        ("1405/13/40,expense,10,ملی,,", "date"),
        ("2026-11-22,expense,10,,,", "wallet"),
        (",expense,10,ملی,,", "date"),
    ],
)
def test_each_kind_of_bad_row_is_reported_with_its_line(row: str, fragment: str) -> None:
    user = make_user()
    wallet(user)

    result = run(user, "2026-11-22,expense,1,ملی,,ok", row, commit=False)

    assert result.importable == 1
    [error] = result.errors
    assert error.line == 3 and fragment in error.message


def test_one_bad_row_stops_the_whole_import() -> None:
    user = make_user()
    wallet(user)

    result = run(user, "2026-11-22,expense,1,ملی,,", "2026-11-22,expense,x,ملی,,")

    assert result.imported == 0 and len(result.errors) == 1
    assert entries(user) == []


def test_every_error_is_listed_not_just_the_first() -> None:
    user = make_user()
    wallet(user)

    result = run(
        user, "bad,expense,1,ملی,,", "2026-11-22,expense,x,ملی,,", "2026-11-22,expense,1,none,,"
    )

    assert [e.line for e in result.errors] == [2, 3, 4]


def test_a_currency_column_must_match_the_wallet() -> None:
    user = make_user()
    wallet(user)

    result = run(
        user, "2026-11-22,expense,1,ملی,,,IRT", "2026-11-22,expense,1,ملی,,,USD",
        header=HEADER + ",currency", commit=False,
    )  # fmt: skip

    assert result.importable == 1 and "currency" in result.errors[0].message


def test_an_archived_wallet_cannot_receive_rows() -> None:
    user = make_user()
    w = wallet(user)
    wallets_service.archive(user, w.id)

    result = run(user, "2026-11-22,expense,1,ملی,,", commit=False)

    assert "wallet" in result.errors[0].message


def test_importing_the_same_file_twice_adds_nothing_the_second_time() -> None:
    user = make_user()
    wallet(user)
    lines = ("2026-11-22,expense,1000,ملی,,نان", "2026-11-23,income,500,ملی,,حقوق")

    first, second = run(user, *lines), run(user, *lines)

    assert (first.imported, second.imported) == (2, 0)
    assert len(entries(user)) == 2


def test_identical_rows_inside_one_file_are_all_kept() -> None:
    user = make_user()
    wallet(user)

    result = run(user, *["2026-11-22,expense,100,ملی,,قهوه"] * 3)

    assert result.imported == 3 and len(entries(user)) == 3


def test_a_longer_version_of_the_file_adds_only_the_new_rows() -> None:
    user = make_user()
    wallet(user)
    run(user, "2026-11-22,expense,100,ملی,,a")

    result = run(user, "2026-11-22,expense,100,ملی,,a", "2026-11-23,expense,200,ملی,,b")

    assert result.imported == 1 and len(entries(user)) == 2


def test_the_apps_own_export_can_be_imported_by_someone_else() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    a = wallet(zoe, "ملی", balance=10_000)
    wallet(ali, "ملی")
    food = next(c.id for c in category_service.list(zoe) if c.name == "خوراک و سوپرمارکت")
    when = datetime(2026, 12, 1, 8, 0, tzinfo=UTC)
    ledger_service.record(
        zoe, wallet_id=a.id, kind="expense", amount_minor=250, occurred_at=when, note='نان, "تازه"',
        client_mutation_id="e1", category_id=food,
    )  # fmt: skip
    ledger_service.record(
        zoe, wallet_id=a.id, kind="income", amount_minor=900, occurred_at=when, note="x",
        client_mutation_id="e2",
    )  # fmt: skip
    b = wallet(zoe, "دوم")
    transfer_service.transfer(
        zoe, from_wallet_id=a.id, to_wallet_id=b.id, amount_minor=5, rate="", fee_minor=0,
        occurred_at=when, note="", client_mutation_id="t",
    )  # fmt: skip
    exported = report_service.export_csv(zoe, None, None)

    preview = import_service.import_csv(ali, exported, commit=False)
    done = import_service.import_csv(ali, exported, commit=True)

    # opening balance, the transfer's two legs and the second wallet's rows are skipped or refused
    assert preview.skipped == 3 and [e.line for e in preview.errors] == []
    assert done.imported == 2
    mine = {(e.kind, e.amount_minor, e.note) for e in entries(ali)}
    assert mine == {("expense", 250, 'نان, "تازه"'), ("income", 900, "x")}


def test_a_bom_and_extra_columns_are_fine() -> None:
    user = make_user()
    wallet(user)
    text = "﻿date,kind,amount,wallet,whatever\r\n2026-11-22,expense,5,ملی,ignored\r\n"

    assert import_service.import_csv(user, text, commit=True).imported == 1


@pytest.mark.parametrize(
    "text",
    [
        "",
        "   \n",
        "date,kind,amount\r\n2026-11-22,expense,1\r\n",
        "kind,amount,wallet\r\nexpense,1,ملی\r\n",
    ],
)
def test_a_file_without_the_needed_columns_is_refused(text: str) -> None:
    user = make_user()
    wallet(user)

    with pytest.raises(ApiError) as refusal:
        import_service.import_csv(user, text, commit=False)

    assert refusal.value.status == 400


def test_size_limits() -> None:
    user = make_user()
    wallet(user)
    too_many = "\n".join([HEADER, *["2026-11-22,expense,1,ملی,,"] * (MAX_ROWS + 1)])
    too_big = "\n".join([HEADER, "2026-11-22,expense,1,ملی,," + "x" * MAX_BYTES])

    for text in (too_many, too_big):
        with pytest.raises(ApiError) as refusal:
            import_service.import_csv(user, text, commit=False)
        assert refusal.value.status == 400


def test_another_users_wallet_names_are_not_visible() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    wallet(zoe, "خصوصی")

    result = run(ali, "2026-11-22,expense,1,خصوصی,,", commit=False)

    assert "wallet" in result.errors[0].message
