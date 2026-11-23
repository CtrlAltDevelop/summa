"""Nested message shapes for the rates and assets services."""

from rest_framework import serializers

BIG_MIN, BIG_MAX = -(2**63), 2**63 - 1  # these bounds make DSG emit int64, not int32


class RateMsg(serializers.Serializer[dict[str, object]]):
    symbol = serializers.CharField()
    name = serializers.CharField()
    unit = serializers.CharField()
    group = serializers.CharField()
    # Toman per one unit, as text; empty when no price is known yet.
    price = serializers.CharField()
    known = serializers.BooleanField()
    source = serializers.CharField()
    fetched_at = serializers.CharField()
    age_seconds = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
    stale = serializers.BooleanField()


class AssetMsg(serializers.Serializer[dict[str, object]]):
    id = serializers.CharField()
    symbol = serializers.CharField()
    name = serializers.CharField()
    unit = serializers.CharField()
    quantity = serializers.CharField()
    cost_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
    value_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
    profit_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
    realized_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
    price = serializers.CharField()
    price_known = serializers.BooleanField()
    stale = serializers.BooleanField()
