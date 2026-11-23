"""The contract the assets endpoints publish."""

from ninja import Schema


class ApiMessage(Schema):
    message: str


class RateOut(Schema):
    symbol: str
    name: str
    unit: str
    group: str
    price: str  # toman per one unit; empty when unknown
    known: bool
    stale: bool
    source: str
    updated_at: str  # ISO time of the last update; empty when unknown
