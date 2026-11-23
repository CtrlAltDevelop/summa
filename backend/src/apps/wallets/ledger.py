"""Income and expense entries over the wallet ledger.

Events are immutable in spirit: an edit adds a replacement and voids the old
row, a delete only voids. Everything is scoped to the caller's user.
"""

from collections.abc import Callable
from dataclasses import dataclass
from datetime import datetime
from typing import Any
from uuid import UUID

from django.db import IntegrityError, transaction
from django.utils import timezone

from apps.wallets.models import Direction, EventKind, LedgerEvent, Wallet
from infrastructure.common.errors import ApiError
from infrastructure.common.responses import ResponseTitle

NOTE_MAX_LENGTH = 200
DEFAULT_LIMIT = 50
MAX_LIMIT = 200
_DIRECTION = {EventKind.INCOME: Direction.IN, EventKind.EXPENSE: Direction.OUT}


@dataclass(frozen=True, slots=True)
class Entry:
    id: str
    wallet_id: str
    kind: str
    amount_minor: int
    currency: str
    occurred_at: datetime
    note: str


def _entry(event: LedgerEvent) -> Entry:
    return Entry(
        id=str(event.id),
        wallet_id=str(event.wallet_id),
        kind=event.kind,
        amount_minor=event.amount_minor,
        currency=event.wallet.currency,
        occurred_at=event.occurred_at,
        note=event.note,
    )


def _refuse(message: str) -> ApiError:
    return ApiError(message, 400, title=ResponseTitle.VALIDATION_ERROR)


def _not_found(what: str) -> ApiError:
    return ApiError(f"{what} not found.", 404, title=ResponseTitle.NOT_FOUND)


def _uuid(value: str, what: str) -> UUID:
    try:
        return UUID(value)
    except ValueError:
        raise _not_found(what) from None


def _check_fields(amount_minor: int, note: str) -> str:
    note = note.strip()
    if amount_minor <= 0:
        raise _refuse("The amount must be greater than zero.")
    if len(note) > NOTE_MAX_LENGTH:
        raise _refuse(f"The note is at most {NOTE_MAX_LENGTH} characters.")
    return note


class LedgerService:
    def record(
        self,
        user: Any,
        *,
        wallet_id: str,
        kind: str,
        amount_minor: int,
        occurred_at: datetime | None,
        note: str,
        client_mutation_id: str,
    ) -> Entry:
        if not client_mutation_id or len(client_mutation_id) > 64:
            raise _refuse("client_mutation_id is required (at most 64 characters).")
        if kind not in _DIRECTION:
            raise _refuse(f"Unknown entry kind: {kind}.")
        note = _check_fields(amount_minor, note)
        wallet = Wallet.objects.filter(user=user, id=_uuid(wallet_id, "Wallet")).first()
        if wallet is None:
            raise _not_found("Wallet")
        if wallet.archived:
            raise _refuse("This wallet is archived.")
        try:
            with transaction.atomic():
                event = LedgerEvent.objects.create(
                    user=user,
                    wallet=wallet,
                    kind=kind,
                    direction=_DIRECTION[kind],
                    amount_minor=amount_minor,
                    occurred_at=occurred_at or timezone.now(),
                    note=note,
                    client_mutation_id=client_mutation_id,
                )
        except IntegrityError:
            event = LedgerEvent.objects.get(user=user, client_mutation_id=client_mutation_id)
        return _entry(event)

    def list(self, user: Any, *, wallet_id: str | None, limit: int) -> list[Entry]:
        query = LedgerEvent.objects.filter(
            user=user,
            voided=False,
            kind__in=list(_DIRECTION),
        ).select_related("wallet")
        if wallet_id:
            try:
                query = query.filter(wallet_id=UUID(wallet_id))
            except ValueError:
                return []
        size = min(limit, MAX_LIMIT) if limit > 0 else DEFAULT_LIMIT
        rows = query.order_by("-occurred_at", "-created_at")[:size]
        return [_entry(row) for row in rows]

    def edit(
        self,
        user: Any,
        entry_id: str,
        *,
        amount_minor: int,
        occurred_at: datetime | None,
        note: str,
    ) -> Entry:
        note = _check_fields(amount_minor, note)

        def replace(old: LedgerEvent) -> LedgerEvent:
            old.voided = True
            old.save(update_fields=["voided"])
            return LedgerEvent.objects.create(
                user=user,
                wallet=old.wallet,
                kind=old.kind,
                direction=old.direction,
                amount_minor=amount_minor,
                occurred_at=occurred_at or old.occurred_at,
                note=note,
                replaces=old,
            )

        return _entry(self._change(user, entry_id, replace))

    def delete(self, user: Any, entry_id: str) -> None:
        def void(old: LedgerEvent) -> LedgerEvent:
            old.voided = True
            old.save(update_fields=["voided"])
            return old

        self._change(user, entry_id, void)

    @staticmethod
    def _change(
        user: Any, entry_id: str, apply: Callable[[LedgerEvent], LedgerEvent]
    ) -> LedgerEvent:
        key = _uuid(entry_id, "Entry")
        with transaction.atomic():
            old = (
                LedgerEvent.objects.select_for_update()
                .select_related("wallet")
                .filter(user=user, id=key, voided=False, kind__in=list(_DIRECTION))
                .first()
            )
            if old is None:
                raise _not_found("Entry")
            return apply(old)


ledger_service = LedgerService()
