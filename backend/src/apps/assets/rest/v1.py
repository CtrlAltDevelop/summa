"""What the assets app publishes over HTTP.

Every decision belongs to AssetsService; this file renders what
it returns.
"""

from django.http import HttpRequest
from django.utils import timezone
from ninja import Router

from apps.assets.rates import rate_service
from apps.assets.rest.schemas import ApiMessage, RateOut
from apps.assets.services import assets_service

router = Router()


@router.get("/", response=ApiMessage, summary="Example endpoint")
def index(request: HttpRequest) -> ApiMessage:
    return ApiMessage(message=assets_service.greeting())


@router.get("/rates", response=list[RateOut], summary="Current prices (public, approximate)")
def rates(request: HttpRequest) -> list[RateOut]:
    """Toman per unit. Approximate: this is not an exchange and not a trade quote."""
    return [
        RateOut(
            symbol=r.symbol,
            name=r.name,
            unit=r.unit,
            group=r.group,
            price=format(r.price.normalize(), "f") if r.price is not None else "",
            known=r.known,
            stale=r.stale,
            source=r.source,
            updated_at=r.fetched_at.isoformat() if r.fetched_at else "",
        )
        for r in rate_service.list(timezone.now())
    ]
