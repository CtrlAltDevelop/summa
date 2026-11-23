"""Set a rate by hand: ``manage.py set_rate USD 61000`` (toman per unit)."""

from decimal import Decimal, InvalidOperation
from typing import Any

from django.core.management.base import BaseCommand, CommandError, CommandParser

from apps.assets.rates import rate_service
from infrastructure.common.errors import ApiError


class Command(BaseCommand):
    help = "Set the price of a symbol by hand."

    def add_arguments(self, parser: CommandParser) -> None:
        parser.add_argument("symbol")
        parser.add_argument("price")

    def handle(self, *args: Any, **options: Any) -> None:
        try:
            price = Decimal(options["price"])
        except InvalidOperation as error:
            raise CommandError("The price is not a number.") from error
        try:
            rate_service.set_manual(options["symbol"], price)
        except ApiError as error:
            raise CommandError(str(error)) from error
        self.stdout.write(f"{options['symbol']} set to {price}")
