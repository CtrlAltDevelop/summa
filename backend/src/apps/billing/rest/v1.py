"""What the billing app publishes over HTTP.

Every decision belongs to BillingService; this file renders what
it returns.
"""

from django.http import HttpRequest
from ninja import Router

from apps.billing.rest.schemas import ApiMessage, PlanOut
from apps.billing.service import billing_service as _billing
from apps.billing.services import billing_service

router = Router()


@router.get("/", response=ApiMessage, summary="Example endpoint")
def index(request: HttpRequest) -> ApiMessage:
    return ApiMessage(message=billing_service.greeting())


@router.get("/plans", response=list[PlanOut], summary="The plans on sale (public)")
def plans(request: HttpRequest) -> list[PlanOut]:
    """What the landing page shows as prices. Edited in the admin; none ship with the app."""
    return [
        PlanOut(
            code=p.code,
            name=p.name,
            description=p.description,
            price_minor=p.price_minor,
            period_days=p.period_days,
        )
        for p in _billing.plans()
    ]
