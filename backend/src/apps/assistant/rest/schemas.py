"""The contract the assistant endpoints publish."""

from ninja import Schema


class ApiMessage(Schema):
    message: str


class DemoRequest(Schema):
    text: str


class DemoCardOut(Schema):
    kind: str
    amount_minor: int
    currency: str
    amount_text: str
    wallet: str
    to_wallet: str
    category: str
    note: str
    occurred_at: str


class DemoOut(Schema):
    reply: str
    card: DemoCardOut | None = None
