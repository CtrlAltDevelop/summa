"""What the billing app publishes over HTTP.

Every decision belongs to BillingService; this file renders what
it returns.
"""

from django.http import HttpRequest
from ninja import Router

from apps.billing.rest.schemas import ApiMessage
from apps.billing.services import billing_service

router = Router()


@router.get("/", response=ApiMessage, summary="Example endpoint")
def index(request: HttpRequest) -> ApiMessage:
    return ApiMessage(message=billing_service.greeting())
