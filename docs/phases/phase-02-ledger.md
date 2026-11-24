# Phase 02: Ledger

## Goal
The user records expenses and income manually by picking a wallet, sees the list, and edits or deletes entries; wallet balances update automatically.

## Dependencies
Phase 01b.

## Scope
**In**
- Backend (same `apps.wallets` app): `income` and `expense` events on `LedgerEvent`; gRPC service `LedgerController` with `Record` / `List` / `Edit` / `Delete`.
- An event is immutable: **editing** an event creates a replacement (`replaces`) and voids (`voided`) the old one; **deleting** only voids. Balances and totals do not count voided events.
- Fields: wallet, type, amount (`int64`, positive), occurrence time (default now, UTC), note (<= 200 characters), `client_mutation_id` unique per user.
- List: newest first, optional wallet filter, `limit` (default 50, max 200).
- App: a record expense/income button, a form (wallet, type, amount, note), a transaction list on the home screen with Shamsi dates, delete.

**Out**
Categories (03), transfers (02b), refunds (06b), splits (06), editing in the app UI (the RPC is ready), infinite pagination.

## Rules and edges
- Every access is filtered by the authenticated user; another user's event or wallet = `NOT_FOUND`.
- Recording on an archived wallet, amount <= 0, a long note, an invalid type = `INVALID_ARGUMENT`.
- The opening balance cannot be edited or deleted.
- Editing or deleting a voided event = `NOT_FOUND`.

## Tests
Service: recording expense/income and the effect on balance, idempotency, archived wallet, invalid input, isolation, edit, delete, protected opening balance, list filter and order. Real gRPC. App: record widget, list, delete.

## Acceptance
- [x] Recording an expense lowers the balance and income raises it.
- [x] Edit/delete fix the balance and the event trail remains.
- [x] "Other user" test for record, list, edit and delete.
- [x] `make check` and `make test` green.

## Status
- ✅ Backend: `LedgerController` (Record/List/Edit/Delete) in `apps.wallets`; edit = replacement event, delete = voiding; balance does not count voided events; amount is `int64`.
- ✅ App: record expense/income, list with Shamsi dates, delete; wallet balances are re-read after every change.
- ⚠️ Not yet run on a device/simulator. Occurrence time in the app is always "now" (the server supports ISO-8601 with a time zone).
- ⏳ Later: editing in the app UI, date picking, categories (03).
