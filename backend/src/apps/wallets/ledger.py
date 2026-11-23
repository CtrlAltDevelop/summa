"""Income and expense entries over the wallet ledger.

Events are immutable in spirit: an edit adds a replacement and voids the old
row, a delete only voids. Everything is scoped to the caller's user.
"""

from collections.abc import Callable
from dataclasses import dataclass
from datetime import datetime
from typing import Any
from uuid import UUID, uuid4

from django.db import IntegrityError, transaction
from django.utils import timezone

from apps.wallets.categories import resolve_category
from apps.wallets.models import Direction, EventKind, LedgerEvent, Wallet
from apps.wallets.validation import not_found as _not_found
from apps.wallets.validation import parse_uuid as _uuid
from apps.wallets.validation import refuse as _refuse

NOTE_MAX_LENGTH = 200
MIN_SPLIT_PARTS = 2
MAX_SPLIT_PARTS = 10
DEFAULT_LIMIT = 50
MAX_LIMIT = 200
_DIRECTION = {EventKind.INCOME: Direction.IN, EventKind.EXPENSE: Direction.OUT}
# What the list shows and delete may void; only income/expense can be recorded or edited.
_LISTED = [*_DIRECTION, EventKind.TRANSFER_OUT, EventKind.TRANSFER_IN]


@dataclass(frozen=True, slots=True)
class Entry:
    id: str
    wallet_id: str
    kind: str
    amount_minor: int
    currency: str
    occurred_at: datetime
    note: str
    category_id: str
    outside_totals: bool = False
    split_id: str = ""


@dataclass(frozen=True, slots=True)
class SplitPart:
    """One share of a split expense: its category (or empty) and amount."""

    category_id: str
    amount_minor: int
    outside_totals: bool = False


def _entry(event: LedgerEvent) -> Entry:
    return Entry(
        id=str(event.id),
        wallet_id=str(event.wallet_id),
        kind=event.kind,
        amount_minor=event.amount_minor,
        currency=event.wallet.currency,
        occurred_at=event.occurred_at,
        note=event.note,
        category_id=str(event.category_id or ""),
        outside_totals=event.outside_totals,
        split_id=str(event.split_id or ""),
    )


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
        category_id: str | None = None,
        outside_totals: bool = False,
    ) -> Entry:
        if not client_mutation_id or len(client_mutation_id) > 64:
            raise _refuse("client_mutation_id is required (at most 64 characters).")
        if kind not in _DIRECTION:
            raise _refuse(f"Unknown entry kind: {kind}.")
        note = _check_fields(amount_minor, note)
        if outside_totals and kind != EventKind.EXPENSE:
            raise _refuse("Only an expense can be outside the totals.")
        wallet = self._open_wallet(user, wallet_id)
        category = resolve_category(user, category_id, kind)
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
                    category=category,
                    outside_totals=outside_totals,
                    client_mutation_id=client_mutation_id,
                )
        except IntegrityError:
            event = LedgerEvent.objects.get(user=user, client_mutation_id=client_mutation_id)
        return _entry(event)

    def record_split(
        self,
        user: Any,
        *,
        wallet_id: str,
        parts: list[SplitPart],
        occurred_at: datetime | None,
        note: str,
        client_mutation_id: str,
    ) -> list[Entry]:
        """One expense shared between categories; each part is its own expense event."""
        if not client_mutation_id or len(client_mutation_id) > 64:
            raise _refuse("client_mutation_id is required (at most 64 characters).")
        if not MIN_SPLIT_PARTS <= len(parts) <= MAX_SPLIT_PARTS:
            raise _refuse(f"A split has {MIN_SPLIT_PARTS} to {MAX_SPLIT_PARTS} parts.")
        note = _check_fields(min(part.amount_minor for part in parts), note)
        wallet = self._open_wallet(user, wallet_id)
        categories = [resolve_category(user, part.category_id, "expense") for part in parts]
        when, group = occurred_at or timezone.now(), uuid4()
        try:
            with transaction.atomic():
                events = [
                    LedgerEvent.objects.create(
                        user=user,
                        wallet=wallet,
                        kind=EventKind.EXPENSE,
                        direction=Direction.OUT,
                        amount_minor=part.amount_minor,
                        occurred_at=when,
                        note=note,
                        category=category,
                        outside_totals=part.outside_totals,
                        split_id=group,
                        client_mutation_id=client_mutation_id if index == 0 else "",
                    )
                    for index, (part, category) in enumerate(zip(parts, categories, strict=True))
                ]
        except IntegrityError:
            first = LedgerEvent.objects.get(user=user, client_mutation_id=client_mutation_id)
            events = list(
                LedgerEvent.objects.filter(user=user, split_id=first.split_id)
                .select_related("wallet")
                .order_by("created_at", "id")
            )
        return [_entry(event) for event in events]

    @staticmethod
    def _open_wallet(user: Any, wallet_id: str) -> Wallet:
        wallet = Wallet.objects.filter(user=user, id=_uuid(wallet_id, "Wallet")).first()
        if wallet is None:
            raise _not_found("Wallet")
        if wallet.archived:
            raise _refuse("This wallet is archived.")
        return wallet

    def list(self, user: Any, *, wallet_id: str | None, limit: int) -> list[Entry]:
        query = LedgerEvent.objects.filter(
            user=user,
            voided=False,
            kind__in=_LISTED,
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
        category_id: str | None = None,
        outside_totals: bool | None = None,
    ) -> Entry:
        note = _check_fields(amount_minor, note)

        def replace(old: LedgerEvent) -> LedgerEvent:
            if old.transfer_id is not None:
                raise _refuse("A transfer cannot be edited. Delete it and make a new one.")
            if old.split_id is not None:
                raise _refuse("A split cannot be edited. Delete it and record it again.")
            outside = old.outside_totals if outside_totals is None else outside_totals
            if outside and old.kind != EventKind.EXPENSE:
                raise _refuse("Only an expense can be outside the totals.")
            category = (
                resolve_category(user, category_id, old.kind)
                if category_id is not None
                else old.category
            )
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
                category=category,
                outside_totals=outside,
                replaces=old,
            )

        return _entry(self._change(user, entry_id, replace))

    def delete(self, user: Any, entry_id: str) -> None:
        def void(old: LedgerEvent) -> LedgerEvent:
            if old.transfer_id is not None:
                # One transfer is one thing to the user: void every leg together.
                LedgerEvent.objects.filter(user=user, transfer_id=old.transfer_id).update(
                    voided=True
                )
            if old.split_id is not None:
                LedgerEvent.objects.filter(user=user, split_id=old.split_id).update(voided=True)
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
                .filter(user=user, id=key, voided=False, kind__in=_LISTED)
                .first()
            )
            if old is None:
                raise _not_found("Entry")
            return apply(old)


ledger_service = LedgerService()
