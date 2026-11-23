"""The contract the assets endpoints publish."""

from ninja import Schema


class ApiMessage(Schema):
    message: str
