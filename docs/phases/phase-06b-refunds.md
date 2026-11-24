# Phase 06b: Refunds and reimbursements

## Goal
When an item is returned or money comes back, the user links it to the original expense (fully or partially, to the same wallet or another). The balance is corrected, the category budget of that expense is reduced, and the link to the original transaction is kept.

## Dependencies
Phases 02 and 03 (and 06).

## Scope
**In**
- Backend (`apps.wallets` app): an event kind `refund` (inflow to a wallet) with `refund_of` pointing to the original expense; RPC `LedgerController.Refund`.
- A refund applies only to an **expense**, with a positive amount; amount zero means "the whole remainder". The sum of active refunds of an expense cannot exceed its amount.
- The destination wallet defaults to the original expense's wallet; another wallet must be in the same currency (a refund across two currencies → error, like an unintended rate conversion).
- A refund inherits the original expense's category and "outside totals" flag; budget usage = expenses − refunds in the same range (never negative).
- List: `refund_of` on a refund event and `refunded_minor` on an expense.
- Deleting a refund is allowed. Deleting or editing an expense that has an active refund is **forbidden** (delete the refunds first). Editing a refund is forbidden (delete and record again).
- Idempotent via `client_mutation_id`.
- App: a "Refund" button on each expense, a form (optional amount, wallet, note), a "Refunded" badge in the list.

**Out**
Income refunds, refunds across currencies, refunds via sentence/SMS (refund card suggestion: later), reports (11).

## Rules and edges
- Someone else's or voided expense = `NOT_FOUND`; a non-expense event (income/transfer/refund) = `INVALID_ARGUMENT`.
- A negative amount, more than the remainder, an archived wallet, a different currency, a long note = `INVALID_ARGUMENT`.

## Tests
Service: full and partial refund and balance, remainder and budget, another wallet, amount cap, different currency, non-expense, isolation, idempotency, deleting a refund, deleting/editing an expense with a refund, editing a refund. Real gRPC. App: refund form widget.

## Acceptance
- [x] A partial refund raises the balance by that amount and reduces the remainder.
- [x] Category budget usage drops with a refund.
- [x] You cannot refund more than the expense amount.
- [x] `make check` and `make test` are green.

## Status
- ✅ Backend: the `refund` kind with `refund_of`, the `Refund` RPC (full with amount zero or partial, another wallet in the same currency), amount cap with a row lock, budget usage reduced (minimum zero), `refunded_minor` in the list, deleting/editing an expense with a refund forbidden.
- ✅ App: "Refund" button on an expense, form, "Refunded" badge, a message when deleting an expense that has a refund is rejected.
- ⚠️ Not yet run on a device/simulator. Refund via sentence/SMS (a suggested refund card) is not built.
