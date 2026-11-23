"""The contract the sync endpoints publish."""

from ninja import Schema


class ApiMessage(Schema):
    message: str
