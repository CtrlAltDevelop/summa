# Phase 11: Reports and export

## Goal
For each Shamsi month the user sees how much income and expense they had, how their spending splits across categories and what happened day by day; and they can export their data as CSV.

## Dependencies
Phases 02 and 03 (and 06, 06b for the "excluded from totals" and refund rules).

## Scope
**In**
- Backend (new app `apps.reports`): gRPC service `ReportController`: `Monthly` and `ExportCsv`.
- **`Monthly(starts_at, ends_at, currency)`**: the **app** supplies the range (Shamsi month converted to UTC; the server does not know the calendar); at most 366 days. The report is **for a single currency**; currencies are not summed together (the historical-rate policy is not decided yet, so there is no implicit conversion). Response: income, expense, net, transaction count, category breakdown (expense and income separate, uncategorized too), daily series (Tehran day), top spending category, and the list of currencies with activity in the range.
- **Rules:** transfers are not counted. An "excluded from totals" expense and its refund are not counted. **A refund reduces the expense** (in the refund's own category and day). A transfer fee is a normal expense with no category. Split parts each land in their own category. A voided event and the initial balance are not counted. The range is half-open `[start, end)`.
- **`ExportCsv(starts_at, ends_at)`** (range optional): all of the user's ledger events with columns for Shamsi and ISO date, type, amount (decimal number correct for the currency), currency, wallet, category, note, excluded from totals, split/transfer/refund id. UTF-8 with a BOM for Excel; cells starting with `= + - @` get a prefix to prevent formula execution; at most 50,000 rows.
- App: a "Month report" page with previous/next month navigation, currency picker, income/expense/net cards, category bars, a daily bar chart.

**Out**
**The export button in the app** (per the project rule, export and import must sit behind biometrics/the app passcode; that lock is phase 15 and the button is built in 15b), multi-currency reports with historical rates, annual report, two-month comparison, PDF, file import.

## Rules and edges
- `starts_at`/`ends_at` with a time zone, `start < end`, at most 366 days; an invalid currency = `INVALID_ARGUMENT`.
- Everything is only for the authenticated user; one user never sees another's report or export.
- A month with no transactions: zeros and empty lists (not an error).

## Tests
Totals and rules (excluded from totals, refund, transfer, fee, split, voided, range boundary), separate currencies, category breakdown with refunds, Tehran daily series, top spending category, validation, isolation, CSV (header, character escaping, formula injection, BOM, currency decimals, range, cap), real gRPC, app.

## Acceptance
- [x] The expense total with refunds and "excluded from totals" is correct.
- [x] The daily chart buckets by Tehran day.
- [x] A Persian CSV opens correctly in Excel and does not execute formulas.
- [x] `make check` and `make test` are green.

## Implementation status
- ✅ Backend: app `apps.reports` with `ReportController` (`Monthly`, `ExportCsv`). A single-currency report with income/expense/net, category breakdown (refund reduces, excluded-from-totals and transfers are left out, fee is "uncategorized"), daily series by Tehran day, top spending category and currencies with activity. CSV with BOM, correct character escaping, formula neutralization (`'` before `= + - @`), each currency's decimals and the 50,000-row cap.
- ✅ App: "Month report" with previous/next (Shamsi month), currency picker, cards, category bars and a daily bar chart.
- ⚠️ **There is deliberately no CSV export button in the app**: per the project rule, data export must be behind biometrics/the app passcode (phase 15 and 15b). Until then the RPC works with a normal token but is not reachable from the UI. The app has not been run on a device.
- ⏳ Later: multi-currency report with a historical-rate policy (open question), two-month comparison, annual report.
