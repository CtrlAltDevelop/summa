"""Nested message shapes for the net worth service."""

from rest_framework import serializers

BIG_MIN, BIG_MAX = -(2**63), 2**63 - 1  # these bounds make DSG emit int64, not int32


class BasketItemRefMsg(serializers.Serializer[dict[str, object]]):
    """What a basket points at: a wallet or an asset, by id."""

    kind = serializers.CharField()
    ref_id = serializers.CharField()


class BasketItemMsg(serializers.Serializer[dict[str, object]]):
    kind = serializers.CharField()
    ref_id = serializers.CharField()
    name = serializers.CharField()
    value_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)


class BasketMsg(serializers.Serializer[dict[str, object]]):
    id = serializers.CharField()
    name = serializers.CharField()
    target_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
    value_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
    percent = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
    items = BasketItemMsg(many=True)


class HistoryPointMsg(serializers.Serializer[dict[str, object]]):
    date = serializers.CharField()
    total_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
