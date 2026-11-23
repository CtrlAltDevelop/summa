"""What the recurring app publishes over HTTP.

Every decision belongs to RecurringService; this file renders what
it returns.
"""

from django.http import HttpRequest
from ninja import Router

from apps.recurring.rest.schemas import ApiMessage
from apps.recurring.services import recurring_service

router = Router()


@router.get("/", response=ApiMessage, summary="Example endpoint")
def index(request: HttpRequest) -> ApiMessage:
    return ApiMessage(message=recurring_service.greeting())
