"""Payment gateway adapters. The real one is chosen by the client (open question)."""

import uuid
from typing import Any, ClassVar, Protocol


class PaymentProvider(Protocol):
    def start(self, payment: Any) -> tuple[str, str]:
        """Open a payment at the gateway: ``(reference, url_to_pay_at)``."""
        ...

    def verify(self, reference: str) -> bool:
        """Ask the gateway, server to server, whether ``reference`` was really paid."""
        ...


class FakeProvider:
    """Development and tests only: nothing is paid for real. Never use it in production."""

    approved: ClassVar[set[str]] = set()
    decline: ClassVar[bool] = False

    def start(self, payment: Any) -> tuple[str, str]:
        reference = f"fake-{uuid.uuid4().hex}"
        return reference, f"summa://pay/{reference}"

    def verify(self, reference: str) -> bool:
        return not FakeProvider.decline
