"""The contract the debts endpoints publish."""

from ninja import Schema


class ApiMessage(Schema):
    message: str
