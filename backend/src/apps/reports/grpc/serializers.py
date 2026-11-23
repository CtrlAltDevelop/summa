"""Nested message shapes for the report service."""

from rest_framework import serializers

BIG_MIN, BIG_MAX = -(2**63), 2**63 - 1  # these bounds make DSG emit int64, not int32


class CategoryTotalMsg(serializers.Serializer[dict[str, object]]):
    category_id = serializers.CharField()
    name = serializers.CharField()
    kind = serializers.CharField()
    total_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)


class DayTotalMsg(serializers.Serializer[dict[str, object]]):
    day = serializers.CharField()
    income_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
    expense_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)


class ImportErrorMsg(serializers.Serializer[dict[str, object]]):
    line = serializers.IntegerField()
    message = serializers.CharField()
