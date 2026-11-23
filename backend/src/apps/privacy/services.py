"""Everything the privacy app decides, independent of who asked.

The three transport packages beside this file render what these methods
return. Put the rules here, so REST, GraphQL and gRPC cannot drift.
"""


class PrivacyService:
    """The privacy app's own operations."""

    def greeting(self) -> str:
        return "Privacy v1 API"


privacy_service = PrivacyService()
