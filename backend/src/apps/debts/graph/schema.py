"""The debts app's contribution to the project's GraphQL schema.

Merged into the root query by `config.graph`. Field names share one
namespace with every other installed app, so prefix them with the app
name as this one does.
"""

import strawberry

from apps.debts.services import debts_service
from infrastructure.common.graph.errors import resolver


@strawberry.type
class Query:
    @strawberry.field(description="An example debts field.")
    @resolver
    def debts_greeting(self) -> str:
        return debts_service.greeting()
