import json
import threading
from datetime import UTC, datetime, timedelta
from decimal import Decimal
from http.server import BaseHTTPRequestHandler, HTTPServer
from typing import Any

import pytest
from django.core.management import call_command

from apps.assets.models import Rate
from apps.assets.rates import HttpJsonSource, RateSource, rate_service
from infrastructure.common.errors import ApiError

pytestmark = pytest.mark.django_db

NOW = datetime(2026, 11, 22, 9, 0, tzinfo=UTC)


class Fake:
    def __init__(self, name: str, prices: dict[str, Any] | None = None, down: bool = False) -> None:
        self.name = name
        self.prices = {k: Decimal(str(v)) for k, v in (prices or {}).items()}
        self.down = down

    def fetch(self, symbols: Any) -> dict[str, Decimal]:
        if self.down:
            raise ConnectionError(self.name)
        return dict(self.prices)


def price(symbol: str) -> Decimal | None:
    return rate_service.price_of(symbol)


def test_the_first_source_that_answers_wins_for_a_first_strategy_symbol() -> None:
    a = Fake("a", {"GOLD18": 8_000_000})
    b = Fake("b", {"GOLD18": 9_000_000, "USD": 60_000})

    result = rate_service.refresh([a, b], now=NOW)

    assert (price("GOLD18"), price("USD")) == (Decimal(8_000_000), Decimal(60_000))
    assert sorted(result.updated) == ["GOLD18", "USD"]
    assert Rate.objects.get(symbol="GOLD18").source == "a"


def test_a_failing_source_is_skipped_and_reported() -> None:
    down, up = Fake("down", down=True), Fake("up", {"USD": 61_000})

    result = rate_service.refresh([down, up], now=NOW)

    assert price("USD") == Decimal(61_000) and result.failed_sources == ["down"]


def test_median_symbols_take_the_middle_answer() -> None:
    sources = [
        Fake("a", {"USDT": 60_000}),
        Fake("b", {"USDT": 90_000}),
        Fake("c", {"USDT": 61_000}),
    ]

    rate_service.refresh(sources, now=NOW)

    assert price("USDT") == Decimal(61_000)


def test_the_median_of_two_answers_is_their_average() -> None:
    rate_service.refresh([Fake("a", {"USDT": 60_000}), Fake("b", {"USDT": 62_000})], now=NOW)

    assert price("USDT") == Decimal(61_000)


@pytest.mark.parametrize("bad", [0, -5, "NaN", "Infinity", "-Infinity"])
def test_invalid_prices_are_rejected(bad: Any) -> None:
    result = rate_service.refresh([Fake("a", {"USD": bad})], now=NOW)

    assert price("USD") is None and "USD" in result.rejected


def test_unknown_symbols_are_ignored() -> None:
    rate_service.refresh([Fake("a", {"DOGE": 5, "USD": 60_000})], now=NOW)

    assert price("DOGE") is None and price("USD") == Decimal(60_000)


def test_a_wild_jump_is_rejected_and_the_old_price_kept() -> None:
    rate_service.refresh([Fake("a", {"USD": 60_000})], now=NOW)

    result = rate_service.refresh([Fake("a", {"USD": 200_000})], now=NOW + timedelta(minutes=1))

    assert price("USD") == Decimal(60_000)
    assert "USD" in result.rejected
    assert Rate.objects.get(symbol="USD").fetched_at == NOW


def test_a_normal_move_is_accepted() -> None:
    rate_service.refresh([Fake("a", {"USD": 60_000})], now=NOW)
    rate_service.refresh([Fake("a", {"USD": 63_000})], now=NOW + timedelta(minutes=1))

    assert price("USD") == Decimal(63_000)


def test_when_every_source_is_down_the_last_price_stays_and_goes_stale() -> None:
    rate_service.refresh([Fake("a", {"USD": 60_000})], now=NOW)

    result = rate_service.refresh([Fake("a", down=True)], now=NOW + timedelta(hours=1))
    fresh = {r.symbol: r for r in rate_service.list(NOW + timedelta(hours=1))}
    old = {r.symbol: r for r in rate_service.list(NOW + timedelta(hours=7))}

    assert result.updated == [] and price("USD") == Decimal(60_000)
    assert (fresh["USD"].stale, old["USD"].stale) == (False, True)
    assert old["USD"].age_seconds == 7 * 3600


def test_the_list_covers_the_catalog_with_unknown_prices_marked() -> None:
    rate_service.refresh([Fake("a", {"USD": 60_000})], now=NOW)

    listed = {r.symbol: r for r in rate_service.list(NOW)}

    assert listed["USD"].price == Decimal(60_000) and listed["USD"].known
    assert listed["GOLD18"].known is False and listed["GOLD18"].stale is True
    assert listed["GOLD18"].name == "طلای ۱۸ عیار"


def test_a_manual_rate_is_stored_with_its_source() -> None:
    rate_service.set_manual("GOLD18", Decimal("8100000"), now=NOW)

    assert price("GOLD18") == Decimal(8_100_000)
    assert Rate.objects.get(symbol="GOLD18").source == "manual"


@pytest.mark.parametrize(("symbol", "value"), [("NOPE", "5"), ("USD", "0"), ("USD", "-1")])
def test_a_bad_manual_rate_is_refused(symbol: str, value: str) -> None:
    with pytest.raises(ApiError) as refusal:
        rate_service.set_manual(symbol, Decimal(value), now=NOW)

    assert refusal.value.status == 400


# --- conversion ---------------------------------------------------------------------


def seed() -> None:
    rate_service.refresh([Fake("a", {"USD": 60_000, "EUR": 70_000})], now=NOW)


def test_toman_to_dollars_and_back() -> None:
    seed()

    to_usd = rate_service.convert(1_200_000, "IRT", "USD", now=NOW)
    to_toman = rate_service.convert(2_000, "USD", "IRT", now=NOW)

    assert (to_usd.amount_minor, to_toman.amount_minor) == (2_000, 1_200_000)


def test_one_foreign_currency_to_another_goes_through_toman() -> None:
    seed()

    assert rate_service.convert(7_000, "EUR", "USD", now=NOW).amount_minor == 8_167  # 81.666..


def test_toman_and_rial_need_no_rate() -> None:
    assert rate_service.convert(100, "IRT", "IRR", now=NOW).amount_minor == 1_000
    assert rate_service.convert(1_005, "IRR", "IRT", now=NOW).amount_minor == 101  # half up 100.5


def test_the_same_currency_is_returned_as_it_is() -> None:
    assert rate_service.convert(123, "USD", "USD", now=NOW).amount_minor == 123


def test_a_missing_rate_or_unknown_currency_is_refused() -> None:
    with pytest.raises(ApiError) as missing:
        rate_service.convert(100, "IRT", "USD", now=NOW)
    with pytest.raises(ApiError) as unknown:
        rate_service.convert(100, "IRT", "XXX", now=NOW)

    assert (missing.value.status, unknown.value.status) == (404, 400)


def test_a_conversion_says_when_its_rate_is_old() -> None:
    seed()

    fresh = rate_service.convert(100, "IRT", "USD", now=NOW)
    stale = rate_service.convert(100, "IRT", "USD", now=NOW + timedelta(hours=7))

    assert (fresh.stale, stale.stale) == (False, True)


def test_negative_amounts_convert_symmetrically() -> None:
    seed()

    assert rate_service.convert(-1_200_000, "IRT", "USD", now=NOW).amount_minor == -2_000


# --- an HTTP JSON source -----------------------------------------------------------


def serve(payload: Any, status: int = 200) -> tuple[HTTPServer, str]:
    class Handler(BaseHTTPRequestHandler):
        def do_GET(self) -> None:  # noqa: N802
            body = payload if isinstance(payload, bytes) else json.dumps(payload).encode()
            self.send_response(status)
            self.end_headers()
            self.wfile.write(body)

        def log_message(self, *args: Any) -> None:
            return

    server = HTTPServer(("127.0.0.1", 0), Handler)
    threading.Thread(target=server.serve_forever, daemon=True).start()
    return server, f"http://127.0.0.1:{server.server_port}/"


def test_the_http_source_reads_prices_by_path() -> None:
    server, url = serve({"data": {"usd": "61000", "gold": 8_200_000.5}, "ts": 1})
    try:
        source: RateSource = HttpJsonSource(
            "feed", url, {"USD": "data.usd", "GOLD18": "data.gold", "EUR": "data.missing"}
        )
        got = source.fetch(["USD", "GOLD18", "EUR"])
    finally:
        server.shutdown()

    assert got == {"USD": Decimal(61_000), "GOLD18": Decimal("8200000.5")}


@pytest.mark.parametrize(("payload", "status"), [(b"not json", 200), ({"a": 1}, 500)])
def test_the_http_source_fails_loudly_so_the_next_source_can_answer(
    payload: Any, status: int
) -> None:
    server, url = serve(payload, status)
    try:
        with pytest.raises(OSError):
            HttpJsonSource("feed", url, {"USD": "a"}).fetch(["USD"])
    finally:
        server.shutdown()


def test_a_refresh_through_an_http_source_end_to_end() -> None:
    server, url = serve({"usd": 60_500})
    try:
        rate_service.refresh([HttpJsonSource("feed", url, {"USD": "usd"})], now=NOW)
    finally:
        server.shutdown()

    assert price("USD") == Decimal(60_500)


# --- configuration and commands -----------------------------------------------------


def test_sources_come_from_settings(settings: Any) -> None:
    settings.ASSETS_SOURCES = [{"name": "feed", "url": "http://x.invalid/", "map": {"USD": "u"}}]

    [source] = rate_service.configured_sources()

    assert isinstance(source, HttpJsonSource) and source.name == "feed"


def test_set_rate_and_refresh_commands(capsys: Any, settings: Any) -> None:
    settings.ASSETS_SOURCES = []

    call_command("set_rate", "USD", "61000")
    call_command("refresh_rates")

    out = capsys.readouterr().out
    assert price("USD") == Decimal(61_000)
    assert "USD" in out and "no sources" in out.lower()
