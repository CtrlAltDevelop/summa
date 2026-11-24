# Phase 15b: Data import and export

## Goal
The user takes their data out (CSV export) and brings a CSV file in. Both happen **only after strong authentication** (biometrics, or the app passcode, which is enabled first if missing); this is the project rule.

## Dependencies
Phase 15 (the `confirmStrongAuth` gate) and 11 (CSV export).

## Scope
**In**
- Backend (on `ReportController`): `ImportCsv(text, commit)`. **Preview** (`commit=false`) only counts and reports errors with line numbers; **import** (`commit=true`) runs only when there are no errors and is **all-or-nothing**.
- Format: headers `kind`, `amount`, `wallet` and one of `datetime_utc` / `date` / `date_shamsi`; optional: `category`, `note`, `currency`. **The app's own export file can be imported unchanged** (rows other than `income`/`expense`, such as transfers, reversals and opening balances, count as "skipped", not errors).
- Per-row rules: kind is `income` or `expense`; amount is a decimal with exactly the wallet currency's decimal places (no rounding); the wallet must be the user's own, matched by **name**, and open; the category (if present) must match the kind; the date is ISO or Shamsi (Persian digits too), and with no time it means 12:00 noon Tehran; `currency`, if present, must equal the wallet's currency.
- **Idempotent:** each row's registration id is built from the row's content (and its repeat index in the file); importing the same file again adds nothing, but two identical rows in one file are both recorded.
- Limits: 5,000 rows and 1 MB; more = `INVALID_ARGUMENT`.
- App: a "Data export and import" screen: an export button (strong gate -> `ExportCsv` -> save/share the file through the `FileSaver` interface), a box for pasting CSV, "Preview" and "Import" (both behind the strong gate).

**Out**
Picking a file from the device (needs the `file_picker` plugin; for now the CSV text is pasted), Excel files (xlsx), importing wallets and categories, smart duplicate detection against data already entered by hand, arbitrary column mapping. Saving/sharing files with `share_plus` has not been tested on a device.

## Rules and edges
- Every error carries a row and a message; with any error nothing is recorded.
- Empty text or missing required headers = `INVALID_ARGUMENT`.
- Another user's data never shows up in wallet names.

## Tests
Preview and import, export -> import round trip for another user, Persian digits and Shamsi dates, every error, all-or-nothing, re-import, identical rows, limits, isolation, gRPC; app: strong gate before export/import, file saving, preview and import.

## Acceptance
- [x] The app's export imports again unchanged and creates the same transactions for a fresh user.
- [x] Neither action runs without strong authentication.
- [x] `make check` and `make test` are green.

## Status
- ✅ Backend: `ImportCsv` (preview and all-or-nothing, ISO/Shamsi dates and Persian digits, exact decimals per currency, wallets and categories by name, idempotent with ids from row content, skipping transfer/reversal/opening-balance rows in the app's own export, limits of 5,000 rows and 1 MB). **Round-trip test:** one user's export is imported for another user.
- ✅ App: the "Data export and import" screen, where **every step** (export, preview, import) passes `confirmStrongAuth` first; without identity confirmation no request goes to the server.
- ⚠️ File saving/sharing with `share_plus` (the `FileSaver` interface) and biometrics have not been tested on a real device. **Picking a file from the device and xlsx were not built** (CSV text is pasted).
