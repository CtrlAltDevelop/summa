"""The contract the privacy endpoints publish."""

from ninja import Schema


class ApiMessage(Schema):
    message: str
