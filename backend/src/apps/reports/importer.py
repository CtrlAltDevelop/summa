"""Import a CSV of entries. Preview first, then all-or-nothing; safe to repeat.

Accepts the app's own export unchanged: its transfer, refund and opening-balance
rows are skipped, not errors. A row's mutation id is derived from its content (and
its repeat number within the file), so importing the same file again records
nothing new while two genuinely identical rows in one file are both kept.
"""

import csv
import hashlib
import io
import re
from collections import Counter
from dataclasses import dataclass, field
from datetime import UTC, datetime, time
from decimal import Decimal, InvalidOperation
from typing import Any, Final

from django.db import transaction

from apps.assistant.calendar import TEHRAN, tehran_to_utc
from apps.assistant.parser import _DIGITS
from apps.wallets.categories import category_service
from apps.wallets.ledger import ledger_service
from apps.wallets.models import LedgerEvent, Wallet
from apps.wallets.profile import CURRENCIES
from apps.wallets.validation import refuse

MAX_ROWS: Final = 5_000
MAX_BYTES: Final = 1_000_000
_KINDS: Final = ("income", "expense")
_DATE_COLUMNS: Final = ("datetime_utc", "date", "date_shamsi")
_REQUIRED: Final = ("kind", "amount", "wallet")
_SHAMSI: Final = re.compile(r"(\d{4})/(\d{1,2})/(\d{1,2})")
_AMOUNT: Final = re.compile(r"\d+(\.\d+)?")
_NOON: Final = time(12, 0)


@dataclass(frozen=True, slots=True)
class RowError:
    line: int
    message: str


@dataclass(frozen=True, slots=True)
class ImportResult:
    rows: int
    importable: int
    imported: int
    skipped: int
    errors: list[RowError] = field(default_factory=list)


@dataclass(frozen=True, slots=True)
class _Row:
    wallet_id: str
    kind: str
    amount_minor: int
    occurred_at: datetime
    category_id: str | None
    note: str
    key: str


def _digits(text: str) -> str:
    return text.translate(_DIGITS).replace("٫", ".").replace("٬", "").strip()


def _when(row: dict[str, str]) -> datetime:
    text = _digits(row.get("datetime_utc", "") or row.get("date", "") or row.get("date_shamsi", ""))
    shamsi = _SHAMSI.fullmatch(text)
    if shamsi:
        year, month, day = (int(g) for g in shamsi.groups())
        found = tehran_to_utc(year, month, day, 12, 0)
        if found is None:
            raise ValueError("date is not a real Shamsi date")
        return found
    try:
        moment = datetime.fromisoformat(text)
    except ValueError:
        raise ValueError("date is not ISO or Shamsi") from None
    if len(text) == len("2026-11-22"):
        moment = datetime.combine(moment.date(), _NOON)
    if moment.tzinfo is None:
        moment = moment.replace(tzinfo=TEHRAN)
    return moment.astimezone(UTC)


def _amount(text: str, currency: str) -> int:
    text = _digits(text)
    if not _AMOUNT.fullmatch(text):
        raise ValueError("amount is not a positive number")
    try:
        value = Decimal(text)
    except InvalidOperation:
        raise ValueError("amount is not a positive number") from None
    if value <= 0:
        raise ValueError("amount must be greater than zero")
    decimals = CURRENCIES[currency]
    scaled = value * (Decimal(10) ** decimals)
    if scaled != scaled.to_integral_value():
        raise ValueError(f"amount has more than {decimals} decimals for {currency}")
    return int(scaled)


class ImportService:
    def import_csv(self, user: Any, text: str, *, commit: bool) -> ImportResult:
        if len(text.encode()) > MAX_BYTES:
            raise refuse("The file is larger than 1 MB.")
        reader = csv.DictReader(io.StringIO(text.lstrip("﻿")))
        names = [(n or "").strip().lower() for n in (reader.fieldnames or [])]
        if (
            not names
            or any(c not in names for c in _REQUIRED)
            or not any(c in names for c in _DATE_COLUMNS)
        ):
            raise refuse(
                "The file needs the columns kind, amount, wallet and one of "
                "datetime_utc, date, date_shamsi."
            )
        reader.fieldnames = names
        rows = list(reader)
        if len(rows) > MAX_ROWS:
            raise refuse(f"At most {MAX_ROWS} rows.")
        is_export = "direction" in names
        wallets = self._wallets(user)
        categories = {(c.kind, c.name): c.id for c in category_service.list(user)}
        valid: list[_Row] = []
        errors: list[RowError] = []
        skipped = 0
        seen: Counter[str] = Counter()
        for index, raw in enumerate(rows):
            row = {k: (v or "").strip() for k, v in raw.items() if k}
            line = index + 2
            if is_export and row.get("kind") not in _KINDS:
                skipped += 1
                continue
            try:
                parsed = self._row(user, row, wallets, categories, seen)
            except ValueError as error:
                errors.append(RowError(line, str(error)))
                continue
            valid.append(parsed)
        imported = 0
        if commit and not errors:
            imported = self._commit(user, valid)
        return ImportResult(len(rows), len(valid), imported, skipped, errors)

    @staticmethod
    def _wallets(user: Any) -> dict[str, list[Wallet]]:
        grouped: dict[str, list[Wallet]] = {}
        for wallet in Wallet.objects.filter(user=user):
            grouped.setdefault(wallet.name, []).append(wallet)
        return grouped

    @staticmethod
    def _row(
        user: Any,
        row: dict[str, str],
        wallets: dict[str, list[Wallet]],
        categories: dict[tuple[str, str], str],
        seen: Counter[str],
    ) -> _Row:
        kind = row.get("kind", "")
        if kind not in _KINDS:
            raise ValueError("kind must be income or expense")
        matches = [w for w in wallets.get(row.get("wallet", ""), []) if not w.archived]
        if not matches:
            raise ValueError("wallet is not one of your open wallets")
        if len(matches) > 1:
            raise ValueError("wallet name is ambiguous")
        wallet = matches[0]
        currency = row.get("currency", "")
        if currency and currency != wallet.currency:
            raise ValueError(f"currency {currency} does not match the wallet's {wallet.currency}")
        moment = _when(row)
        minor = _amount(row.get("amount", ""), wallet.currency)
        category_name = row.get("category", "")
        category_id = None
        if category_name:
            category_id = categories.get((kind, category_name))
            if category_id is None:
                raise ValueError(f"category {category_name!r} is not one of your {kind} categories")
        note = row.get("note", "")
        fingerprint = "\x1f".join(
            [
                str(user.pk),
                row.get("datetime_utc") or row.get("date") or row.get("date_shamsi", ""),
                kind, row.get("amount", ""), row.get("wallet", ""), category_name, note,
            ]
        )  # fmt: skip
        seen[fingerprint] += 1
        digest = hashlib.sha256(f"{fingerprint}\x1f{seen[fingerprint]}".encode()).hexdigest()[:40]
        return _Row(str(wallet.id), kind, minor, moment, category_id, note, f"imp-{digest}")

    @staticmethod
    def _commit(user: Any, rows: list[_Row]) -> int:
        created = 0
        with transaction.atomic():
            for row in rows:
                if LedgerEvent.objects.filter(user=user, client_mutation_id=row.key).exists():
                    continue
                ledger_service.record(
                    user,
                    wallet_id=row.wallet_id,
                    kind=row.kind,
                    amount_minor=row.amount_minor,
                    occurred_at=row.occurred_at,
                    note=row.note,
                    client_mutation_id=row.key,
                    category_id=row.category_id,
                )
                created += 1
        return created


import_service = ImportService()
