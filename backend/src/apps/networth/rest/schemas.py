"""The contract the networth endpoints publish."""

from ninja import Schema


class ApiMessage(Schema):
    message: str
