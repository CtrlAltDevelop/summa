"""Nested message shapes for the recurring service."""

from rest_framework import serializers

BIG_MIN, BIG_MAX = -(2**63), 2**63 - 1  # these bounds make DSG emit int64, not int32


class RecurringMsg(serializers.Serializer[dict[str, object]]):
    id = serializers.CharField()
    wallet_id = serializers.CharField()
    kind = serializers.CharField()
    # Zero means a variable amount, asked for each time.
    amount_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
    currency = serializers.CharField()
    category_id = serializers.CharField()
    note = serializers.CharField()
    period = serializers.CharField()
    day = serializers.IntegerField()
    auto_confirm = serializers.BooleanField()
    active = serializers.BooleanField()
    next_due = serializers.CharField()


class OccurrenceMsg(serializers.Serializer[dict[str, object]]):
    id = serializers.CharField()
    recurring_id = serializers.CharField()
    wallet_id = serializers.CharField()
    kind = serializers.CharField()
    amount_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
    currency = serializers.CharField()
    note = serializers.CharField()
    due_date = serializers.CharField()
    status = serializers.CharField()
    low_balance = serializers.BooleanField()
