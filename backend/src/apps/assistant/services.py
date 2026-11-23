"""Everything the assistant app decides, independent of who asked.

The three transport packages beside this file render what these methods
return. Put the rules here, so REST, GraphQL and gRPC cannot drift.
"""


class AssistantService:
    """The assistant app's own operations."""

    def greeting(self) -> str:
        return "Assistant v1 API"


assistant_service = AssistantService()
