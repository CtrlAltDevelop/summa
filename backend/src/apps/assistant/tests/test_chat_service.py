from typing import Any

import pytest
from django.contrib.auth import get_user_model

from apps.assistant.chat import MAX_TEXT_LENGTH, RATE_LIMIT_PER_MINUTE, chat_service
from apps.wallets.services import wallets_service
from infrastructure.common.errors import ApiError

pytestmark = pytest.mark.django_db


def make_user(name: str = "zoe") -> Any:
    return get_user_model()._default_manager.create_user(username=name)


def wallet(user: Any, name: str = "ملی") -> Any:
    return wallets_service.create(
        user,
        name=name,
        kind="bank",
        currency="IRT",
        bank="",
        opening_balance_minor=0,
        client_mutation_id=f"w-{name}",
    )


def send(user: Any, text: str, mutation: str = "m1") -> list[Any]:
    return chat_service.send(user, text=text, client_mutation_id=mutation)


def test_a_sentence_gets_a_reply_with_a_card() -> None:
    user = make_user()
    w = wallet(user)

    mine, reply = send(user, "۲۵۰ هزار تومن خرید نان")

    assert (mine.role, reply.role) == ("user", "assistant")
    assert reply.card is not None
    assert (reply.card["kind"], reply.card["amount_minor"], reply.card["wallet_id"]) == (
        "expense",
        250_000,
        w.id,
    )
    assert "۲۵۰٬۰۰۰" in reply.text and "تومان" in reply.text


def test_the_card_names_a_real_category_of_the_user() -> None:
    from apps.wallets.categories import category_service

    user = make_user()
    wallet(user)

    _, reply = send(user, "۸۰ هزار تومن اسنپ")

    names = {c.id: c.name for c in category_service.list(user)}
    assert names[reply.card["category_id"]] == "رفت‌وآمد"


def test_without_an_amount_there_is_help_and_no_card() -> None:
    user = make_user()

    _, reply = send(user, "سلام")

    assert reply.card is None
    assert "تومن" in reply.text


def test_the_assistant_writes_nothing_to_the_ledger() -> None:
    from apps.wallets.ledger import ledger_service

    user = make_user()
    wallet(user)

    send(user, "۲۵۰ هزار تومن خرید نان")

    assert ledger_service.list(user, wallet_id=None, limit=50) == []


def test_repeating_a_mutation_returns_the_same_pair_without_new_messages() -> None:
    user = make_user()
    wallet(user)

    first = send(user, "۵۰ هزار تومن نان")
    again = send(user, "۵۰ هزار تومن نان")

    assert [m.id for m in again] == [m.id for m in first]
    assert len(chat_service.history(user, limit=50)) == 2


def test_history_is_oldest_first_and_limited() -> None:
    user = make_user()
    wallet(user)
    for i in range(3):
        send(user, "سلام", mutation=f"m{i}")

    last_two = chat_service.history(user, limit=2)

    assert len(chat_service.history(user, limit=0)) == 6
    assert [m.role for m in last_two] == ["user", "assistant"]
    assert last_two[0].id == chat_service.history(user, limit=50)[-2].id


def test_chats_are_private() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    send(zoe, "راز من")

    assert chat_service.history(ali, limit=50) == []


@pytest.mark.parametrize(
    "bad",
    [{"text": "  "}, {"text": "x" * (MAX_TEXT_LENGTH + 1)}, {"client_mutation_id": ""}],
)
def test_invalid_messages_are_refused(bad: dict[str, str]) -> None:
    user = make_user()

    with pytest.raises(ApiError) as refusal:
        chat_service.send(user, **({"text": "سلام", "client_mutation_id": "m"} | bad))

    assert refusal.value.status == 400
    assert chat_service.history(user, limit=50) == []


def test_clear_really_deletes_only_my_messages() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    send(zoe, "سلام")
    send(ali, "سلام")

    chat_service.clear(zoe)

    assert chat_service.history(zoe, limit=50) == []
    assert len(chat_service.history(ali, limit=50)) == 2


def test_too_many_messages_in_a_minute_are_rate_limited() -> None:
    user = make_user()
    for i in range(RATE_LIMIT_PER_MINUTE):
        send(user, "سلام", mutation=f"m{i}")

    with pytest.raises(ApiError) as refusal:
        send(user, "سلام", mutation="one-too-many")

    assert refusal.value.status == 429
    assert len(chat_service.history(user, limit=200)) == 2 * RATE_LIMIT_PER_MINUTE
