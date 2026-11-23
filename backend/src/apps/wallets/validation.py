"""Shared refusals and id parsing for the wallets services."""

from uuid import UUID

from infrastructure.common.errors import ApiError
from infrastructure.common.responses import ResponseTitle


def refuse(message: str) -> ApiError:
    return ApiError(message, 400, title=ResponseTitle.VALIDATION_ERROR)


def not_found(what: str) -> ApiError:
    return ApiError(f"{what} not found.", 404, title=ResponseTitle.NOT_FOUND)


def parse_uuid(value: str, what: str) -> UUID:
    try:
        return UUID(value)
    except ValueError:
        raise not_found(what) from None
