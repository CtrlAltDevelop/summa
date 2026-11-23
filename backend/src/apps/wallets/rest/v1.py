"""What the wallets app publishes over HTTP.

Every decision belongs to WalletsService; this file renders what
it returns.
"""

from django.http import HttpRequest
from ninja import Router

from apps.wallets.rest.schemas import ApiMessage
from apps.wallets.services import wallets_service

router = Router()


@router.get("/", response=ApiMessage, summary="Example endpoint")
def index(request: HttpRequest) -> ApiMessage:
    return ApiMessage(message=wallets_service.greeting())
