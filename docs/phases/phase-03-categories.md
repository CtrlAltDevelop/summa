# Phase 03: Categories and budgets

## Goal
Every expense and income has a category (Iran defaults or a custom one), and a monthly budget can be set per expense category; the app shows when spending nears the budget.

## Dependencies
Phase 02.

## Scope
**In**
- Backend (`apps.wallets` app): `Category` and `Budget` models, a `category` field on `LedgerEvent`; gRPC service `CategoryController`: `List` / `Create` / `Delete` / `SetBudget` / `BudgetStatus`.
- **Default categories** (Iran profile, `profile.py`) are created for each user on their first `List`: expense (خوراک و سوپرمارکت (food and groceries), رستوران و کافه (restaurants and cafes), رفت‌وآمد (transport), قبض و شارژ (bills and utilities), اجاره و خانه (rent and housing), اقساط (installments), سلامت (health), آموزش (education), تفریح و اشتراک (leisure and subscriptions), خرید و پوشاک (shopping and clothing), هدیه و مهمانی (gifts and parties), کارمزد بانکی (bank fees), سایر (other)) and income (حقوق (salary), پروژه (project), هدیه (gift), سود (interest), فروش دارایی (asset sale), سایر (other)). "سایر" (Other) of each kind cannot be deleted.
- Custom category: name (at most 40 characters, unique per user and kind), kind expense or income.
- **Deleting a category:** its events move to "سایر" of the same kind and its budget is removed.
- Recording and editing an expense/income takes an optional `category_id`; the category must belong to the same user and match the transaction's kind. Transfers and their fees have no category.
- **Monthly budget:** one budget per expense category, with a currency and an amount. `SetBudget` with amount zero removes the budget. `BudgetStatus(from, to)` returns, for the range the **app** supplies (a Shamsi month, converted to UTC), the total expenses of that category in the same currency; the server knows nothing about the calendar.
- App: category picker in the record form, category name in the list, a categories screen (create, delete, set budget), and budget usage bars on the home screen with warning colors (yellow from 80%, red from 100%).

**Out**
Category icon and color (later), renaming a category, multi-currency budgets and rate conversion (09), category suggestions (04/05), budget warning notifications, reports (11).

## Rules and edges
- Someone else's category or wallet = `NOT_FOUND`. Empty/long/duplicate name, invalid kind, unknown currency, negative budget, category of the wrong kind = `INVALID_ARGUMENT`.
- Budgets exist only for expense categories; deleting "سایر" is forbidden.
- The `BudgetStatus` range must have `from < to` and carry a time zone.

## Tests
Service: default creation (once), create/delete category and moving events to "سایر", category on record/edit, kind mismatch, isolation, budget and usage (currency, range, voided event, transfers not counted). Real gRPC. App: record form widget with category, categories screen, budget bar and warning color.

## Acceptance
- [x] A new user sees the default categories.
- [x] A transaction gets a category and it is shown in the list.
- [x] Deleting a category moves its transactions to "سایر".
- [x] Monthly budget and usage (Shamsi month) are computed and displayed correctly.
- [x] `make check` and `make test` are green.

## Status
- ✅ Backend: `Category`/`Budget`, Iran default categories (once per user), `CategoryController` (List/Create/Delete/SetBudget/BudgetStatus), category on record and edit, delete category → "سایر", budget usage from expense events in the same currency within the range the app supplies.
- ✅ App: category picker (default "سایر"), category name in the list, categories screen, budget form, usage bar with warning color; the Shamsi month range is computed in the app.
- ⚠️ Not yet run on a device/simulator. Changing a transaction's category is not in the app UI (the edit RPC is ready).
- ⏳ Later: category icon and color, renaming categories, budget warning notification, multi-currency budgets (09).
