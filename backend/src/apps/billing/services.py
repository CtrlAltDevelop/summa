"""Everything the billing app decides, independent of who asked.

The three transport packages beside this file render what these methods
return. Put the rules here, so REST, GraphQL and gRPC cannot drift.
"""


class BillingService:
    """The billing app's own operations."""

    def greeting(self) -> str:
        return "Billing v1 API"


billing_service = BillingService()
