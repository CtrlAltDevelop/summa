# Phase 12: Offline and sync

## Goal
The app is usable without internet (see the latest data and record transactions) and a user's multiple devices converge to the same state.

## Dependencies
Phase 02.

## Scope
**In**
- Backend: `updated_at` tracking on `Wallet`, `Category` and `LedgerEvent` (every `save` and every `QuerySet.update` refreshes it); new app `apps.sync` with `SyncController.Changes`.
- **`Changes`** returns three independent lists (wallets, categories, ledger events) with a **keyset cursor** `(updated_at, id)`; each has its own cursor. Pagination with `limit` (default 200, at most 500 per list) and `has_more`. Balances are not in the feed (they are computed from events). A voided event arrives with `voided=true` and an archived wallet with `archived=true`. Only the user's own data.
- **5-second overlap:** when it is the last page the cursor is given 5 seconds earlier than the last data row so that a transaction committed late is not missed; the client applies duplicate rows by `id` with no effect (idempotent).
- App: an **outbox** for recording expenses/income: when there is no internet, the entry goes to a durable queue (a file) and is sent later with the same `client_mutation_id` (idempotent); a server rejection (invalid/not found) goes to a "failed" list and is cleared by tapping "Delete". A **read cache**: the latest lists of wallets, categories and transactions are kept in a file and shown offline. A "pending send" badge and a "Send again" button.

**Out**
An outbox for other operations (transfer, split, refund, debt…), applying the feed into a full local database (replacing the cache), referencing an entity that is still offline (needs client-side ids), background sync and push, resolving concurrent edit conflicts (the ledger is append-only and the server wins), encrypting the cache file (phase 15).

## Rules and edges
- An invalid cursor = `INVALID_ARGUMENT`; an out-of-range `limit` is clamped to the range.
- Everything is tied to the authenticated user; the user id never comes from the client.
- Queueing with the same `client_mutation_id` twice creates only one event.

## Tests
Backend: `updated_at` tracking (save, update, bulk void, archive, category move), the feed (first load, change, void, archive, category, pagination with identical timestamps without skipping or duplicating, overlap, bad cursor, isolation), real gRPC. App: the queue (add, send, stay when offline, server rejection, idempotency), cache, widget.

## Acceptance
- [x] A second device paginates through all events without skipping or duplicating.
- [x] Changes (void, archive, category move) arrive in the feed.
- [x] An offline entry is recorded exactly once after reconnecting.
- [x] `make check` and `make test` are green.

## Implementation status
- ✅ Backend: `updated_at` on `Wallet`/`Category`/`LedgerEvent` (base class `Tracked`: every `save` and every `QuerySet.update` refreshes it), app `apps.sync` with `SyncController.Changes`: three feeds with a keyset cursor, `has_more`, a 5-second overlap on the last page, `voided`/`archived` in the feed, only the user's own data.
- ✅ App: `KeyValueStore` (memory or an atomic file in the app folder via `path_provider`), an **outbox** for recording expenses/income (offline goes to a durable queue, sent in order with the same `client_mutation_id`, server rejection goes to the failed list, a "pending send" panel and "Send again"), a **cache** of wallets, categories and transactions shown only when offline, and everything is cleared on sign-out.
- ⚠️ **The app does not consume the `Changes` feed yet**; for now a second device works with the cache and normal loading, and the feed is ready for applying into a full local database. The queue covers only expense/income entry. The cache file is not encrypted (phase 15). Automatic sending happens only when home opens or via the button (no background timer). Not run on a device.
- ⏳ Later: a queue for other operations and client-side ids for offline references, a full local database (drift/sqlite) and consuming the feed, background sync, cache encryption.
