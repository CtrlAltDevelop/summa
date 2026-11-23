"""Debts repaid in installments: the schedule, paying, and undoing a payment."""

from dataclasses import dataclass
from datetime import date, datetime, timedelta
from typing import Any

from django.db import IntegrityError, transaction

from apps.assistant.calendar import TEHRAN, gregorian_to_jalali
from apps.debts.models import KINDS, Debt, Installment
from apps.recurring.schedule import next_due
from apps.wallets.categories import resolve_category
from apps.wallets.ledger import Entry, ledger_service
from apps.wallets.models import Wallet
from apps.wallets.profile import CURRENCIES
from apps.wallets.validation import not_found, parse_uuid, refuse
from infrastructure.common.errors import ApiError

MAX_INSTALLMENTS = 120
TITLE_MAX_LENGTH = 60


@dataclass(frozen=True, slots=True)
class InstallmentView:
    id: str
    number: int
    due_date: date
    amount_minor: int
    paid: bool
    overdue: bool


@dataclass(frozen=True, slots=True)
class DebtView:
    id: str
    kind: str
    title: str
    currency: str
    installment_minor: int
    count: int
    principal_minor: int
    wallet_id: str
    category_id: str
    paid_count: int
    remaining_minor: int
    next_due: date | None
    closed: bool
    installments: list[InstallmentView]


def _view(debt: Debt, today: date) -> DebtView:
    rows = list(debt.installments.all())
    pending = [r for r in rows if r.status == Installment.PENDING]
    return DebtView(
        id=str(debt.id),
        kind=debt.kind,
        title=debt.title,
        currency=debt.currency,
        installment_minor=debt.installment_minor,
        count=debt.count,
        principal_minor=debt.principal_minor,
        wallet_id=str(debt.wallet_id or ""),
        category_id=str(debt.category_id or ""),
        paid_count=len(rows) - len(pending),
        remaining_minor=sum(r.amount_minor for r in pending),
        next_due=pending[0].due_date if pending else None,
        closed=not pending,
        installments=[
            InstallmentView(
                id=str(r.id),
                number=r.number,
                due_date=r.due_date,
                amount_minor=r.amount_minor,
                paid=r.status == Installment.PAID,
                overdue=r.status == Installment.PENDING and r.due_date < today,
            )
            for r in rows
        ],
    )


def _today(now: datetime) -> date:
    return now.astimezone(TEHRAN).date()


def _schedule(first_due: date, count: int) -> list[date]:
    """Monthly on the Shamsi day of ``first_due``; a day a month lacks clamps to its end."""
    day = gregorian_to_jalali(first_due.year, first_due.month, first_due.day)[2]
    dates = [first_due]
    while len(dates) < count:
        dates.append(next_due("monthly", day, dates[-1] + timedelta(days=1)))
    return dates


def _own_debt(user: Any, debt_id: str) -> Debt:
    debt = Debt.objects.filter(user=user, id=parse_uuid(debt_id, "Debt")).first()
    if debt is None:
        raise not_found("Debt")
    return debt


class DebtService:
    def create(
        self,
        user: Any,
        *,
        kind: str,
        title: str,
        currency: str,
        installment_minor: int,
        count: int,
        first_due: date,
        principal_minor: int,
        wallet_id: str | None,
        category_id: str | None,
        client_mutation_id: str,
        now: datetime,
    ) -> DebtView:
        title = title.strip()
        if not client_mutation_id or len(client_mutation_id) > 64:
            raise refuse("client_mutation_id is required (at most 64 characters).")
        if kind not in KINDS:
            raise refuse(f"Unknown kind: {kind}.")
        if not title or len(title) > TITLE_MAX_LENGTH:
            raise refuse(f"The title must be 1 to {TITLE_MAX_LENGTH} characters.")
        if currency not in CURRENCIES:
            raise refuse(f"Unsupported currency: {currency}.")
        if installment_minor <= 0 or principal_minor < 0:
            raise refuse("The installment must be positive and the principal not negative.")
        if not 1 <= count <= MAX_INSTALLMENTS:
            raise refuse(f"The number of installments is 1 to {MAX_INSTALLMENTS}.")
        wallet = None
        if wallet_id:
            wallet = Wallet.objects.filter(user=user, id=parse_uuid(wallet_id, "Wallet")).first()
            if wallet is None:
                raise not_found("Wallet")
            if wallet.archived or wallet.currency != currency:
                raise refuse("Choose an open wallet of the debt's currency.")
        category = resolve_category(user, category_id, "expense")
        try:
            with transaction.atomic():
                debt = Debt.objects.create(
                    user=user,
                    kind=kind,
                    title=title,
                    currency=currency,
                    installment_minor=installment_minor,
                    count=count,
                    principal_minor=principal_minor,
                    wallet=wallet,
                    category=category,
                    client_mutation_id=client_mutation_id,
                )
                Installment.objects.bulk_create(
                    Installment(
                        user=user,
                        debt=debt,
                        number=number,
                        due_date=due,
                        amount_minor=installment_minor,
                    )
                    for number, due in enumerate(_schedule(first_due, count), start=1)
                )
        except IntegrityError:
            debt = Debt.objects.get(user=user, client_mutation_id=client_mutation_id)
        return _view(debt, _today(now))

    def list(self, user: Any, now: datetime) -> list[DebtView]:
        today = _today(now)
        debts = Debt.objects.filter(user=user).prefetch_related("installments")
        return [_view(d, today) for d in debts]

    def pay(
        self,
        user: Any,
        installment_id: str,
        *,
        wallet_id: str | None,
        amount_minor: int,
        now: datetime,
    ) -> Entry:
        if amount_minor < 0:
            raise refuse("The amount cannot be negative.")
        key = parse_uuid(installment_id, "Installment")
        with transaction.atomic():
            installment = (
                Installment.objects.select_for_update()
                .select_related("debt")
                .filter(user=user, id=key)
                .first()
            )
            if installment is None:
                raise not_found("Installment")
            debt = installment.debt
            if installment.status == Installment.PAID:
                raise refuse("This installment is already paid.")
            target = wallet_id or (str(debt.wallet_id) if debt.wallet_id else "")
            if not target:
                raise refuse("Choose the wallet that pays.")
            wallet = Wallet.objects.filter(user=user, id=parse_uuid(target, "Wallet")).first()
            if wallet is None:
                raise not_found("Wallet")
            if wallet.currency != debt.currency:
                raise refuse("Pay from a wallet of the debt's currency.")
            attempt = installment.pay_attempts + 1
            entry = ledger_service.record(
                user,
                wallet_id=str(wallet.id),
                kind="expense",
                amount_minor=amount_minor or installment.amount_minor,
                occurred_at=now,
                note=f"{debt.title} ({installment.number}/{debt.count})",
                client_mutation_id=f"inst-{installment.id}-{attempt}",
                category_id=str(debt.category_id) if debt.category_id else None,
            )
            installment.status = Installment.PAID
            installment.entry_id = parse_uuid(entry.id, "Entry")
            installment.pay_attempts = attempt
            installment.save(update_fields=["status", "entry_id", "pay_attempts"])
            return entry

    def unpay(self, user: Any, installment_id: str) -> None:
        key = parse_uuid(installment_id, "Installment")
        with transaction.atomic():
            installment = Installment.objects.select_for_update().filter(user=user, id=key).first()
            if installment is None:
                raise not_found("Installment")
            if installment.status != Installment.PAID:
                raise refuse("This installment is not paid.")
            if installment.entry_id:
                try:
                    ledger_service.delete(user, str(installment.entry_id))
                except ApiError as error:
                    if error.status != 404:  # already deleted by hand: nothing to undo
                        raise
            installment.status = Installment.PENDING
            installment.entry_id = None
            installment.save(update_fields=["status", "entry_id"])

    def delete(self, user: Any, debt_id: str) -> None:
        _own_debt(user, debt_id).delete()


debt_service = DebtService()
