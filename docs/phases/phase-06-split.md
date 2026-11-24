# Phase 06: Split and outside totals

## Goal
Split one expense across several categories and put part of it "outside the totals" (for example, other people's share of a group dinner): the money leaves the wallet but does not count in the user's own budgets and expense reports.

## Dependencies
Phases 02 and 03.

## Scope
**In**
- Backend (`apps.wallets` app): `outside_totals` and `split_id` fields on `LedgerEvent`; a new RPC `LedgerController.RecordSplit`; `Record` and `Edit` accept the `outside_totals` flag.
- **Split:** 2 to 10 parts, each with a category (optional), a positive amount and an "outside totals" flag. Each part is one expense event and all share a `split_id`; the sum of the parts is deducted from the wallet. Resending the same `client_mutation_id` returns the same split.
- **Outside totals:** changes the wallet balance as usual, but is excluded from budget usage and does not appear in expense reports (phase 11).
- Deleting one part voids all parts of that split; editing a single part is not accepted (delete and record again). Editing a standalone event may change the flag.
- The ledger list also returns `outside_totals` and `split_id`.
- App: an "outside totals" option in the record form, a "Split expense" form, an indicator in the list.

**Out**
Editing split parts, others' share as debt/receivable (debt ledger), date picking.

## Rules and edges
- Splitting is for expenses only. The category must be an expense category belonging to the user (someone else's category = `NOT_FOUND`).
- A zero or negative part, fewer than 2 or more than 10 parts, an archived wallet, a long note = `INVALID_ARGUMENT`.
- Income and transfers have no "outside totals" flag (ignored/rejected: income with the flag = `INVALID_ARGUMENT`).

## Tests
Service: split and its effect on balance, budget with an outside part, flag on record and edit, invalid inputs, idempotency, group delete, part editing forbidden, isolation. Real gRPC. App: split form widget and the flag.

## Acceptance
- [x] A three-part split reduces the balance by the total and each part has its own category.
- [x] An "outside totals" part does not count toward a budget but is deducted from the balance.
- [x] Deleting one part voids the whole split.
- [x] `make check` and `make test` are green.

## Status
- ✅ Backend: `outside_totals` and `split_id` on the event, `RecordSplit` (2 to 10 parts, idempotent), the flag on `Record`/`Edit` (`optional` in proto: unset = unchanged), budgets do not count outside parts, deleting one part voids the whole split, part editing forbidden.
- ✅ App: "Split expense" form, "outside totals" option in the record form (expenses only), indicators in the list.
- ⚠️ Not yet run on a device/simulator.
- ⏳ Later: a debt ledger for others' share, reports that honor the flag (11).
