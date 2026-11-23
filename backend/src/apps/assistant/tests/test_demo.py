from datetime import UTC, datetime
from typing import Any

import pytest
from django.contrib.auth import get_user_model
from django.test import Client

from apps.assistant.demo import DEMO_RATE_PER_MINUTE, MAX_DEMO_LENGTH, demo_reply
from apps.assistant.models import ChatMessage
from infrastructure.common.errors import ApiError

NOW = datetime(2026, 11, 22, 9, 0, tzinfo=UTC)


def post(text: Any, ip: str = "10.0.0.1") -> Any:
    return Client(REMOTE_ADDR=ip).post(
        "/api/v1/assistant/demo", {"text": text}, content_type="application/json"
    )


def test_a_sentence_becomes_a_card_without_signing_in() -> None:
    response = post("۲۵۰ هزار تومن خرید نان")

    data = response.json()["data"]
    assert response.status_code == 200
    assert data["card"]["kind"] == "expense" and data["card"]["amount_minor"] == 250_000
    assert (data["card"]["category"], data["card"]["wallet"]) == ("خوراک و سوپرمارکت", "")
    assert data["card"]["amount_text"] == "۲۵۰٬۰۰۰ تومان"
    assert "این را ثبت کنم؟" in data["reply"]


def test_a_named_sample_wallet_is_picked() -> None:
    card = post("۵۰ هزار تومن تاکسی با کارت ملی").json()["data"]["card"]

    assert (card["wallet"], card["category"]) == ("ملی", "رفت‌وآمد")


def test_a_transfer_between_the_sample_wallets() -> None:
    card = post("۲ میلیون تومن انتقال از ملی به نقد").json()["data"]["card"]

    assert (card["kind"], card["wallet"], card["to_wallet"]) == ("transfer", "ملی", "نقد")


def test_a_sentence_without_an_amount_gets_help_and_no_card() -> None:
    data = post("سلام").json()["data"]

    assert data["card"] is None and "مبلغی پیدا نکردم" in data["reply"]


@pytest.mark.parametrize("text", ["", "   ", "x" * (MAX_DEMO_LENGTH + 1)])
def test_empty_and_long_text_are_refused(text: str) -> None:
    assert post(text).status_code == 400


def test_a_client_is_limited_per_minute_and_others_are_not() -> None:
    for _ in range(DEMO_RATE_PER_MINUTE):
        assert post("سلام", ip="10.0.0.9").status_code == 200

    assert post("سلام", ip="10.0.0.9").status_code == 429
    assert post("سلام", ip="10.0.0.10").status_code == 200


@pytest.mark.django_db
def test_the_demo_stores_nothing_and_touches_no_account() -> None:
    get_user_model()._default_manager.create_user(username="zoe")

    post("۲۵۰ هزار تومن خرید نان")

    assert ChatMessage.objects.count() == 0


def test_the_function_refuses_without_a_client_budget() -> None:
    for _ in range(DEMO_RATE_PER_MINUTE):
        demo_reply("سلام", "fn", NOW)

    with pytest.raises(ApiError) as refusal:
        demo_reply("سلام", "fn", NOW)

    assert refusal.value.status == 429
