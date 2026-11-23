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
