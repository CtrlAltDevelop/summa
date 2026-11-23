"""Nested message shapes for the debts service."""

from rest_framework import serializers

BIG_MIN, BIG_MAX = -(2**63), 2**63 - 1  # these bounds make DSG emit int64, not int32


class InstallmentMsg(serializers.Serializer[dict[str, object]]):
    id = serializers.CharField()
    number = serializers.IntegerField()
    due_date = serializers.CharField()
    amount_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
    paid = serializers.BooleanField()
    overdue = serializers.BooleanField()


class DebtMsg(serializers.Serializer[dict[str, object]]):
    id = serializers.CharField()
    kind = serializers.CharField()
    title = serializers.CharField()
    currency = serializers.CharField()
    installment_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
    count = serializers.IntegerField()
    principal_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
    wallet_id = serializers.CharField()
    category_id = serializers.CharField()
    paid_count = serializers.IntegerField()
    remaining_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
    # Empty when the debt is closed.
    next_due = serializers.CharField()
    closed = serializers.BooleanField()
    installments = InstallmentMsg(many=True)
