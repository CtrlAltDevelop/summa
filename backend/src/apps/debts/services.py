"""Everything the debts app decides, independent of who asked.

The three transport packages beside this file render what these methods
return. Put the rules here, so REST, GraphQL and gRPC cannot drift.
"""


class DebtsService:
    """The debts app's own operations."""

    def greeting(self) -> str:
        return "Debts v1 API"


debts_service = DebtsService()
