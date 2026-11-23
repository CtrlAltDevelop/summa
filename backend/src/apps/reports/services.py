"""Everything the reports app decides, independent of who asked.

The three transport packages beside this file render what these methods
return. Put the rules here, so REST, GraphQL and gRPC cannot drift.
"""


class ReportsService:
    """The reports app's own operations."""

    def greeting(self) -> str:
        return "Reports v1 API"


reports_service = ReportsService()
