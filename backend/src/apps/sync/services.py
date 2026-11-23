"""Everything the sync app decides, independent of who asked.

The three transport packages beside this file render what these methods
return. Put the rules here, so REST, GraphQL and gRPC cannot drift.
"""


class SyncService:
    """The sync app's own operations."""

    def greeting(self) -> str:
        return "Sync v1 API"


sync_service = SyncService()
