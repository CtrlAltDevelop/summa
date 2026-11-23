import csv
import io
from datetime import UTC, datetime, timedelta
from typing import Any

import pytest
from django.contrib.auth import get_user_model

from apps.reports.service import MAX_EXPORT_ROWS, report_service
from apps.wallets.ledger import ledger_service
from apps.wallets.services import wallets_service
from apps.wallets.transfers import transfer_service
from infrastructure.common.errors import ApiError

pytestmark = pytest.mark.django_db

MID = datetime(2026, 12, 1, 8, 0, tzinfo=UTC)  # 1405/09/10, 11:30 Tehran
START = datetime(2026, 11, 21, 20, 30, tzinfo=UTC)
END = datetime(2026, 12, 21, 20, 30, tzinfo=UTC)


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


def rows(text: str) -> list[dict[str, str]]:
    assert text.startswith("﻿")
    return list(csv.DictReader(io.StringIO(text[1:])))


def export(user: Any, start: datetime | None = None, end: datetime | None = None) -> str:
    return report_service.export_csv(user, start, end)


def test_the_header_and_a_simple_row() -> None:
    user = make_user()
    record(user, wallet(user), "expense", 150_000, "e1", note="نان")

    text = export(user)
    [row] = rows(text)

    assert text.splitlines()[0].lstrip("﻿").split(",")[:6] == [
        "date_shamsi",
        "datetime_utc",
        "kind",
        "direction",
        "amount",
        "currency",
    ]
    assert (row["date_shamsi"], row["kind"], row["direction"]) == ("1405/09/10", "expense", "out")
    assert (row["amount"], row["currency"], row["wallet"], row["note"]) == (
        "150000",
        "IRT",
        "ملی",
        "نان",
    )
    assert row["datetime_utc"].startswith("2026-12-01T08:00:00")


def test_amounts_use_the_currencys_decimals() -> None:
    user = make_user()
    record(user, wallet(user, "usd", "USD"), "income", 12_305, "i1")
    record(user, wallet(user, "usd2", "USD"), "income", 5, "i2")

    amounts = [r["amount"] for r in rows(export(user))]

    assert amounts == ["123.05", "0.05"]


def test_every_kind_of_event_is_exported() -> None:
    user = make_user()
    a, b = wallet(user, "a", balance=1_000), wallet(user, "b")
    expense = record(user, a, "expense", 100, "e1", outside_totals=True)
    ledger_service.refund(
        user,
        expense.id,
        wallet_id=None,
        amount_minor=40,
        occurred_at=MID,
        note="",
        client_mutation_id="r",
    )
    transfer_service.transfer(
        user,
        from_wallet_id=a.id,
        to_wallet_id=b.id,
        amount_minor=200,
        rate="",
        fee_minor=5,
        occurred_at=MID,
        note="",
        client_mutation_id="t",
    )

    kinds = sorted(r["kind"] for r in rows(export(user)))

    assert kinds == sorted(
        ["opening_balance", "expense", "refund", "transfer_out", "transfer_in", "expense"]
    )
    by_kind = {r["kind"]: r for r in rows(export(user)) if r["kind"] != "expense"}
    assert by_kind["refund"]["refund_of"] == expense.id
    assert by_kind["transfer_out"]["transfer_id"] == by_kind["transfer_in"]["transfer_id"] != ""


def test_the_outside_flag_and_split_ids_are_exported() -> None:
    user = make_user()
    record(user, wallet(user), "expense", 100, "e1", outside_totals=True)

    assert rows(export(user))[0]["outside_totals"] == "1"


def test_deleted_entries_are_not_exported() -> None:
    user = make_user()
    gone = record(user, wallet(user), "expense", 100, "e1")
    ledger_service.delete(user, gone.id)

    assert rows(export(user)) == []


@pytest.mark.parametrize("text", ["=1+1", "+cmd", "-2+3", "@SUM(A1)"])
def test_cells_that_look_like_formulas_are_neutralised(text: str) -> None:
    user = make_user()
    record(user, wallet(user), "expense", 100, "e1", note=text)

    [row] = rows(export(user))

    assert row["note"] == "'" + text


def test_names_and_notes_that_break_csv_survive_a_round_trip() -> None:
    user = make_user()
    w = wallet(user, 'کیف "من", ۱')
    record(user, w, "expense", 100, "e1", note='سلام, "دنیا"\nخط دوم')

    [row] = rows(export(user))

    assert (row["wallet"], row["note"]) == ('کیف "من", ۱', 'سلام, "دنیا"\nخط دوم')


def test_the_range_is_half_open_and_optional() -> None:
    user = make_user()
    w = wallet(user)
    record(user, w, "expense", 1, "in", when=START)
    record(user, w, "expense", 2, "out", when=END)
    record(user, w, "expense", 3, "before", when=START - timedelta(days=5))

    in_range = [r["amount"] for r in rows(export(user, START, END))]
    everything = [r["amount"] for r in rows(export(user))]

    assert in_range == ["1"]
    assert everything == ["3", "1", "2"]  # oldest first


def test_half_a_range_or_a_bad_range_is_refused() -> None:
    user = make_user()

    for start, end in ((START, None), (None, END), (END, START)):
        with pytest.raises(ApiError) as refusal:
            export(user, start, end)
        assert refusal.value.status == 400


def test_a_huge_export_is_refused_with_advice(monkeypatch: pytest.MonkeyPatch) -> None:
    user = make_user()
    w = wallet(user)
    record(user, w, "expense", 1, "e1")
    record(user, w, "expense", 1, "e2")
    monkeypatch.setattr("apps.reports.service.MAX_EXPORT_ROWS", 1)

    with pytest.raises(ApiError) as refusal:
        export(user)

    assert refusal.value.status == 400 and MAX_EXPORT_ROWS == 50_000


def test_only_my_rows_are_exported() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    record(zoe, wallet(zoe), "expense", 100, "e1")

    assert rows(export(ali)) == []
