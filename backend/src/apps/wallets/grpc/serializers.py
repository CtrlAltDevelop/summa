"""Nested message shapes for the wallets service."""

from rest_framework import serializers

BIG_MIN, BIG_MAX = -(2**63), 2**63 - 1  # these bounds are what make DSG emit int64, not int32


class Wallet(serializers.Serializer[dict[str, object]]):
    id = serializers.CharField()
    name = serializers.CharField()
    kind = serializers.CharField()
    currency = serializers.CharField()
    bank = serializers.CharField()
    archived = serializers.BooleanField()
    balance_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)


class CurrencyTotal(serializers.Serializer[dict[str, object]]):
    currency = serializers.CharField()
    balance_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)


class Entry(serializers.Serializer[dict[str, object]]):
    id = serializers.CharField()
    wallet_id = serializers.CharField()
    kind = serializers.CharField()
    amount_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
    currency = serializers.CharField()
    occurred_at = serializers.CharField()
    note = serializers.CharField()
    category_id = serializers.CharField()
    outside_totals = serializers.BooleanField()
    split_id = serializers.CharField()


class SplitPartMsg(serializers.Serializer[dict[str, object]]):
    """One share of a split expense."""

    category_id = serializers.CharField()
    amount_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
    outside_totals = serializers.BooleanField()


class Category(serializers.Serializer[dict[str, object]]):
    id = serializers.CharField()
    name = serializers.CharField()
    kind = serializers.CharField()
    is_other = serializers.BooleanField()


class BudgetRow(serializers.Serializer[dict[str, object]]):
    category_id = serializers.CharField()
    category_name = serializers.CharField()
    currency = serializers.CharField()
    limit_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
    spent_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
