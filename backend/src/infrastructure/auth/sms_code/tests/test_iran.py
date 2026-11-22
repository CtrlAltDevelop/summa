"""Summa signs people in with an Iranian mobile number, however they type it."""

from django.contrib.auth import get_user_model
from django.test import Client

from infrastructure.auth.core import delivery
from infrastructure.auth.core.models import PhoneNumber

LOGIN_START = "/api/v1/auth/sms-code/login/start"
LOGIN_VERIFY = "/api/v1/auth/sms-code/login/verify"
CANONICAL = "+989123456789"


def _start(client: Client, phone: str) -> dict[str, object]:
    response = client.post(LOGIN_START, {"phone": phone}, content_type="application/json")
    assert response.status_code == 200, response.content
    data: dict[str, object] = response.json()["data"]
    return data


def _verify(client: Client, ticket: object) -> int:
    code = delivery.outbox[-1].body.rsplit(": ", 1)[1]
    response = client.post(
        LOGIN_VERIFY, {"ticket": ticket, "code": code}, content_type="application/json"
    )
    assert response.status_code == 200, response.content
    return int(response.status_code)


def test_a_new_number_typed_locally_creates_an_account_on_first_login(db: None) -> None:
    client = Client()
    challenge = _start(client, "۰۹۱۲۳۴۵۶۷۸۹")

    assert delivery.outbox[-1].destination == CANONICAL
    _verify(client, challenge["ticket"])

    assert PhoneNumber.objects.get(number=CANONICAL).is_verified is True
    assert get_user_model().objects.count() == 1


def test_every_way_of_typing_the_number_reaches_the_same_account(db: None) -> None:
    client = Client()
    _verify(client, _start(client, "09123456789")["ticket"])
    users_after_first = get_user_model().objects.count()

    # The resend cooldown is per destination; clearing the outbox is not the point,
    # so sign in through a second client whose request is a different spelling.
    delivery.outbox.clear()
    second = Client()
    _verify(second, _start(second, "+98 912 345 6789")["ticket"])

    assert get_user_model().objects.count() == users_after_first


def test_the_start_response_has_the_same_shape_for_known_and_unknown_numbers(
    db: None,
) -> None:
    client = Client()
    unknown = _start(client, "09120000001")
    _verify(client, unknown["ticket"])
    known = _start(Client(), "09120000001")

    assert set(known) == set(unknown)
    assert known["destination"] == unknown["destination"] == "***0001"
