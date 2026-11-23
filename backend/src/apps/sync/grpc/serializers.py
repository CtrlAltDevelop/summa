"""Row shapes of the change feed."""

from rest_framework import serializers

BIG_MIN, BIG_MAX = -(2**63), 2**63 - 1  # these bounds make DSG emit int64, not int32


class SyncWalletMsg(serializers.Serializer[dict[str, object]]):
    id = serializers.CharField()
    name = serializers.CharField()
    kind = serializers.CharField()
    currency = serializers.CharField()
    bank = serializers.CharField()
    archived = serializers.BooleanField()


class SyncCategoryMsg(serializers.Serializer[dict[str, object]]):
    id = serializers.CharField()
    name = serializers.CharField()
    kind = serializers.CharField()
    is_other = serializers.BooleanField()


class SyncEntryMsg(serializers.Serializer[dict[str, object]]):
    id = serializers.CharField()
    wallet_id = serializers.CharField()
    kind = serializers.CharField()
    direction = serializers.CharField()
    amount_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
    occurred_at = serializers.CharField()
    note = serializers.CharField()
    category_id = serializers.CharField()
    outside_totals = serializers.BooleanField()
    split_id = serializers.CharField()
    transfer_id = serializers.CharField()
    refund_of = serializers.CharField()
    voided = serializers.BooleanField()
