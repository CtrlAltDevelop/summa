# Phase 10: Net worth and baskets

## Goal
The user sees one number: net worth = wallet balances + asset value - remaining debt, in **Toman** and at the same time in dollars and grams of gold. They can also create a **target basket** (for example "House down payment") whose progress is computed from the value of the wallets and assets linked to it.

## Dependencies
Phases 01b, 08 and 09.

## Scope
**In**
- Backend (new app `apps.networth`): `Basket` and `BasketItem`; gRPC service `NetWorthController`: `Get` / `ListBaskets` / `CreateBasket` / `DeleteBasket`.
- **Net worth** (`Get`): the balance of each **non-archived** wallet (converting each currency to Toman with the phase 09 rates), the value of assets whose price is known, and the remaining balance of open debts (converted to Toman). Output: the total and three components, the **dollar** and **18-karat gold gram** equivalents (empty if there is no rate), `stale` if any rate used is stale, the list of **currencies without a rate** (set aside and reported) and the count of unpriced assets.
- The balance of each currency is summed first and converted once (rounded half up; the error does not come from adding up rounded values).
- **Target basket:** a name (1 to 60 characters), a target amount (Toman, positive) and items (the user's own wallets and assets). Progress = value of the items in Toman; `percent` = floor(value x 100 / target) (can exceed 100). An item can be in several baskets, but not twice in the same basket. At most 20 baskets per user.
- App: net worth card at the top of home (Toman, dollars, gold grams, warnings, component details), baskets with a progress bar, basket creation form with multi-select of items.

**Out**
Editing a basket (delete and recreate), target date and monthly saving suggestion, net worth history chart (needs daily storage), stocks and funds (with the stock exchange phase).

## Rules and edges
- Invalid name or target, more than 20 baskets, duplicate item or invalid type = `INVALID_ARGUMENT`; someone else's wallet or asset = `NOT_FOUND`; someone else's basket = `NOT_FOUND`.
- An archived wallet is not in net worth; if it is in a basket, its value counts as zero in that basket.
- A currency with no rate is left out of the total and appears in `unconverted`.

## Tests
Combining components (rial/dollar wallet, asset, debt), no rate, stale, archived, dollar and gold gram, rounding, basket (progress, over 100%, validation, the 20 limit, isolation), real gRPC, app.

## Acceptance
- [x] Net worth = wallets + assets - debts in Toman, correct, with currencies without a rate reported.
- [x] The dollar and gold gram equivalents are built from the available rates.
- [x] Basket progress is computed from the real value of the items.
- [x] `make check` and `make test` are green.

## Implementation status
- ✅ Backend: app `apps.networth` with `NetWorthController` (`Get`, `ListBaskets`, `CreateBasket`, `DeleteBasket`). Net worth = non-archived wallets + value of priced assets - remaining debt, each currency summed first then converted once to Toman, dollar and gold gram equivalents, `stale`, currencies without a rate and unpriced assets are reported. Basket: progress from the value of items, over 100% possible, limit of 20 baskets, someone else's item is `NOT_FOUND`.
- ✅ App: net worth card above the wallets, baskets with a progress bar, basket creation form with multi-select (`MultiChoices`). The card and baskets are re-read when wallets, assets or debts change.
- ⚠️ No net worth history (chart) because it is not stored daily. The app has not been run on a device.
- ⏳ Later: editing a basket, target date, chart, stocks and funds.
