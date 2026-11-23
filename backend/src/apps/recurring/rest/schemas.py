"""The contract the recurring endpoints publish."""

from ninja import Schema


class ApiMessage(Schema):
    message: str
