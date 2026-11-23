"""The contract the billing endpoints publish."""

from ninja import Schema


class ApiMessage(Schema):
    message: str


class PlanOut(Schema):
    code: str
    name: str
    description: str
    price_minor: int  # toman
    period_days: int
