"""Make an account whose subscription ended read-only, from one place.

Registered as a call guard, it sees every gRPC action before it runs. Reads, the
auth calls and billing itself stay open: someone who owes money must still be able
to see their data, sign out and pay.
"""

from asgiref.sync import sync_to_async
from django.conf import settings
from django.utils import timezone

from apps.billing.service import billing_service
from infrastructure.common.errors import ApiError
from infrastructure.common.identity import grpc_caller
from infrastructure.common.responses import ResponseTitle

#: RPC names that only read (or compute) and never change what the user stored.
READ_ONLY = frozenset(
    {
        "List", "Get", "Me", "History", "Digest", "Monthly", "ExportCsv", "Changes",
        "Convert", "BudgetStatus", "ListBaskets", "ParseSms", "Status", "Plans",
    }
)  # fmt: skip
_EXEMPT_MODULES = ("infrastructure.", "apps.billing")


async def read_only_guard(name: str, module: str, context: object) -> None:
    if not getattr(settings, "BILLING_ENFORCED", False):
        return
    if name in READ_ONLY or module.startswith(_EXEMPT_MODULES):
        return
    user = await grpc_caller(context)
    if user is None:  # the action itself refuses an anonymous caller
        return
    if not await sync_to_async(billing_service.can_write)(user, timezone.now()):
        raise ApiError(
            "Your subscription has ended: the account is read-only until you renew.",
            403,
            title=ResponseTitle.FORBIDDEN,
        )
