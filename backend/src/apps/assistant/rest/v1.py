"""What the assistant app publishes over HTTP.

Every decision belongs to AssistantService; this file renders what
it returns.
"""

from django.http import HttpRequest
from ninja import Router

from apps.assistant.rest.schemas import ApiMessage
from apps.assistant.services import assistant_service

router = Router()


@router.get("/", response=ApiMessage, summary="Example endpoint")
def index(request: HttpRequest) -> ApiMessage:
    return ApiMessage(message=assistant_service.greeting())
