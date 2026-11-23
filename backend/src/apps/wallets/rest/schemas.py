"""The contract the wallets endpoints publish."""

from ninja import Schema


class ApiMessage(Schema):
    message: str
