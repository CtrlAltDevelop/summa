"""What the assistant app publishes over HTTP.

Every decision belongs to AssistantService; this file renders what
it returns.
"""

from django.http import HttpRequest
from ninja import Router

from apps.assistant.demo import demo_reply
from apps.assistant.rest.schemas import ApiMessage, DemoCardOut, DemoOut, DemoRequest
from apps.assistant.services import assistant_service

router = Router()


@router.get("/", response=ApiMessage, summary="Example endpoint")
def index(request: HttpRequest) -> ApiMessage:
    return ApiMessage(message=assistant_service.greeting())


@router.post(
    "/demo",
    response=DemoOut,
    summary="Try the sentence parser (public demo, nothing is stored)",
)
def demo(request: HttpRequest, payload: DemoRequest) -> DemoOut:
    """Runs the real parser on a sample account for the landing page.

    Public and stateless; limited per client address. Behind a reverse proxy the
    address is the proxy's unless the proxy is trusted to set it, which is a
    deployment decision, not made here.
    """
    answer = demo_reply(payload.text, request.META.get("REMOTE_ADDR", "unknown"))
    card = answer.card
    return DemoOut(
        reply=answer.reply,
        card=None
        if card is None
        else DemoCardOut(
            kind=card.kind,
            amount_minor=card.amount_minor,
            currency=card.currency,
            amount_text=card.amount_text,
            wallet=card.wallet,
            to_wallet=card.to_wallet,
            category=card.category,
            note=card.note,
            occurred_at=card.occurred_at.isoformat(),
        ),
    )
