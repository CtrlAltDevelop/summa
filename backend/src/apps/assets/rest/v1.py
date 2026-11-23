"""What the assets app publishes over HTTP.

Every decision belongs to AssetsService; this file renders what
it returns.
"""

from django.http import HttpRequest
from ninja import Router

from apps.assets.rest.schemas import ApiMessage
from apps.assets.services import assets_service

router = Router()


@router.get("/", response=ApiMessage, summary="Example endpoint")
def index(request: HttpRequest) -> ApiMessage:
    return ApiMessage(message=assets_service.greeting())
