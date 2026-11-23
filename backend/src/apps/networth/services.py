"""Everything the networth app decides, independent of who asked.

The three transport packages beside this file render what these methods
return. Put the rules here, so REST, GraphQL and gRPC cannot drift.
"""


class NetworthService:
    """The networth app's own operations."""

    def greeting(self) -> str:
        return "Networth v1 API"


networth_service = NetworthService()
