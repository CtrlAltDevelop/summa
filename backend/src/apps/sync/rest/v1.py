"""What the sync app publishes over HTTP.

Every decision belongs to SyncService; this file renders what
it returns.
"""

from django.http import HttpRequest
from ninja import Router

from apps.sync.rest.schemas import ApiMessage
from apps.sync.services import sync_service

router = Router()


@router.get("/", response=ApiMessage, summary="Example endpoint")
def index(request: HttpRequest) -> ApiMessage:
    return ApiMessage(message=sync_service.greeting())
