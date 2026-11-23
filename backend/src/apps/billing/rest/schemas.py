"""The contract the billing endpoints publish."""

from ninja import Schema


class ApiMessage(Schema):
    message: str
