"""Everything the recurring app decides, independent of who asked.

The three transport packages beside this file render what these methods
return. Put the rules here, so REST, GraphQL and gRPC cannot drift.
"""


class RecurringService:
    """The recurring app's own operations."""

    def greeting(self) -> str:
        return "Recurring v1 API"


recurring_service = RecurringService()
