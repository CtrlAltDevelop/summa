from datetime import UTC, date, datetime, timedelta
from decimal import Decimal
from typing import Any

import pytest
from django.apps import apps
from django.contrib.auth import get_user_model
from django.core.management import call_command

from apps.assets.rates import rate_service
from apps.assets.service import asset_service
from apps.assistant.chat import chat_service
from apps.assistant.models import ChatMessage, SmsCardLink, UserPreference
from apps.assistant.sms import sms_service
from apps.billing.models import Payment, Plan, Subscription
from apps.billing.service import billing_service
from apps.debts.service import debt_service
from apps.networth.service import BasketItemRef, networth_service
from apps.privacy.models import UserPrivacy
from apps.privacy.service import MAX_RETENTION_DAYS, privacy_service
from apps.recurring.service import recurring_service
from apps.wallets.categories import category_service
from apps.wallets.ledger import ledger_service
from apps.wallets.models import LedgerEvent, Wallet
from apps.wallets.services import wallets_service
from infrastructure.common.errors import ApiError

pytestmark = pytest.mark.django_db

NOW = datetime(2026, 11, 22, 9, 0, tzinfo=UTC)


def make_user(name: str = "zoe") -> Any:
    return get_user_model()._default_manager.create_user(username=name)


def fill_an_account(user: Any) -> dict[str, Any]:
    """Data in every user-owned corner of the system."""
    wallet = wallets_service.create(
        user, name="a", kind="bank", currency="IRT", bank="",
        opening_balance_minor=1_000_000, client_mutation_id="w",
    )  # fmt: skip
    food = next(c.id for c in category_service.list(user) if c.name == "خوراک و سوپرمارکت")
    entry = ledger_service.record(
        user, wallet_id=wallet.id, kind="expense", amount_minor=100, occurred_at=NOW,
        note="x", client_mutation_id="e", category_id=food,
    )  # fmt: skip
    category_service.set_budget(user, food, currency="IRT", limit_minor=500)
    recurring_service.create(
        user, wallet_id=wallet.id, kind="expense", amount_minor=10, category_id=None, note="r",
        period="monthly", day=1, auto_confirm=False, client_mutation_id="r", now=NOW,
    )  # fmt: skip
    debt_service.create(
        user, kind="bank_loan", title="وام", currency="IRT", installment_minor=5, count=2,
        first_due=date(2026, 12, 6), principal_minor=0, wallet_id=None, category_id=None,
        client_mutation_id="d", now=NOW,
    )  # fmt: skip
    rate_service.set_manual("GOLD18", Decimal(8_000_000), now=NOW)
    asset = asset_service.create(
        user, symbol="GOLD18", name="", quantity="1", unit_price_minor=1, manual_price_minor=0,
        bought_on=date(2026, 11, 1), client_mutation_id="a", now=NOW,
    )  # fmt: skip
    networth_service.create_basket(
        user, name="هدف", target_minor=100, items=[BasketItemRef("asset", asset.id)],
        client_mutation_id="b", now=NOW,
    )  # fmt: skip
    chat_service.send(user, text="۱۰۰ هزار تومن نان", client_mutation_id="c")
    sms_service.link_card(user, last4="1234", wallet_id=wallet.id)
    UserPreference.objects.create(user=user, accounting_hour=20)
    privacy_service.set_chat_retention(user, 30)
    Plan.objects.get_or_create(
        code="m", defaults={"name": "m", "price_minor": 1, "period_days": 30}
    )
    paid = billing_service.checkout(user, "m", NOW)
    billing_service.verify(user, paid.reference, NOW)
    return {"wallet": wallet.id, "entry": entry.id, "reference": paid.reference}


def _points_at_user(field: Any, user_model: Any) -> bool:
    is_relation = getattr(field, "many_to_one", False) or getattr(field, "one_to_one", False)
    return bool(is_relation and field.concrete and field.related_model is user_model)


def user_owned_rows(user_pk: Any) -> list[str]:
    """Every model that still has a row pointing at the user."""
    user_model = get_user_model()
    return [
        f"{model.__name__}.{field.name}"
        for model in apps.get_models()
        for field in model._meta.get_fields()
        if _points_at_user(field, user_model)
        and model._default_manager.filter(**{field.attname: user_pk}).exists()
    ]


def test_deleting_an_account_leaves_no_row_that_points_at_it() -> None:
    user = make_user()
    fill_an_account(user)
    pk = user.pk
    assert user_owned_rows(pk), "the fixture should have data to delete"

    privacy_service.delete_account(user, "DELETE")

    assert user_owned_rows(pk) == []
    assert not get_user_model()._default_manager.filter(pk=pk).exists()
    assert Wallet.objects.count() == LedgerEvent.objects.count() == 0
    assert ChatMessage.objects.count() == SmsCardLink.objects.count() == 0


def test_only_the_payment_receipt_survives_without_its_user() -> None:
    user = make_user()
    info = fill_an_account(user)
    pk = user.pk

    privacy_service.delete_account(user, "DELETE")

    receipt = Payment.objects.get(reference=info["reference"])
    assert (receipt.user_id, receipt.user_ref, receipt.status) == (None, str(pk), "paid")
    assert Subscription.objects.count() == 0 and UserPrivacy.objects.count() == 0


@pytest.mark.parametrize("wrong", ["", "delete", "Delete", "DELETE ", "yes"])
def test_a_wrong_confirmation_deletes_nothing(wrong: str) -> None:
    user = make_user()
    fill_an_account(user)

    with pytest.raises(ApiError) as refusal:
        privacy_service.delete_account(user, wrong)

    assert refusal.value.status == 400
    assert get_user_model()._default_manager.filter(pk=user.pk).exists()
    assert Wallet.objects.filter(user=user).exists()


def test_another_user_is_untouched() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    fill_an_account(zoe)
    keep = wallets_service.create(
        ali, name="mine", kind="bank", currency="IRT", bank="", opening_balance_minor=5,
        client_mutation_id="w-ali",
    )  # fmt: skip
    ledger_service.record(
        ali, wallet_id=keep.id, kind="expense", amount_minor=1, occurred_at=NOW, note="",
        client_mutation_id="e-ali",
    )  # fmt: skip

    privacy_service.delete_account(zoe, "DELETE")

    assert [w.name for w in wallets_service.list(ali).wallets] == ["mine"]
    assert len(ledger_service.list(ali, wallet_id=None, limit=50)) == 1


def test_a_deleted_account_cannot_be_deleted_twice() -> None:
    user = make_user()
    privacy_service.delete_account(user, "DELETE")

    assert not get_user_model()._default_manager.filter(username="zoe").exists()


# --- chat retention ----------------------------------------------------------------


def test_retention_defaults_to_forever_and_is_validated() -> None:
    user = make_user()

    assert privacy_service.chat_retention_days(user) == 0
    privacy_service.set_chat_retention(user, 30)
    assert privacy_service.chat_retention_days(user) == 30
    for bad in (-1, MAX_RETENTION_DAYS + 1):
        with pytest.raises(ApiError) as refusal:
            privacy_service.set_chat_retention(user, bad)
        assert refusal.value.status == 400


def test_pruning_removes_only_messages_older_than_each_users_limit() -> None:
    zoe, ali, sam = make_user("zoe"), make_user("ali"), make_user("sam")
    privacy_service.set_chat_retention(zoe, 7)
    privacy_service.set_chat_retention(ali, 0)  # forever
    for who in (zoe, ali, sam):
        chat_service.send(who, text="سلام", client_mutation_id="m")
    ChatMessage.objects.filter(user=zoe).update(created_at=NOW - timedelta(days=10))
    ChatMessage.objects.filter(user=ali).update(created_at=NOW - timedelta(days=400))
    chat_service.send(zoe, text="تازه", client_mutation_id="fresh")
    ChatMessage.objects.filter(user=zoe, text="تازه").update(created_at=NOW - timedelta(days=1))

    deleted = privacy_service.prune_chats(NOW)

    assert deleted == 2  # zoe's two old messages (hers and the reply)
    assert ChatMessage.objects.filter(user=ali).count() == 2  # no limit: kept
    assert ChatMessage.objects.filter(user=sam).count() == 2
    assert {m.text for m in ChatMessage.objects.filter(user=zoe, role="user")} == {"تازه"}


def test_the_command_runs(capsys: Any) -> None:
    user = make_user()
    privacy_service.set_chat_retention(user, 1)
    chat_service.send(user, text="سلام", client_mutation_id="m")
    ChatMessage.objects.update(created_at=datetime.now(tz=UTC) - timedelta(days=5))

    call_command("prune_chats")

    assert "Deleted 2 chat message" in capsys.readouterr().out
    assert ChatMessage.objects.count() == 0
