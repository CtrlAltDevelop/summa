from typing import Any

from django.contrib import admin

from apps.billing.models import Payment, Plan, Subscription


@admin.register(Plan)
class PlanAdmin(admin.ModelAdmin):
    list_display = ("code", "name", "price_minor", "period_days", "active", "sort")
    list_editable = ("active", "sort")


@admin.register(Subscription)
class SubscriptionAdmin(admin.ModelAdmin):
    list_display = ("user", "status", "plan", "started_at", "ends_at")
    list_select_related = ("plan",)

    def has_add_permission(self, request: Any) -> bool:
        return False


@admin.register(Payment)
class PaymentAdmin(admin.ModelAdmin):
    list_display = ("created_at", "user", "plan", "amount_minor", "status", "reference")
    list_filter = ("status",)
    readonly_fields = [f.name for f in Payment._meta.fields]

    def has_add_permission(self, request: Any) -> bool:
        return False
