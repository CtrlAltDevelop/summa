"""The change feed a second device (or a reinstall) catches up from.

Three independent feeds (wallets, categories, ledger events), each walked with a
keyset cursor ``(updated_at, id)`` so a page boundary never skips or repeats a
row, even when many rows share one timestamp. The last page leaves the cursor
``OVERLAP`` behind the newest row: a transaction that committed a moment late
is still picked up, and a client applies rows by id so a repeat is harmless.
Balances are not in the feed: a device derives them from the events.
"""

from dataclasses import dataclass, field, replace
from datetime import datetime, timedelta
from typing import Any, Final
from uuid import UUID

from django.db.models import Q, QuerySet

from apps.wallets.models import Category, LedgerEvent, Wallet
from apps.wallets.validation import refuse

OVERLAP: Final = timedelta(seconds=5)
DEFAULT_LIMIT: Final = 200
MAX_LIMIT: Final = 500
_SEPARATOR: Final = "|"


@dataclass(frozen=True, slots=True)
class Cursors:
    """One opaque ``"<iso time>|<id>"`` position per feed; empty means from the start."""

    wallets: str = ""
    categories: str = ""
    events: str = ""


@dataclass(frozen=True, slots=True)
class WalletRow:
    id: str
    name: str
    kind: str
    currency: str
    bank: str
    archived: bool


@dataclass(frozen=True, slots=True)
class CategoryRow:
    id: str
    name: str
    kind: str
    is_other: bool


@dataclass(frozen=True, slots=True)
class EntryRow:
    id: str
    wallet_id: str
    kind: str
    direction: str
    amount_minor: int
    occurred_at: datetime
    note: str
    category_id: str
    outside_totals: bool
    split_id: str
    transfer_id: str
    refund_of: str
    voided: bool


@dataclass(frozen=True, slots=True)
class Page:
    wallets: list[WalletRow] = field(default_factory=list)
    categories: list[CategoryRow] = field(default_factory=list)
    entries: list[EntryRow] = field(default_factory=list)
    cursors: Cursors = field(default_factory=Cursors)
    has_more: bool = False


def _parse(cursor: str) -> tuple[datetime, UUID | None] | None:
    if not cursor:
        return None
    moment, _, ident = cursor.partition(_SEPARATOR)
    try:
        return datetime.fromisoformat(moment), (UUID(ident) if ident else None)
    except ValueError:
        raise refuse("The cursor is not valid.") from None


def _format(moment: datetime, ident: object = "") -> str:
    return f"{moment.isoformat()}{_SEPARATOR}{ident}"


def _page(query: "QuerySet[Any]", cursor: str, limit: int) -> tuple[list[Any], str, bool]:
    """The next rows of one feed, the cursor after them, and whether the page was full."""
    position = _parse(cursor)
    if position is not None:
        moment, ident = position
        if ident is None:
            query = query.filter(updated_at__gte=moment)
        else:
            query = query.filter(Q(updated_at__gt=moment) | Q(updated_at=moment, id__gt=ident))
    rows = list(query.order_by("updated_at", "id")[:limit])
    full = len(rows) == limit
    if not rows:
        if position is not None and position[1] is not None:
            return rows, _format(position[0] - OVERLAP), False
        return rows, cursor, False
    last = rows[-1]
    if full:
        return rows, _format(last.updated_at, last.id), True
    return rows, _format(last.updated_at - OVERLAP), False


def _wallet(w: Wallet) -> WalletRow:
    return WalletRow(str(w.id), w.name, w.kind, w.currency, w.bank, w.archived)


def _category(c: Category) -> CategoryRow:
    return CategoryRow(str(c.id), c.name, c.kind, c.is_other)


def _entry(e: LedgerEvent) -> EntryRow:
    return EntryRow(
        id=str(e.id),
        wallet_id=str(e.wallet_id),
        kind=e.kind,
        direction=e.direction,
        amount_minor=e.amount_minor,
        occurred_at=e.occurred_at,
        note=e.note,
        category_id=str(e.category_id or ""),
        outside_totals=e.outside_totals,
        split_id=str(e.split_id or ""),
        transfer_id=str(e.transfer_id or ""),
        refund_of=str(e.refund_of_id or ""),
        voided=e.voided,
    )


class SyncService:
    def changes(self, user: Any, cursors: Cursors, *, limit: int) -> Page:
        size = min(limit, MAX_LIMIT) if limit > 0 else DEFAULT_LIMIT
        wallets, wallets_cursor, wallets_full = _page(
            Wallet.objects.filter(user=user), cursors.wallets, size
        )
        categories, categories_cursor, categories_full = _page(
            Category.objects.filter(user=user), cursors.categories, size
        )
        events, events_cursor, events_full = _page(
            LedgerEvent.objects.filter(user=user), cursors.events, size
        )
        return replace(
            Page(),
            wallets=[_wallet(w) for w in wallets],
            categories=[_category(c) for c in categories],
            entries=[_entry(e) for e in events],
            cursors=Cursors(wallets_cursor, categories_cursor, events_cursor),
            has_more=wallets_full or categories_full or events_full,
        )


sync_service = SyncService()
