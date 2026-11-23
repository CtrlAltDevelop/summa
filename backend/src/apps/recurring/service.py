"""Recurring entries: definitions, the cycles they generate, and answering them."""

from dataclasses import dataclass
from datetime import UTC, date, datetime, time, timedelta
from typing import Any

from django.db import IntegrityError, transaction
from django.utils import timezone

from apps.assistant.calendar import TEHRAN
from apps.recurring.models import Occurrence, Recurring
from apps.recurring.schedule import PERIODS, next_due, valid_day
from apps.wallets.categories import resolve_category
from apps.wallets.ledger import NOTE_MAX_LENGTH, Entry, ledger_service
from apps.wallets.models import Wallet
from apps.wallets.services import wallets_service
from apps.wallets.validation import not_found, parse_uuid, refuse
from infrastructure.common.errors import ApiError

LEAD_DAYS = 3
MAX_CATCH_UP = 12
_ACTIONS = ("confirm", "other_wallet", "cancel", "postpone")
_NOON = time(12, 0)


@dataclass(frozen=True, slots=True)
class RecurringView:
    id: str
    wallet_id: str
    kind: str
    amount_minor: int  # 0 = variable
    currency: str
    category_id: str
    note: str
    period: str
    day: int
    auto_confirm: bool
    active: bool
    next_due: date


@dataclass(frozen=True, slots=True)
class OccurrenceView:
    id: str
    recurring_id: str
    wallet_id: str
    kind: str
    amount_minor: int  # 0 = variable
    currency: str
    note: str
    due_date: date
    status: str  # upcoming | due
    low_balance: bool


@dataclass(frozen=True, slots=True)
class RecurringList:
    recurrings: list[RecurringView]
    occurrences: list[OccurrenceView]


def _today(now: datetime) -> date:
    return now.astimezone(TEHRAN).date()


def _view(r: Recurring) -> RecurringView:
    return RecurringView(
        id=str(r.id),
        wallet_id=str(r.wallet_id),
        kind=r.kind,
        amount_minor=r.amount_minor or 0,
        currency=r.wallet.currency,
        category_id=str(r.category_id or ""),
        note=r.note,
        period=r.period,
        day=r.day,
        auto_confirm=r.auto_confirm,
        active=r.active,
        next_due=r.next_due,
    )


def _own(user: Any, recurring_id: str) -> Recurring:
    found = (
        Recurring.objects.select_related("wallet")
        .filter(user=user, id=parse_uuid(recurring_id, "Recurring"))
        .first()
    )
    if found is None:
        raise not_found("Recurring")
    return found


class RecurringService:
    def create(
        self,
        user: Any,
        *,
        wallet_id: str,
        kind: str,
        amount_minor: int,
        category_id: str | None,
        note: str,
        period: str,
        day: int,
        auto_confirm: bool,
        client_mutation_id: str,
        now: datetime,
    ) -> RecurringView:
        note = note.strip()
        if not client_mutation_id or len(client_mutation_id) > 64:
            raise refuse("client_mutation_id is required (at most 64 characters).")
        if kind not in ("expense", "income"):
            raise refuse(f"Unknown kind: {kind}.")
        if period not in PERIODS or not valid_day(period, day):
            raise refuse("The period or the day is not valid.")
        if amount_minor < 0:
            raise refuse("The amount cannot be negative.")
        if auto_confirm and amount_minor == 0:
            raise refuse("A variable amount cannot be confirmed automatically.")
        if len(note) > NOTE_MAX_LENGTH:
            raise refuse(f"The note is at most {NOTE_MAX_LENGTH} characters.")
        wallet = Wallet.objects.filter(user=user, id=parse_uuid(wallet_id, "Wallet")).first()
        if wallet is None:
            raise not_found("Wallet")
        if wallet.archived:
            raise refuse("This wallet is archived.")
        category = resolve_category(user, category_id, kind)
        try:
            with transaction.atomic():
                created = Recurring.objects.create(
                    user=user,
                    wallet=wallet,
                    kind=kind,
                    amount_minor=amount_minor or None,
                    category=category,
                    note=note,
                    period=period,
                    day=day,
                    auto_confirm=auto_confirm,
                    next_due=next_due(period, day, _today(now)),
                    client_mutation_id=client_mutation_id,
                )
        except IntegrityError:
            created = Recurring.objects.select_related("wallet").get(
                user=user, client_mutation_id=client_mutation_id
            )
        return _view(created)

    def list(self, user: Any, now: datetime) -> RecurringList:
        self.process(user, now)
        today = _today(now)
        balances = {w.id: w.balance_minor for w in wallets_service.list(user).wallets}
        pending = Occurrence.objects.filter(user=user, status=Occurrence.PENDING).select_related(
            "recurring__wallet"
        )
        occurrences = []
        for o in pending:
            r = o.recurring
            amount = o.amount_minor or 0
            occurrences.append(
                OccurrenceView(
                    id=str(o.id),
                    recurring_id=str(r.id),
                    wallet_id=str(r.wallet_id),
                    kind=r.kind,
                    amount_minor=amount,
                    currency=r.wallet.currency,
                    note=r.note,
                    due_date=o.due_date,
                    status="due" if o.due_date <= today else "upcoming",
                    low_balance=r.kind == "expense"
                    and amount > 0
                    and balances.get(str(r.wallet_id), 0) < amount,
                )
            )
        recurrings = Recurring.objects.filter(user=user).select_related("wallet")
        return RecurringList([_view(r) for r in recurrings], occurrences)

    def process(self, user: Any, now: datetime) -> None:
        """Open the cycles that are due or within the lead window; auto-confirm the due ones."""
        today = _today(now)
        horizon = today + timedelta(days=LEAD_DAYS)
        with transaction.atomic():
            for r in Recurring.objects.select_for_update().filter(user=user, active=True):
                made = 0
                while r.next_due <= horizon and made < MAX_CATCH_UP:
                    Occurrence.objects.get_or_create(
                        recurring=r,
                        due_date=r.next_due,
                        defaults={"user": user, "amount_minor": r.amount_minor},
                    )
                    r.next_due = next_due(r.period, r.day, r.next_due + timedelta(days=1))
                    made += 1
                if made:
                    r.save(update_fields=["next_due"])
        auto = Occurrence.objects.filter(
            user=user,
            status=Occurrence.PENDING,
            due_date__lte=today,
            recurring__auto_confirm=True,
            recurring__active=True,
            amount_minor__isnull=False,
        )
        for o in auto:
            try:
                self.resolve(user, str(o.id), action="confirm", wallet_id=None, amount_minor=0)
            except ApiError:
                continue  # it stays a question for the person to answer

    def process_all(self, now: datetime) -> int:
        users = {r.user for r in Recurring.objects.filter(active=True).select_related("user")}
        for user in users:
            self.process(user, now)
        return len(users)

    def resolve(
        self,
        user: Any,
        occurrence_id: str,
        *,
        action: str,
        wallet_id: str | None,
        amount_minor: int,
        now: datetime | None = None,
    ) -> Entry | None:
        if action not in _ACTIONS:
            raise refuse(f"Unknown action: {action}.")
        key = parse_uuid(occurrence_id, "Occurrence")
        with transaction.atomic():
            occurrence = (
                Occurrence.objects.select_for_update()
                .select_related("recurring__wallet")
                .filter(user=user, id=key)
                .first()
            )
            if occurrence is None:
                raise not_found("Occurrence")
            if occurrence.status != Occurrence.PENDING:
                raise refuse("This one was already answered.")
            if action == "cancel":
                occurrence.status = Occurrence.CANCELLED
                occurrence.save(update_fields=["status"])
                return None
            if action == "postpone":
                self._postpone(occurrence)
                return None
            recurring = occurrence.recurring
            target = recurring.wallet_id
            if action == "other_wallet":
                if not wallet_id:
                    raise refuse("Choose the wallet that paid.")
                other = Wallet.objects.filter(user=user, id=parse_uuid(wallet_id, "Wallet")).first()
                if other is None:
                    raise not_found("Wallet")
                if other.currency != recurring.wallet.currency:
                    raise refuse("Choose a wallet of the same currency.")
                target = other.id
            amount = amount_minor or occurrence.amount_minor or 0
            if amount <= 0:
                raise refuse("Enter the amount.")
            entry = ledger_service.record(
                user,
                wallet_id=str(target),
                kind=recurring.kind,
                amount_minor=amount,
                occurred_at=datetime.combine(
                    min(occurrence.due_date, _today(now or timezone.now())), _NOON, TEHRAN
                ).astimezone(UTC),
                note=recurring.note,
                client_mutation_id=f"rec-{occurrence.id}",
                category_id=str(recurring.category_id) if recurring.category_id else None,
            )
            occurrence.status = Occurrence.CONFIRMED
            occurrence.entry_id = parse_uuid(entry.id, "Entry")
            occurrence.save(update_fields=["status", "entry_id"])
            return entry

    @staticmethod
    def _postpone(occurrence: Occurrence) -> None:
        """ "Not yet": ask again tomorrow."""
        tomorrow = occurrence.due_date + timedelta(days=1)
        if Occurrence.objects.filter(recurring=occurrence.recurring, due_date=tomorrow).exists():
            raise refuse("The next cycle is already tomorrow; answer this one instead.")
        occurrence.due_date = tomorrow
        occurrence.save(update_fields=["due_date"])

    def settle_now(
        self, user: Any, recurring_id: str, *, amount_minor: int, now: datetime
    ) -> Entry:
        """ "I got it" / "it was paid": settle the next cycle now, even before its window."""
        recurring = _own(user, recurring_id)
        with transaction.atomic():
            locked = Recurring.objects.select_for_update().get(pk=recurring.pk)
            occurrence = (
                Occurrence.objects.filter(recurring=locked, status=Occurrence.PENDING)
                .order_by("due_date")
                .first()
            )
            if occurrence is None:
                occurrence = Occurrence.objects.create(
                    user=user,
                    recurring=locked,
                    due_date=locked.next_due,
                    amount_minor=locked.amount_minor,
                )
                locked.next_due = next_due(
                    locked.period, locked.day, locked.next_due + timedelta(days=1)
                )
                locked.save(update_fields=["next_due"])
            entry = self.resolve(
                user,
                str(occurrence.id),
                action="confirm",
                wallet_id=None,
                amount_minor=amount_minor,
                now=now,
            )
        if entry is None:  # pragma: no cover - confirm always records
            raise refuse("Nothing was recorded.")
        return entry

    def set_active(self, user: Any, recurring_id: str, *, active: bool) -> None:
        recurring = _own(user, recurring_id)
        recurring.active = active
        recurring.save(update_fields=["active"])

    def delete(self, user: Any, recurring_id: str) -> None:
        _own(user, recurring_id).delete()


recurring_service = RecurringService()
