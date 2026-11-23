"""What the networth app publishes over HTTP.

Every decision belongs to NetworthService; this file renders what
it returns.
"""

from django.http import HttpRequest
from ninja import Router

from apps.networth.rest.schemas import ApiMessage
from apps.networth.services import networth_service

router = Router()


@router.get("/", response=ApiMessage, summary="Example endpoint")
def index(request: HttpRequest) -> ApiMessage:
    return ApiMessage(message=networth_service.greeting())
