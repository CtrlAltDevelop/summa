"""Everything the assets app decides, independent of who asked.

The three transport packages beside this file render what these methods
return. Put the rules here, so REST, GraphQL and gRPC cannot drift.
"""


class AssetsService:
    """The assets app's own operations."""

    def greeting(self) -> str:
        return "Assets v1 API"


assets_service = AssetsService()
