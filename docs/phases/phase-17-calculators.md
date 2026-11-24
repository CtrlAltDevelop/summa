# Phase 17: Public calculators

## Goal
Sign-up-free tools on the landing site: an installment calculator, a savings goal, and a currency/gold converter using the backend's public rates.

## Dependencies
Phase 16.

## Scope
**In**
- `landing/src/calculators.js`: pure functions `loanPayment` (equal installments; zero interest = equal split), `monthsToGoal` (months needed, with an optional annual return), `convert` (via the Toman price). Invalid input = `null`.
- `landing/src/tools.js`: three small forms below the price table; input accepts Persian digits too; the converter shows only symbols with a known price and drops those without a rate.

**Out**
Saving results, installments with due dates, a link to registering in the app.

## Tests
vitest: formulas and invalid input, form rendering, Persian digits, dropping converter entries without a rate (15 new tests).

## Acceptance
- [x] The result updates immediately as you type; bad input shows a message.
- [x] `vite build` and tests are green.

## Status
- ✅ The three tools and their tests.
- ⚠️ Not seen in a real browser. The installment calculator is a simple equal-installments model, not any specific bank contract (fees, daily compound interest, etc.). Results are approximate.
