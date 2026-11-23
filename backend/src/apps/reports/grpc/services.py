"""Reports and the CSV export over gRPC. Every call is scoped to the caller."""

from datetime import datetime
from typing import Any

from asgiref.sync import sync_to_async
from django_socio_grpc import generics
from django_socio_grpc.decorators import grpc_action

from apps.reports.grpc.serializers import CategoryTotalMsg, DayTotalMsg, ImportErrorMsg
from apps.reports.importer import import_service
from apps.reports.service import report_service
from infrastructure.common.errors import ApiError
from infrastructure.common.grpc.errors import action, require_caller
from infrastructure.common.identity import grpc_caller

_FILENAME = "summa-export.csv"


def _when(text: str, name: str) -> datetime | None:
    if not text:
        return None
    try:
        return datetime.fromisoformat(text)
    except ValueError:
        raise ApiError(f"{name} is not an ISO-8601 time.", 400) from None


class ReportsService(generics.GenericService):
    @grpc_action(
        request=[
            # The window is a Shamsi month the client computed, with a UTC offset.
            {"name": "starts_at", "type": "string"},
            {"name": "ends_at", "type": "string"},
            {"name": "currency", "type": "string"},
        ],
        request_name="ReportRequest",
        response=[
            {"name": "currency", "type": "string"},
            {"name": "income_minor", "type": "int64"},
            {"name": "expense_minor", "type": "int64"},
            {"name": "net_minor", "type": "int64"},
            {"name": "entries", "type": "int32"},
            {"name": "by_category", "type": CategoryTotalMsg, "cardinality": "repeated"},
            {"name": "daily", "type": DayTotalMsg, "cardinality": "repeated"},
            {"name": "top_expense_category", "type": "string"},
            {"name": "currencies", "type": "string", "cardinality": "repeated"},
        ],
        response_name="ReportReply",
    )
    @action
    async def Monthly(self, request: Any, context: Any) -> Any:
        from apps.reports.grpc import reports_pb2

        user = require_caller(await grpc_caller(context))
        start, end = _when(request.starts_at, "starts_at"), _when(request.ends_at, "ends_at")
        if start is None or end is None:
            raise ApiError("starts_at and ends_at are required.", 400)
        report = await sync_to_async(report_service.monthly)(user, start, end, request.currency)
        return reports_pb2.ReportReply(
            currency=report.currency,
            income_minor=report.income_minor,
            expense_minor=report.expense_minor,
            net_minor=report.net_minor,
            entries=report.entries,
            by_category=[
                reports_pb2.CategoryTotalMsg(
                    category_id=c.category_id, name=c.name, kind=c.kind, total_minor=c.total_minor
                )
                for c in report.by_category
            ],
            daily=[
                reports_pb2.DayTotalMsg(
                    day=d.day.isoformat(),
                    income_minor=d.income_minor,
                    expense_minor=d.expense_minor,
                )
                for d in report.daily
            ],
            top_expense_category=report.top_expense_category,
            currencies=report.currencies,
        )

    @grpc_action(
        request=[
            # Both empty: everything. Otherwise both are required.
            {"name": "starts_at", "type": "string"},
            {"name": "ends_at", "type": "string"},
        ],
        request_name="ExportRequest",
        response=[
            {"name": "filename", "type": "string"},
            # UTF-8 with a BOM, ready to save as a .csv and open in a spreadsheet.
            {"name": "content", "type": "bytes"},
        ],
        response_name="ExportReply",
    )
    @action
    async def ExportCsv(self, request: Any, context: Any) -> Any:
        from apps.reports.grpc import reports_pb2

        user = require_caller(await grpc_caller(context))
        text = await sync_to_async(report_service.export_csv)(
            user, _when(request.starts_at, "starts_at"), _when(request.ends_at, "ends_at")
        )
        return reports_pb2.ExportReply(filename=_FILENAME, content=text.encode("utf-8"))

    @grpc_action(
        request=[
            {"name": "text", "type": "string"},
            # False only counts and checks; True imports, and only when there is no error.
            {"name": "commit", "type": "bool"},
        ],
        request_name="ImportRequest",
        response=[
            {"name": "rows", "type": "int32"},
            {"name": "importable", "type": "int32"},
            {"name": "imported", "type": "int32"},
            {"name": "skipped", "type": "int32"},
            {"name": "errors", "type": ImportErrorMsg, "cardinality": "repeated"},
        ],
        response_name="ImportReply",
    )
    @action
    async def ImportCsv(self, request: Any, context: Any) -> Any:
        from apps.reports.grpc import reports_pb2

        user = require_caller(await grpc_caller(context))
        result = await sync_to_async(import_service.import_csv)(
            user, request.text, commit=request.commit
        )
        return reports_pb2.ImportReply(
            rows=result.rows,
            importable=result.importable,
            imported=result.imported,
            skipped=result.skipped,
            errors=[
                reports_pb2.ImportErrorMsg(line=e.line, message=e.message) for e in result.errors
            ],
        )


GRPC_SERVICES = [ReportsService]
