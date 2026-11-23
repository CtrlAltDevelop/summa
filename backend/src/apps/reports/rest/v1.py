"""What the reports app publishes over HTTP.

Every decision belongs to ReportsService; this file renders what
it returns.
"""

from django.http import HttpRequest
from ninja import Router

from apps.reports.rest.schemas import ApiMessage
from apps.reports.services import reports_service

router = Router()


@router.get("/", response=ApiMessage, summary="Example endpoint")
def index(request: HttpRequest) -> ApiMessage:
    return ApiMessage(message=reports_service.greeting())
