"""Nested message shapes for the assistant service."""

from rest_framework import serializers

BIG_MIN, BIG_MAX = -(2**63), 2**63 - 1  # these bounds make DSG emit int64, not int32


class Card(serializers.Serializer[dict[str, object]]):
    """A suggested entry. Registering it is the app's ordinary record request."""

    kind = serializers.CharField()
    amount_minor = serializers.IntegerField(min_value=BIG_MIN, max_value=BIG_MAX)
    currency = serializers.CharField()
    wallet_id = serializers.CharField()
    to_wallet_id = serializers.CharField()
    category_id = serializers.CharField()
    note = serializers.CharField()
    occurred_at = serializers.CharField()


class Message(serializers.Serializer[dict[str, object]]):
    id = serializers.CharField()
    role = serializers.CharField()
    text = serializers.CharField()
    created_at = serializers.CharField()
    card_present = serializers.BooleanField()
    card = Card()
