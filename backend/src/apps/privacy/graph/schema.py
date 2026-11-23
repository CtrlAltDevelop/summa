"""The privacy app's contribution to the project's GraphQL schema.

Merged into the root query by `config.graph`. Field names share one
namespace with every other installed app, so prefix them with the app
name as this one does.
"""

import strawberry

from apps.privacy.services import privacy_service
from infrastructure.common.graph.errors import resolver


@strawberry.type
class Query:
    @strawberry.field(description="An example privacy field.")
    @resolver
    def privacy_greeting(self) -> str:
        return privacy_service.greeting()
