"""The example endpoint, over each transport it is published on."""

import json

from django.test import Client


def test_index() -> None:
    response = Client().get("/api/v1/assistant/")

    assert response.status_code == 200
    assert response.json()["data"] == {"message": "Assistant v1 API"}


def test_the_graphql_field_answers_the_same() -> None:
    response = Client().post(
        "/graphql",
        data={"query": "{ assistantGreeting }"},
        content_type="application/json",
    )

    body = json.loads(response.content)

    assert response.status_code == 200
    assert body["data"] == {"assistantGreeting": "Assistant v1 API"}
