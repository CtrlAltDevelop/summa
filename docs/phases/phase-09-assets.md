# Phase 09: Assets and prices

## Goal
The user records their assets (gold, coins, currencies, crypto…) with quantity and purchase price and sees today's value and profit and loss. The **backend** holds the rates and all clients only read from it; rates are approximate (we are not an exchange).

## Dependencies
Phase 01.

## Scope
**In**
- Backend (new app `apps.assets`): `Rate`, `Asset`, `Lot`; gRPC services `RateController` (`List`, `Convert`) and `AssetController` (`Create`, `AddLot`, `Sell`, `Delete`, `List`).
- **Symbol list** (Iran profile, `profile.py`): 18-karat gold (gram), coins (Emami, Bahar Azadi, half, quarter, gram), currencies (dollar, euro, dirham, lira, Tether), crypto (BTC, ETH). All priced in **Toman per one unit**.
- **Swappable price sources:** each source is an object with `fetch(symbols)`. A generic `HttpJsonSource` (URL + symbol-to-JSON-path mapping) configured with `DJANGO_ASSETS_SOURCES` (JSON). **The client's real API has not been provided yet**; with no configured source, rates are manual only (`manage.py set_rate`).
- **Per-symbol policy:** `first` (the first source that answers) or `median` (the median of all answers); an invalid value (zero, negative, non-numeric) or a jump of more than 50% from the previous value (configurable) is **rejected**. If all sources are down, the last price stays and becomes `stale` (older than 6 hours, configurable).
- `manage.py refresh_rates` (cron; Celery is not installed) refreshes all rates.
- **Currency conversion** (`Convert`): via Toman; rial = 0.1 Toman; a missing rate is an error; the response says whether the rate is stale. (Summing wallets into the base currency and net worth in phase 10 come from this.)
- **Asset:** a symbol from the list or "custom" with a manual price; each asset has several **purchases (lots)** with a quantity (decimal string up to 8 places, no float), a unit price (Toman) and a date.
- **Value and profit:** value = quantity x today's rate (rounded half up), cost = sum of quantity x purchase price, profit/loss = value - cost, and **realized** profit/loss from sales.
- **Sale** (`Sell`): FIFO over lots; realized profit = (sale price - purchase price) x quantity.
- App: asset list with value and profit/loss and a "stale price" badge, add form, asset page (new purchase, sell, delete), prices page.

**Out**
A real rate source (depends on the client's API), price history and charts, stocks and funds (stock exchange), reconciling percentage differences with the user's platform, Celery beat (deployment phase 17), deleting or editing a single lot.

## Rules and edges
- Quantity positive with at most 8 decimal places; unit price zero or more; selling more than the holding = `INVALID_ARGUMENT`; unknown symbol (other than "custom") = `INVALID_ARGUMENT`; custom without a name or price = `INVALID_ARGUMENT`.
- Someone else's asset = `NOT_FOUND`. A symbol with no source for its rate: `price_known` is false and the value is zero; totals do not count it.

## Tests
Sources (first, median, reject invalid value, reject jump, all down becomes stale), `HttpJsonSource` with a local server, currency conversion, asset and lot, value and profit, FIFO sale, isolation, commands, real gRPC, app.

## Acceptance
- [x] Asset value and profit and loss are computed correctly with the current rate.
- [x] A partial FIFO sale gives the correct realized profit.
- [x] A bad rate is rejected and the price is flagged stale when all sources are down.
- [x] `make check` and `make test` are green.

## Implementation status
- ✅ Backend: app `apps.assets` (`Rate`, `Asset`, `Lot`), Iran symbol list, swappable sources with `HttpJsonSource`, `refresh` with `first`/`median`, rejection of invalid values and jumps above 50%, last price kept and `stale` when sources are down, `Convert` (via Toman, rial = 0.1 Toman), asset with lots and value/cost/profit, FIFO sale with realized profit, `set_rate` and `refresh_rates` commands, `RatesController` and `AssetsController` over gRPC. Quantity is a decimal string with Decimal everywhere.
- ✅ App: asset list with value and profit/loss and "stale", add form (list symbol or custom), asset page (new purchase, sell, delete), prices page.
- ⚠️ **The client's real rate API has not been provided yet**; without `DJANGO_ASSETS_SOURCES` the rates are manual (`manage.py set_rate USD 61000`). `HttpJsonSource` has only been tested with a local server, not a real source. Celery is not installed: run `manage.py refresh_rates` from cron (Celery beat wiring in phase 17). The app has not been run on a device.
- ⏳ Later: stocks and funds, price history and charts, reconciling percentage differences with the user's platform, deleting/editing a lot, pricing removed from `Convert` in wallet totals (phase 10).
