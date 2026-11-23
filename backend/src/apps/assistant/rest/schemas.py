"""The contract the assistant endpoints publish."""

from ninja import Schema


class ApiMessage(Schema):
    message: str
