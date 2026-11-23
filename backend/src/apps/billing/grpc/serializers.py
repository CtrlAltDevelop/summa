"""Nested message shapes for the billing service."""

from rest_framework import serializers

BIG_MIN, BIG_MAX = -(2**63), 2**63 - 1  # these bounds make DSG emit int64, not int32


class PlanMsg(serializers.Serializer[dict[str, object]]):
    code = serializers.CharField()
    name = serializers.CharField()
    description = serializers.CharField()
    # Toman.
    price_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
    period_days = serializers.IntegerField()
