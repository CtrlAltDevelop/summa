"""The landing content that ships with Summa imports cleanly and reads back."""

from io import StringIO
from pathlib import Path

import pytest
from django.core.management import call_command
from django.test import Client

from apps.cms.models import Menu, Page

pytestmark = pytest.mark.django_db

DOCUMENT = Path(__file__).resolve().parents[5] / "landing" / "content" / "landing.json"


@pytest.fixture
def landing(db: None) -> None:
    call_command("cms_import", str(DOCUMENT), stdout=StringIO())


def read(slug: str) -> dict:
    response = Client().get(f"/api/v1/cms/pages/{slug}?language=fa")
    assert response.status_code == 200, response.content
    return response.json()["data"]


def test_every_page_is_published_and_listed(landing: None) -> None:
    slugs = {p["id"] for p in Client().get("/api/v1/cms/pages").json()["data"]}

    assert {"home", "faq", "about", "privacy", "terms"} <= slugs


def test_the_home_page_carries_the_hero_the_steps_and_the_features(landing: None) -> None:
    page = read("home")
    sections = {s["id"]: s for s in page["sections"]}

    assert {"hero", "how", "features", "privacy"} <= set(sections)
    assert "Summa" in page["meta"]["title"]
    hero = {f["id"]: f["value"] for f in sections["hero"]["fields"]}
    assert "حساب" in hero["headline"] and hero["cta"]
    assert [c["id"] for c in sections["how"]["children"]] == ["step-1", "step-2", "step-3"]
    assert len(sections["features"]["children"]) == 5


def test_the_faq_has_questions_with_answers(landing: None) -> None:
    [questions] = read("faq")["sections"]

    assert len(questions["children"]) == 4
    for child in questions["children"]:
        fields = {f["id"]: f["value"] for f in child["fields"]}
        assert fields["title"].endswith("؟") and fields["body"]


def test_the_legal_pages_say_they_are_drafts_pending_review(landing: None) -> None:
    for slug in ("privacy", "terms"):
        body = {f["id"]: f["value"] for f in read(slug)["sections"][0]["fields"]}["body"]
        assert "بازبینی حقوقی" in body


def test_the_menus_point_at_existing_pages(landing: None) -> None:
    menus = {m.slug: m for m in Menu.objects.all()}

    assert {i.page.slug for i in menus["main"].items.all()} == {"home", "faq", "about"}
    assert {i.page.slug for i in menus["footer"].items.all()} == {"privacy", "terms"}


def test_importing_twice_changes_nothing(landing: None) -> None:
    before = Page.objects.count()

    call_command("cms_import", str(DOCUMENT), stdout=StringIO())

    assert Page.objects.count() == before == 5
