# Phase 08: Loans and installments

## Goal
The user defines a loan, an installment purchase or a personal debt with the amount of each installment, the count and the date of the first installment; an installment schedule is built, upcoming and overdue due dates are visible, and "Paid" records a normal expense.

## Dependencies
Phase 02 (and 03 for the category).

## Scope
**In**
- Backend (new app `apps.debts`): `Debt` and `Installment`; gRPC service `DebtController`: `Create` / `List` / `Pay` / `Unpay` / `Delete`.
- **Debt types:** `bank_loan` (bank loan), `installment_purchase` (installment purchase), `personal` (personal debt).
- **Installment schedule:** `count` equal installments of `installment_minor`; the first due date is `first_due` and the rest follow monthly on the **same day of the Shamsi month** (short month goes to the last day of the month, as in phase 07). `principal_minor` is optional and informational only (a loan with interest: the sum of the installments exceeds the principal).
- The debt currency is fixed; a default payment wallet and a category (for example "Installments") are optional.
- **Payment** (`Pay`): a normal expense on the chosen wallet (or the debt's default) for the installment amount (or a custom amount) at the current moment; a fixed `client_mutation_id` per installment means paying twice creates only one expense; paying the last installment closes the debt.
- **Unpay** (`Unpay`): deletes the recorded expense (rejected if the expense has a refund) and the installment is reopened.
- `List`: each debt with its installments, `remaining_minor` (sum of open installments), `paid_count`, `next_due`; each installment has `overdue` (due date passed in Tehran time and unpaid).
- App: debt list with remaining balance and next due date, installment schedule page with "Paid" and "Unpay", definition form.

**Out**
Push notifications (07c/15; for now only an "overdue" badge in the app), editing a debt (delete and recreate), unequal installments, interest and rate calculation, cheques (open client question), deducting loans from net worth (phase 10 uses `remaining_minor`).

## Rules and edges
- Title 1 to 60 characters; installment amount positive; count 1 to 120; valid type and currency; the wallet must belong to the user and match the currency; the category must be an expense category and belong to the user = `INVALID_ARGUMENT`/`NOT_FOUND`.
- Paying an already paid installment, an unspecified wallet (neither in the request nor on the debt), an archived wallet, a different currency = `INVALID_ARGUMENT`. Someone else's debt or installment = `NOT_FOUND`.
- Creating again with the same `client_mutation_id` returns the same debt.

## Tests
Installment schedule (short Shamsi month, Esfand, 120 installments), validation, payment (default/custom wallet, custom amount, repeat, closing), unpay, `overdue`, `remaining_minor`, isolation, delete, real gRPC, app.

## Acceptance
- [x] A 12-installment loan produces 12 correct monthly due dates.
- [x] "Paid" records a normal expense and reduces the balance; unpay restores it.
- [x] The remaining balance and next installment are computed correctly.
- [x] `make check` and `make test` are green.

## Implementation status
- ✅ Backend: app `apps.debts` (`Debt`, `Installment`), monthly installment schedule on the same day of the Shamsi month (shorter month goes to the last day; Esfand and the new year were tested), `Pay` (normal expense with a fixed id per attempt), `Unpay` (deletes the expense and reopens the installment; also works if the expense was deleted manually), `overdue`, `remaining_minor`, `next_due`, closing with the last installment. DebtController over gRPC.
- ✅ App: debt list with remaining balance and overdue marker, installment schedule page (Paid, Unpay, wallet picker when the debt has no wallet), definition form with a Shamsi date (`parseJalaliDate`).
- ⚠️ No push notifications; installment due dates are not yet counted in the daily summary (07c). The app has not been run on a device.
- ⏳ Later: editing a debt, unequal installments, cheques (open client question), deducting loans from net worth (phase 10 uses `remaining_minor`).
