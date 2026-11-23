from django.apps import AppConfig


class BillingConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "apps.billing"

    def ready(self) -> None:
        """Hook the read-only rule into every gRPC action."""
        from apps.billing.guard import read_only_guard
        from infrastructure.common.grpc.errors import register_call_guard

        register_call_guard(read_only_guard)
