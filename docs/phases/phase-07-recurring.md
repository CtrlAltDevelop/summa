# Phase 07: Recurring transactions

## Goal
An expense or income that repeats every month (or week) (rent, installment, subscription, salary) is defined once. Near the due date it reports if the wallet balance is low; on the due day it asks "was it deducted from this account? / from another account / canceled".

## Dependencies
Phases 01b and 02 (and 03 for categories).

## Scope
**In**
- Backend (new `apps.recurring` app): `Recurring` (wallet, kind, fixed or variable amount, category, note, period, day, `auto_confirm`, active/paused) and `Occurrence` (due date and status `pending`/`confirmed`/`cancelled`). gRPC service `RecurringController`: `Create` / `List` / `SetActive` / `Delete` / `Resolve`.
- **Period:** monthly with a **Shamsi month** day (1 to 31; if the month is shorter it moves to the month's last day) or weekly with a weekday. The next due date is computed from today's date in Tehran time.
- **Generating occurrences** (`process`): `Occurrence` records are created up to 3 days ahead (at most 12 overdue items per run). `List` runs `process` for the user, and the command `manage.py process_recurring` runs it for all users (cron/Celery beat later; Celery is not installed for now).
- **Display status:** `upcoming` (due in the future) and `due` (today or past and unanswered). **Low balance:** for an occurrence whose amount is known, `low_balance` is true if the wallet balance is less than the amount.
- **Resolve:** `confirm` (from the same wallet: a normal expense/income is recorded with a fixed `client_mutation_id`), `other_wallet` (from another wallet in the same currency), `cancel` (this occurrence only). A variable amount is required at confirmation.
- `auto_confirm` (fixed amount only): recorded automatically on the due day; if that fails (archived wallet...) it stays `due` and asks.
- App: a definition form, a list of recurring items with the next due date and balance warning, "due" cards with three buttons.

**Out**
Push notification (07c/15), other periods (yearly, every N days), editing a definition (delete and recreate), recurring transfers.

## Rules and edges
- Someone else's wallet or category = `NOT_FOUND`. A negative amount, a day out of range, an invalid period, an archived wallet, a long note = `INVALID_ARGUMENT`.
- `auto_confirm` with a variable amount = `INVALID_ARGUMENT`.
- Resolving an already resolved occurrence = `INVALID_ARGUMENT`; someone else's occurrence = `NOT_FOUND`.
- Resolving twice (confirming twice) creates only one event.

## Tests
Calendar (Gregorian → Shamsi conversion, month length), next due date (short month, leap Esfand, weekly), `process` (3-day window, overdue cap, idempotent), `Resolve` (three modes, variable, another wallet, again), `auto_confirm`, balance warning, isolation, the command. Real gRPC. App: widget.

## Acceptance
- [x] A monthly rent on the 15th of each Shamsi month creates the correct due dates.
- [x] Three days ahead with a low balance gives `low_balance`.
- [x] Confirming records one normal expense and tapping again does not record again.
- [x] `make check` and `make test` are green.

## Status
- ✅ Backend: `apps.recurring` app (`Recurring`, `Occurrence`), monthly due dates by **Shamsi month** day (shorter → last day, leap Esfand) and weekly, a 3-day window and a cap of 12 overdue, `low_balance`, `Resolve` (confirm/other wallet/cancel), `auto_confirm`, the `process_recurring` command, `RecurringController` over gRPC. Gregorian → Shamsi conversion was also added to `calendar.py`.
- ✅ App: a definition form (monthly/weekly, fixed or variable amount, auto-record), due cards with three buttons, balance warning, pause/delete.
- ⚠️ Celery is not installed: occurrences are generated on `List` for that user and by `manage.py process_recurring` (cron); wiring Celery beat to the same function is a deployment-phase (17) task. There is no push notification yet (07c/15). The app has not been run on a device.
