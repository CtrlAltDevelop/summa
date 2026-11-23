from datetime import UTC, datetime, timedelta
from typing import Any

import pytest
from django.contrib.auth import get_user_model

from apps.sync.service import OVERLAP, Cursors, sync_service
from apps.wallets.categories import category_service
from apps.wallets.ledger import ledger_service
from apps.wallets.models import Category, LedgerEvent, Wallet
from apps.wallets.services import wallets_service
from apps.wallets.transfers import transfer_service
from infrastructure.common.errors import ApiError

pytestmark = pytest.mark.django_db

T0 = datetime(2026, 11, 22, 9, 0, tzinfo=UTC)


def make_user(name: str = "zoe") -> Any:
    return get_user_model()._default_manager.create_user(username=name)


def wallet(user: Any, name: str = "a", balance: int = 1_000) -> Any:
    return wallets_service.create(
        user,
        name=name,
        kind="bank",
        currency="IRT",
        bank="",
        opening_balance_minor=balance,
        client_mutation_id=f"w-{name}",
    )


def spend(user: Any, w: Any, mutation: str, **kw: Any) -> Any:
    return ledger_service.record(
        user,
        wallet_id=w.id,
        kind=kw.pop("kind", "expense"),
        amount_minor=kw.pop("amount", 10),
        occurred_at=None,
        note="",
        client_mutation_id=mutation,
        **kw,
    )


def pull_all(user: Any, cursors: Cursors | None = None, limit: int = 200) -> tuple[Any, Cursors]:
    """Page until the server says there is no more; return everything and the cursors."""
    seen: dict[str, dict[str, Any]] = {"wallets": {}, "categories": {}, "entries": {}}
    cursors = cursors or Cursors()
    while True:
        page = sync_service.changes(user, cursors, limit=limit)
        for key in seen:
            for row in getattr(page, key):
                seen[key][row.id] = row  # apply by id: duplicates are harmless
        cursors = page.cursors
        if not page.has_more:
            return seen, cursors


# --- the models track their own changes -----------------------------------------


def test_save_update_and_group_updates_all_refresh_updated_at() -> None:
    user = make_user()
    w = wallet(user)
    old = T0 - timedelta(days=1)
    Wallet.objects.filter(pk=w.id).update(updated_at=old)
    LedgerEvent.objects.filter(user=user).update(updated_at=old)
    Category.objects.filter(user=user).update(updated_at=old)

    wallets_service.archive(user, w.id)  # queryset.update
    entry = spend(user, wallet(user, "b"), "e1")
    ledger_service.delete(user, entry.id)  # save(update_fields=["voided"])

    assert Wallet.objects.get(pk=w.id).updated_at > old
    assert LedgerEvent.objects.get(pk=entry.id).updated_at > old
    assert LedgerEvent.objects.filter(user=user, voided=True).count() == 1


def test_an_explicit_updated_at_wins_over_the_automatic_one() -> None:
    user = make_user()
    w = wallet(user)

    Wallet.objects.filter(pk=w.id).update(updated_at=T0)

    assert Wallet.objects.get(pk=w.id).updated_at == T0


# --- the feed ----------------------------------------------------------------------


def test_the_first_pull_returns_everything_the_user_has() -> None:
    user = make_user()
    w = wallet(user)
    entry = spend(user, w, "e1")
    category_service.list(user)

    seen, _ = pull_all(user)

    assert set(seen["wallets"]) == {w.id}
    assert entry.id in seen["entries"] and len(seen["entries"]) == 2  # + the opening balance
    assert len(seen["categories"]) == 19


def test_rows_carry_what_a_device_needs() -> None:
    user = make_user()
    w = wallet(user)
    food = next(c.id for c in category_service.list(user) if c.name == "خوراک و سوپرمارکت")
    entry = spend(user, w, "e1", category_id=food, outside_totals=True)

    seen, _ = pull_all(user)
    row = seen["entries"][entry.id]

    assert (row.wallet_id, row.kind, row.direction, row.amount_minor) == (
        w.id,
        "expense",
        "out",
        10,
    )
    assert (row.category_id, row.outside_totals, row.voided) == (food, True, False)
    assert (seen["wallets"][w.id].name, seen["wallets"][w.id].archived) == ("a", False)


def test_a_second_pull_with_the_cursors_returns_only_what_changed() -> None:
    user = make_user()
    w = wallet(user)
    spend(user, w, "e1")
    _, cursors = pull_all(user)
    # push the old rows safely out of the overlap window so only the new one qualifies
    old = T0 - timedelta(hours=1)
    LedgerEvent.objects.filter(user=user).update(updated_at=old)
    Wallet.objects.filter(user=user).update(updated_at=old)
    cursors = Cursors(events=f"{T0.isoformat()}|", wallets=f"{T0.isoformat()}|")
    newer = spend(user, w, "e2")

    seen, _ = pull_all(user, cursors)

    assert set(seen["entries"]) == {newer.id} and seen["wallets"] == {}


def test_a_void_a_split_and_an_archive_all_travel_as_changes() -> None:
    user = make_user()
    w = wallet(user)
    entry = spend(user, w, "e1")
    _, cursors = pull_all(user)

    ledger_service.delete(user, entry.id)
    wallets_service.archive(user, w.id)
    seen, _ = pull_all(user, cursors)

    assert seen["entries"][entry.id].voided is True
    assert seen["wallets"][w.id].archived is True


def test_voiding_a_whole_transfer_changes_every_leg() -> None:
    user = make_user()
    a, b = wallet(user, "a", 5_000), wallet(user, "b")
    legs = transfer_service.transfer(
        user,
        from_wallet_id=a.id,
        to_wallet_id=b.id,
        amount_minor=100,
        rate="",
        fee_minor=5,
        occurred_at=None,
        note="",
        client_mutation_id="t",
    )
    _, cursors = pull_all(user)

    ledger_service.delete(user, legs[1].id)
    seen, _ = pull_all(user, cursors)

    assert {i for i, row in seen["entries"].items() if row.voided} >= {leg.id for leg in legs}


def test_deleting_a_category_moves_its_entries_and_they_show_up() -> None:
    user = make_user()
    w = wallet(user)
    trip = category_service.create(user, name="سفر", kind="expense")
    entry = spend(user, w, "e1", category_id=trip.id)
    _, cursors = pull_all(user)

    category_service.delete(user, trip.id)
    seen, _ = pull_all(user, cursors)
    other = next(c.id for c in category_service.list(user) if c.is_other and c.kind == "expense")

    assert seen["entries"][entry.id].category_id == other


def test_paging_with_one_timestamp_neither_skips_nor_repeats_within_a_page_walk() -> None:
    user = make_user()
    w = wallet(user)
    ids = {spend(user, w, f"e{i}").id for i in range(6)}
    LedgerEvent.objects.filter(user=user).update(updated_at=T0)  # all share one instant

    pages = []
    cursors = Cursors()
    while True:
        page = sync_service.changes(user, cursors, limit=2)
        pages.append([r.id for r in page.entries])
        cursors = page.cursors
        if not page.has_more:
            break

    flat = [i for page in pages for i in page]
    assert ids <= set(flat) and len(pages) >= 3
    # while the pages are full the cursor advances exactly: no overlap, so no repeats
    full_pages = [p for p in pages[:-1] if len(p) == 2]
    assert len({i for p in full_pages for i in p}) == sum(len(p) for p in full_pages)


def test_the_last_page_leaves_an_overlap_behind_the_newest_row() -> None:
    user = make_user()
    w = wallet(user)
    spend(user, w, "e1")
    LedgerEvent.objects.filter(user=user).update(updated_at=T0)

    page = sync_service.changes(user, Cursors(), limit=200)

    assert page.has_more is False
    assert page.cursors.events.startswith((T0 - OVERLAP).isoformat())


def test_an_empty_feed_keeps_the_cursor() -> None:
    user = make_user()

    page = sync_service.changes(user, Cursors(events="2026-11-22T09:00:00+00:00|"), limit=10)

    assert page.entries == [] and page.has_more is False
    assert page.cursors.events == "2026-11-22T09:00:00+00:00|"


@pytest.mark.parametrize("bad", ["garbage", "2026-13-01T00:00:00+00:00|", "2026-11-22T09:00:00|x"])
def test_bad_cursors_are_refused(bad: str) -> None:
    with pytest.raises(ApiError) as refusal:
        sync_service.changes(make_user(), Cursors(events=bad), limit=10)

    assert refusal.value.status == 400


def test_the_limit_is_clamped() -> None:
    user = make_user()
    w = wallet(user)
    for i in range(3):
        spend(user, w, f"e{i}")

    assert len(sync_service.changes(user, Cursors(), limit=0).entries) == 4  # default
    assert len(sync_service.changes(user, Cursors(), limit=-5).entries) == 4
    assert len(sync_service.changes(user, Cursors(), limit=1).entries) == 1
    assert sync_service.changes(user, Cursors(), limit=10_000).has_more is False


def test_users_only_ever_receive_their_own_rows() -> None:
    zoe, ali = make_user("zoe"), make_user("ali")
    wallet(zoe)
    spend(zoe, wallet(zoe, "z2"), "e1")

    seen, _ = pull_all(ali)

    assert seen == {"wallets": {}, "categories": {}, "entries": {}}
