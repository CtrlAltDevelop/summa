# Phase 01b: Wallets

## Goal
The user creates wallets (cash, bank account, credit card, ...) with any currency and an opening balance, and on the home screen sees each wallet's balance and a total per currency (the "ledger box").

## Dependencies
Phase 01.

## Scope
**In**
- Backend: the `apps.wallets` app with `Wallet` and `LedgerEvent` models; gRPC service `WalletsController` with `Create` / `List` / `Archive`.
- Balance is **not stored**; it is the sum of ledger events. The opening balance is an `opening_balance` event (zero → no event). Only credit card and BNPL wallets may start negative (debt).
- Money = integer in the smallest unit (`int64`); the currencies in the Iran profile today (`apps/wallets/profile.py`): Toman, Rial, USD, EUR, AED, TRY, USDT; each currency's decimals live in the same table.
- Types: cash, bank, credit card, BNPL, gift card, crypto, gold (gold and crypto gain meaning with phase 09).
- `client_mutation_id`, unique per user: resubmitting the same form does not create a second wallet.
- Archiving a wallet (not deleting): it leaves the totals and stays in the list with a marker.
- App: a total card per currency, the wallet list, a create form (name, type, currency, optional bank, opening balance with Persian digits and thousands separator).

**Out**
Totals in the base currency (needs rates, phase 09), recording expense/income (02), transfers between wallets (02b), renaming a wallet, an archive button in the app (the RPC is ready).

## Rules and edges
- Every read and write is filtered by the authenticated user; another user's wallet id or an unknown one = `NOT_FOUND`.
- Unknown currency or type, an empty name or one over 60 characters, a bank over 40 characters = `INVALID_ARGUMENT`.
- Totals count active wallets only.

## Tests
Backend: service (opening balance, zero, debt, idempotency, invalid input, user isolation, totals and archive) and real gRPC (create/list, other user, invalid currency, no token, value above 32 bits).
App: `parseMinor`/`formatMinor`; widget: empty state, create with a balance, empty name, negative for a bank wallet, server error.

## Acceptance
- [x] Create a wallet with a currency and an opening balance; balance comes from events.
- [x] Several wallets in one currency, and different currencies, with a separate total per currency.
- [x] "Other user" test for list and archive.
- [x] Large (Rial) amounts stay intact in `int64`.
- [x] `make check` green.

## Status
- ✅ Backend and app implemented; the app has not yet been run on a device/simulator.
- ⏳ Later: totals in the base currency (09), archive in the UI, wallet editing.
