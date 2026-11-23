"""Categories and monthly budgets.

Every user gets the Iran-profile defaults on first use. A budget caps one
expense category in one currency; what was spent is summed for a window the
client supplies (a Shamsi month), so the server never needs a calendar.
"""

from dataclasses import dataclass
from datetime import datetime
from typing import Any

from django.db import transaction
from django.db.models import Sum

from apps.wallets.models import Budget, Category, EventKind, LedgerEvent
from apps.wallets.profile import (
    CATEGORY_NAME_MAX_LENGTH,
    CURRENCIES,
    DEFAULT_CATEGORIES,
    OTHER_NAME,
)
from apps.wallets.validation import not_found, parse_uuid, refuse


@dataclass(frozen=True, slots=True)
class CategoryView:
    id: str
    name: str
    kind: str
    is_other: bool


@dataclass(frozen=True, slots=True)
class BudgetStatus:
    category_id: str
    category_name: str
    currency: str
    limit_minor: int
    spent_minor: int


def _view(category: Category) -> CategoryView:
    return CategoryView(str(category.id), category.name, category.kind, category.is_other)


def resolve_category(user: Any, category_id: str | None, entry_kind: str) -> Category | None:
    """The caller's category for an entry of ``entry_kind``; ``None``/empty means none."""
    if not category_id:
        return None
    category = Category.objects.filter(user=user, id=parse_uuid(category_id, "Category")).first()
    if category is None:
        raise not_found("Category")
    if category.kind != entry_kind:
        raise refuse("The category is for a different kind of entry.")
    return category


def _own(user: Any, category_id: str) -> Category:
    category = Category.objects.filter(user=user, id=parse_uuid(category_id, "Category")).first()
    if category is None:
        raise not_found("Category")
    return category


_Statuses = list[BudgetStatus]
_Views = list[CategoryView]


class CategoryService:
    def list(self, user: Any) -> _Views:
        if not Category.objects.filter(user=user).exists():
            Category.objects.bulk_create(
                [
                    Category(user=user, name=name, kind=kind, is_other=name == OTHER_NAME)
                    for kind, names in DEFAULT_CATEGORIES.items()
                    for name in names
                ],
                ignore_conflicts=True,
            )
        return [_view(c) for c in Category.objects.filter(user=user).order_by("created_at", "name")]

    def create(self, user: Any, *, name: str, kind: str) -> CategoryView:
        name = name.strip()
        if not name or len(name) > CATEGORY_NAME_MAX_LENGTH:
            raise refuse(f"The name must be 1 to {CATEGORY_NAME_MAX_LENGTH} characters.")
        if kind not in DEFAULT_CATEGORIES:
            raise refuse(f"Unknown category kind: {kind}.")
        self.list(user)  # defaults first, so a clash with one is caught below
        if Category.objects.filter(user=user, kind=kind, name=name).exists():
            raise refuse("A category with this name already exists.")
        return _view(Category.objects.create(user=user, name=name, kind=kind))

    def delete(self, user: Any, category_id: str) -> None:
        category = _own(user, category_id)
        if category.is_other:
            raise refuse(f'"{OTHER_NAME}" cannot be deleted.')
        with transaction.atomic():
            other = Category.objects.get(user=user, kind=category.kind, is_other=True)
            LedgerEvent.objects.filter(user=user, category=category).update(category=other)
            category.delete()  # its budget goes with it

    def set_budget(self, user: Any, category_id: str, *, currency: str, limit_minor: int) -> None:
        category = _own(user, category_id)
        if category.kind != "expense":
            raise refuse("Only an expense category can have a budget.")
        if currency not in CURRENCIES:
            raise refuse(f"Unsupported currency: {currency}.")
        if limit_minor < 0:
            raise refuse("The limit cannot be negative.")
        if limit_minor == 0:
            Budget.objects.filter(user=user, category=category).delete()
            return
        Budget.objects.update_or_create(
            category=category,
            defaults={"user": user, "currency": currency, "limit_minor": limit_minor},
        )

    def budget_status(self, user: Any, start: datetime, end: datetime) -> _Statuses:
        if start >= end:
            raise refuse("The window must start before it ends.")
        budgets = list(Budget.objects.filter(user=user).select_related("category"))
        spent = {
            (row["category_id"], row["wallet__currency"]): row["total"]
            for row in LedgerEvent.objects.filter(
                user=user,
                voided=False,
                outside_totals=False,
                kind=EventKind.EXPENSE,
                category__in=[b.category_id for b in budgets],
                occurred_at__gte=start,
                occurred_at__lt=end,
            )
            .values("category_id", "wallet__currency")
            .annotate(total=Sum("amount_minor"))
        }
        return [
            BudgetStatus(
                category_id=str(b.category_id),
                category_name=b.category.name,
                currency=b.currency,
                limit_minor=b.limit_minor,
                spent_minor=spent.get((b.category_id, b.currency), 0),
            )
            for b in sorted(budgets, key=lambda b: b.category.created_at)
        ]


category_service = CategoryService()
