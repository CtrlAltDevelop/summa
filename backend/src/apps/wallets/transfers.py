"""Moving money between two of the caller's own wallets.

A transfer is two paired events sharing a ``transfer_id`` (out of the source,
into the destination) plus an optional fee, which is an ordinary expense on the
source. Across currencies the user types the rate; the destination amount is
computed with Decimal and rounded half up, never with floats.
"""

import re
import uuid
from datetime import datetime
from decimal import ROUND_HALF_UP, Decimal
from typing import Any

from django.db import IntegrityError, transaction
from django.utils import timezone

from apps.wallets.ledger import (
    NOTE_MAX_LENGTH,
    Entry,
    _entry,
    _not_found,
    _refuse,
    _uuid,
)
from apps.wallets.models import Direction, EventKind, LedgerEvent, Wallet
from apps.wallets.profile import CURRENCIES

_RATE = re.compile(r"\d{1,15}(\.\d{1,15})?")
_MAX_MINOR = 2**63 - 1


def _destination_minor(src: Wallet, dst: Wallet, amount_minor: int, rate: str) -> int:
    if src.currency == dst.currency:
        if rate:
            raise _refuse("No rate is needed between wallets of the same currency.")
        return amount_minor
    if not _RATE.fullmatch(rate) or Decimal(rate) <= 0:
        raise _refuse("Enter a rate greater than zero (digits and one decimal point).")
    shift = Decimal(10) ** (CURRENCIES[dst.currency] - CURRENCIES[src.currency])
    converted = (Decimal(amount_minor) * Decimal(rate) * shift).quantize(
        Decimal(1), rounding=ROUND_HALF_UP
    )
    if converted <= 0:
        raise _refuse("That amount is too small at this rate.")
    if converted > _MAX_MINOR:
        raise _refuse("That amount is too large at this rate.")
    return int(converted)


class TransferService:
    def transfer(
        self,
        user: Any,
        *,
        from_wallet_id: str,
        to_wallet_id: str,
        amount_minor: int,
        rate: str,
        fee_minor: int,
        occurred_at: datetime | None,
        note: str,
        client_mutation_id: str,
    ) -> list[Entry]:
        note = note.strip()
        rate = rate.strip()
        if not client_mutation_id or len(client_mutation_id) > 64:
            raise _refuse("client_mutation_id is required (at most 64 characters).")
        if amount_minor <= 0:
            raise _refuse("The amount must be greater than zero.")
        if fee_minor < 0:
            raise _refuse("The fee cannot be negative.")
        if len(note) > NOTE_MAX_LENGTH:
            raise _refuse(f"The note is at most {NOTE_MAX_LENGTH} characters.")
        if from_wallet_id == to_wallet_id:
            raise _refuse("Choose two different wallets.")
        src, dst = self._wallet(user, from_wallet_id), self._wallet(user, to_wallet_id)
        if src.archived or dst.archived:
            raise _refuse("An archived wallet cannot take part in a transfer.")
        received = _destination_minor(src, dst, amount_minor, rate)

        when = occurred_at or timezone.now()
        group = uuid.uuid4()
        try:
            with transaction.atomic():
                legs = [
                    self._event(
                        user, src, EventKind.TRANSFER_OUT, Direction.OUT, amount_minor,
                        when, note, group, rate, client_mutation_id,
                    ),
                    self._event(
                        user, dst, EventKind.TRANSFER_IN, Direction.IN, received,
                        when, note, group, rate, "",
                    ),
                ]  # fmt: skip
                if fee_minor:
                    legs.append(
                        self._event(
                            user,
                            src,
                            EventKind.EXPENSE,
                            Direction.OUT,
                            fee_minor,
                            when,
                            note,
                            group,
                            "",
                            "",
                        )  # fmt: skip
                    )
        except IntegrityError:
            first = LedgerEvent.objects.get(user=user, client_mutation_id=client_mutation_id)
            legs = list(
                LedgerEvent.objects.filter(user=user, transfer_id=first.transfer_id)
                .select_related("wallet")
                .order_by("created_at", "id")
            )
        return [_entry(leg) for leg in legs]

    @staticmethod
    def _wallet(user: Any, wallet_id: str) -> Wallet:
        wallet = Wallet.objects.filter(user=user, id=_uuid(wallet_id, "Wallet")).first()
        if wallet is None:
            raise _not_found("Wallet")
        return wallet

    @staticmethod
    def _event(
        user: Any,
        wallet: Wallet,
        kind: str,
        direction: str,
        amount_minor: int,
        when: datetime,
        note: str,
        group: uuid.UUID,
        rate: str,
        mutation_id: str,
    ) -> LedgerEvent:
        event = LedgerEvent.objects.create(
            user=user,
            wallet=wallet,
            kind=kind,
            direction=direction,
            amount_minor=amount_minor,
            occurred_at=when,
            note=note,
            transfer_id=group,
            rate=rate,
            client_mutation_id=mutation_id,
        )
        return event


transfer_service = TransferService()
