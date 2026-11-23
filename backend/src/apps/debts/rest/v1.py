"""What the debts app publishes over HTTP.

Every decision belongs to DebtsService; this file renders what
it returns.
"""

from django.http import HttpRequest
from ninja import Router

from apps.debts.rest.schemas import ApiMessage
from apps.debts.services import debts_service

router = Router()


@router.get("/", response=ApiMessage, summary="Example endpoint")
def index(request: HttpRequest) -> ApiMessage:
    return ApiMessage(message=debts_service.greeting())
