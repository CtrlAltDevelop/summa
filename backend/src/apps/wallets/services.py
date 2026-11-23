"""Everything the wallets app decides, independent of who asked.

Balances are derived: a wallet's balance is the sum of its ledger events, never a
stored column. Every read and write is scoped to the caller's user.
"""

from dataclasses import dataclass
from typing import Any
from uuid import UUID

from django.db import IntegrityError, transaction
from django.db.models import Case, F, IntegerField, Q, Sum, When

from apps.wallets.models import Direction, EventKind, LedgerEvent, Wallet
from apps.wallets.profile import BANK_MAX_LENGTH, CURRENCIES, DEBT_KINDS, KINDS, NAME_MAX_LENGTH
from infrastructure.common.errors import ApiError
from infrastructure.common.responses import ResponseTitle


@dataclass(frozen=True, slots=True)
class WalletView:
    id: str
    name: str
    kind: str
    currency: str
    bank: str
    archived: bool
    balance_minor: int


@dataclass(frozen=True, slots=True)
class CurrencyTotal:
    currency: str
    balance_minor: int


@dataclass(frozen=True, slots=True)
class WalletList:
    wallets: list[WalletView]
    #: Per currency, active wallets only. A base-currency total needs rates (phase 09).
    totals: list[CurrencyTotal]


def _signed_sum() -> Sum:
    amount = F("events__amount_minor")
    signed = Case(
        When(events__direction=Direction.IN, then=amount),
        default=-amount,
        output_field=IntegerField(),
    )
    return Sum(signed, filter=Q(events__voided=False))


def _view(wallet: Wallet, balance: int | None) -> WalletView:
    return WalletView(
        id=str(wallet.id),
        name=wallet.name,
        kind=wallet.kind,
        currency=wallet.currency,
        bank=wallet.bank,
        archived=wallet.archived,
        balance_minor=balance or 0,
    )


def _refuse(message: str) -> ApiError:
    return ApiError(message, 400, title=ResponseTitle.VALIDATION_ERROR)


class WalletsService:
    """The wallets app's own operations."""

    def greeting(self) -> str:
        return "Wallets v1 API"

    def create(
        self,
        user: Any,
        *,
        name: str,
        kind: str,
        currency: str,
        bank: str,
        opening_balance_minor: int,
        client_mutation_id: str,
    ) -> WalletView:
        name, bank = name.strip(), bank.strip()
        if not client_mutation_id or len(client_mutation_id) > 64:
            raise _refuse("client_mutation_id is required (at most 64 characters).")
        if not name or len(name) > NAME_MAX_LENGTH:
            raise _refuse(f"The wallet name must be 1 to {NAME_MAX_LENGTH} characters.")
        if len(bank) > BANK_MAX_LENGTH:
            raise _refuse(f"The bank name is at most {BANK_MAX_LENGTH} characters.")
        if kind not in KINDS:
            raise _refuse(f"Unknown wallet kind: {kind}.")
        if currency not in CURRENCIES:
            raise _refuse(f"Unsupported currency: {currency}.")
        if opening_balance_minor < 0 and kind not in DEBT_KINDS:
            raise _refuse("Only a credit card or BNPL wallet may open with a negative balance.")

        try:
            with transaction.atomic():
                wallet = Wallet.objects.create(
                    user=user,
                    name=name,
                    kind=kind,
                    currency=currency,
                    bank=bank,
                    client_mutation_id=client_mutation_id,
                )
                if opening_balance_minor:
                    LedgerEvent.objects.create(
                        user=user,
                        wallet=wallet,
                        kind=EventKind.OPENING_BALANCE,
                        direction=Direction.IN if opening_balance_minor > 0 else Direction.OUT,
                        amount_minor=abs(opening_balance_minor),
                    )
        except IntegrityError:
            # The same mutation arrived twice: answer with what the first one made.
            wallet = Wallet.objects.get(user=user, client_mutation_id=client_mutation_id)
        return self._view_of(user, wallet.id)

    def list(self, user: Any) -> WalletList:
        rows = Wallet.objects.filter(user=user).annotate(balance=_signed_sum())
        wallets = [_view(row, row.balance) for row in rows]
        totals: dict[str, int] = {}
        for view in wallets:
            if not view.archived:
                totals[view.currency] = totals.get(view.currency, 0) + view.balance_minor
        return WalletList(
            wallets=wallets,
            totals=[CurrencyTotal(c, b) for c, b in sorted(totals.items())],
        )

    def archive(self, user: Any, wallet_id: str) -> WalletView:
        try:
            key = UUID(wallet_id)
        except ValueError:
            raise self._not_found() from None
        updated = Wallet.objects.filter(user=user, id=key).update(archived=True)
        if not updated:
            raise self._not_found()
        return self._view_of(user, key)

    def _view_of(self, user: Any, key: UUID) -> WalletView:
        row = Wallet.objects.filter(user=user, id=key).annotate(balance=_signed_sum()).get()
        return _view(row, row.balance)

    @staticmethod
    def _not_found() -> ApiError:
        return ApiError("Wallet not found.", 404, title=ResponseTitle.NOT_FOUND)


wallets_service = WalletsService()
