from collections.abc import Callable
from typing import Any

import grpc
import pytest
from django.test import Client

from apps.reports.grpc import reports_pb2, reports_pb2_grpc
from apps.wallets.grpc import wallets_pb2, wallets_pb2_grpc

Stub = reports_pb2_grpc.ReportsControllerStub
PASSWORD = "corr3ct-horse-battery"
START, END = "2026-11-21T20:30:00+00:00", "2026-12-21T20:30:00+00:00"


def sign_up(name: str) -> str:
    response = Client().post(
        "/api/v1/auth/password/signup",
        {"identifier": name, "password": PASSWORD, "email": f"{name}@example.com"},
        content_type="application/json",
    )
    assert response.status_code == 200, response.content
    return response.json()["data"]["credentials"]["access_token"]


def seed(grpc_call: Callable[..., Any], token: str) -> Any:
    wallet = grpc_call(
        wallets_pb2_grpc.WalletsControllerStub,
        "Create",
        wallets_pb2.WalletCreate(
            name="ملی", kind="bank", currency="IRT", opening_balance_minor=0, client_mutation_id="w"
        ),
        token=token,
    ).wallet
    for kind, amount, key in (("income", 5_000, "i"), ("expense", 1_200, "e")):
        grpc_call(
            wallets_pb2_grpc.LedgerControllerStub,
            "Record",
            wallets_pb2.EntryRecord(
                wallet_id=wallet.id,
                kind=kind,
                amount_minor=amount,
                occurred_at="2026-12-01T08:00:00+00:00",
                note="نان",
                client_mutation_id=key,
            ),
            token=token,
        )
    return wallet


def test_the_monthly_report_over_the_wire(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")
    seed(grpc_call, token)

    report = grpc_call(
        Stub,
        "Monthly",
        reports_pb2.ReportRequest(starts_at=START, ends_at=END, currency="IRT"),
        token=token,
    )

    assert (report.income_minor, report.expense_minor, report.net_minor) == (5_000, 1_200, 3_800)
    assert report.entries == 2 and list(report.currencies) == ["IRT"]
    assert len(report.daily) == 30 and report.daily[0].day == "2026-11-22"
    assert report.by_category[0].name == "بدون دسته"


def test_the_csv_export_over_the_wire(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")
    seed(grpc_call, token)

    reply = grpc_call(Stub, "ExportCsv", reports_pb2.ExportRequest(), token=token)
    text = reply.content.decode("utf-8")

    assert reply.filename == "summa-export.csv"
    assert text.startswith("\ufeffdate_shamsi,datetime_utc,kind")
    assert "1405/09/10" in text and "نان" in text


def test_reports_are_private(transactional_db: None, grpc_call: Callable[..., Any]) -> None:
    zoe, ali = sign_up("zoe"), sign_up("ali")
    seed(grpc_call, zoe)

    report = grpc_call(
        Stub,
        "Monthly",
        reports_pb2.ReportRequest(starts_at=START, ends_at=END, currency="IRT"),
        token=ali,
    )
    export = grpc_call(Stub, "ExportCsv", reports_pb2.ExportRequest(), token=ali)

    assert (report.entries, report.expense_minor) == (0, 0)
    assert export.content.decode("utf-8").count("\r\n") == 1  # the header only


@pytest.mark.parametrize(
    "request_fields",
    [
        {"starts_at": "", "ends_at": END, "currency": "IRT"},
        {"starts_at": "yesterday", "ends_at": END, "currency": "IRT"},
        {"starts_at": END, "ends_at": START, "currency": "IRT"},
        {"starts_at": START, "ends_at": END, "currency": "XXX"},
        {"starts_at": "2026-11-22T00:00:00", "ends_at": END, "currency": "IRT"},
    ],
)
def test_bad_report_requests_are_invalid_argument(
    transactional_db: None, grpc_call: Callable[..., Any], request_fields: dict[str, str]
) -> None:
    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(
            Stub, "Monthly", reports_pb2.ReportRequest(**request_fields), token=sign_up("zoe")
        )

    assert refusal.value.code() is grpc.StatusCode.INVALID_ARGUMENT


def test_a_half_open_export_range_is_invalid_argument(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(
            Stub, "ExportCsv", reports_pb2.ExportRequest(starts_at=START), token=sign_up("zoe")
        )

    assert refusal.value.code() is grpc.StatusCode.INVALID_ARGUMENT


def test_no_credential_is_unauthenticated(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(Stub, "ExportCsv", reports_pb2.ExportRequest())

    assert refusal.value.code() is grpc.StatusCode.UNAUTHENTICATED


CSV = "date,kind,amount,wallet\r\n2026-11-22,expense,1000,ملی\r\n2026-11-23,income,500,ملی\r\n"


def test_import_preview_then_commit_over_the_wire(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")
    wallet = grpc_call(
        wallets_pb2_grpc.WalletsControllerStub,
        "Create",
        wallets_pb2.WalletCreate(
            name="ملی", kind="bank", currency="IRT", opening_balance_minor=0, client_mutation_id="w"
        ),
        token=token,
    ).wallet

    preview = grpc_call(Stub, "ImportCsv", reports_pb2.ImportRequest(text=CSV), token=token)
    done = grpc_call(
        Stub, "ImportCsv", reports_pb2.ImportRequest(text=CSV, commit=True), token=token
    )
    entries = grpc_call(
        wallets_pb2_grpc.LedgerControllerStub, "List", wallets_pb2.EntryQuery(), token=token
    ).entries

    assert (preview.rows, preview.importable, preview.imported) == (2, 2, 0)
    assert (done.imported, list(done.errors)) == (2, [])
    assert sorted(e.amount_minor for e in entries) == [500, 1000]
    assert {e.wallet_id for e in entries} == {wallet.id}


def test_import_errors_come_back_with_their_lines(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    token = sign_up("zoe")

    reply = grpc_call(
        Stub,
        "ImportCsv",
        reports_pb2.ImportRequest(
            text="date,kind,amount,wallet\r\n2026-11-22,expense,x,نیست\r\n", commit=True
        ),
        token=token,
    )

    assert reply.imported == 0
    assert [(e.line, "wallet" in e.message) for e in reply.errors] == [(2, True)]


def test_an_import_without_the_columns_is_invalid_argument(
    transactional_db: None, grpc_call: Callable[..., Any]
) -> None:
    with pytest.raises(grpc.aio.AioRpcError) as refusal:
        grpc_call(
            Stub,
            "ImportCsv",
            reports_pb2.ImportRequest(text="a,b\r\n1,2\r\n"),
            token=sign_up("zoe"),
        )

    assert refusal.value.code() is grpc.StatusCode.INVALID_ARGUMENT
