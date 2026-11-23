"""What the privacy app publishes over HTTP.

Every decision belongs to PrivacyService; this file renders what
it returns.
"""

from django.http import HttpRequest
from ninja import Router

from apps.privacy.rest.schemas import ApiMessage
from apps.privacy.services import privacy_service

router = Router()


@router.get("/", response=ApiMessage, summary="Example endpoint")
def index(request: HttpRequest) -> ApiMessage:
    return ApiMessage(message=privacy_service.greeting())
