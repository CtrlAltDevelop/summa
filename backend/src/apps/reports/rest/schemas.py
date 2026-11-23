"""The contract the reports endpoints publish."""

from ninja import Schema


class ApiMessage(Schema):
    message: str
