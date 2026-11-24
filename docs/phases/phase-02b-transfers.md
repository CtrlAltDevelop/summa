# Phase 02b: Money management (transfers between wallets)

## Goal
The user moves money between two of their own wallets (bank to bank, cash to bank), with an optional fee and, for different currencies, a rate they enter themselves.

## Dependencies
Phases 01b and 02.

## Scope
**In**
- Backend (`apps.wallets` app): RPC `LedgerController.Transfer`; each transfer is two paired events sharing one `transfer_id`: `transfer_out` from the source and `transfer_in` into the destination. A fee, if any, is a normal `expense` event on the source wallet with the same `transfer_id` (it counts in the "expense" total; the transfer itself does not).
- Same-currency transfer: destination amount = source amount. Cross-currency transfer: the user writes the **rate** (units of the destination currency per one unit of the source currency, as a decimal string); the destination amount is computed with Decimal and half-up rounding to the destination currency's decimals (no float). The rate stays on the event.
- **Deleting** either leg of a transfer voids all its legs (the pair and the fee). Editing a transfer leg is not accepted.
- The ledger list also shows transfers.
- App: transfer form (source, destination, amount, rate only when currencies differ, optional fee, note).

**Out**
Live rates (phase 09), editing a transfer, date picking.

## Rules and edges
- Source = destination, archived wallet, amount <= 0, negative fee = `INVALID_ARGUMENT`. Another user's wallet = `NOT_FOUND`.
- Different currencies without a positive rate = `INVALID_ARGUMENT`; the same currency with a rate = `INVALID_ARGUMENT`.
- A destination amount that rounds to zero = `INVALID_ARGUMENT`.
- Resubmitting the same `client_mutation_id` returns the same transfer and does not create it again.

## Tests
Service: effect on both balances, fee, rate and rounding, idempotency, invalid inputs, isolation, deleting all legs, editing forbidden. Real gRPC. App: widget tests for the same-currency and cross-currency form, list, delete.

## Acceptance
- [x] A transfer lowers the source balance and raises the destination's.
- [x] The fee is deducted from the source only.
- [x] Currency conversion with the user's rate and no float.
- [x] Deleting a transfer voids all its legs.
- [x] `make check` and `make test` green.

## Status
- ✅ Backend: `LedgerController.Transfer`; two paired events (`transfer_out`/`transfer_in`) and the fee as an expense on the source; user rate with Decimal and half-up rounding; deleting one leg voids all legs; editing a transfer leg is forbidden.
- ✅ App: transfer form (rate only for different currencies), list with transfer legs, delete.
- ⚠️ Not yet run on a device/simulator.
- ⏳ Later: "outside the totals" for transfers in reports (11), suggested rate from live rates (09), date picking.
