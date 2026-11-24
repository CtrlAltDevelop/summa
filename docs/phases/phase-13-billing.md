# Phase 13: Subscription and payment

## Goal
The user gets a trial, buys a plan, and when the subscription ends their account becomes **read-only** (data is never deleted). All business decisions are **configuration, not code**: since the client's question 6 (gateway, number of plans, trial length, auto-renewal, invoice) is still unanswered, this phase builds a ready engine and sets no price or plan on its own.

## Dependencies
Phase 01.

## Scope
**In**
- Backend (new app `apps.billing`): `Plan` (code, name, description, price in Toman, duration in days, active/inactive, order; **editable from the admin**, no plan is pre-created), `Subscription` (one per user: `trial`/`active`/`expired`, end), `Payment` (pending/paid/failed, amount, gateway reference). gRPC service `BillingController`: `Plans` / `Status` / `StartTrial` / `Checkout` / `Verify`.
- **Trial:** once per user, `DJANGO_BILLING_TRIAL_DAYS` days (default 14; 0 means no trial), no card.
- **Purchase:** `Checkout(plan_code)` creates a pending payment and gets a payment URL from a **swappable gateway** (`PaymentProvider`); `Verify(reference)` verifies **server-side** with the gateway (the client's claim is not trusted), extends the subscription (from `max(now, current end)` by the plan duration; a purchase on an active subscription is added to its end) and is **idempotent** (verifying twice does not extend twice). Only the user's **own** payments (`NOT_FOUND` for others).
- **Read-only mode** (`DJANGO_BILLING_ENFORCED`, default off): when on and the subscription is neither trial nor active, every **write** RPC in the feature apps is rejected with `PERMISSION_DENIED`; reads (`List`, `Get`, reports, export, sync feed…), sign-in/sign-out and `BillingController` itself stay open. Implementation: one **central guard** in the `action` decorator (not editing each RPC).
- Admin: `Plan`, `Subscription` and `Payment` visible; `Plan` editable.
- App: a "Subscription" page (status and days remaining, start trial, plan list and purchase, "Check payment"), and a "read-only" banner on home when `can_write` is false.

**Out**
**A real gateway** (Zarinpal or whatever the client says; needs a merchant account and a browser return via deep link and `url_launcher`); the default `FakeProvider` is for development and tests only and **must not be in production**, auto-renewal, discount codes, invoices and VAT, refunds, different features per plan (loan limits and so on), referral.

## Rules and edges
- Unknown plan = `NOT_FOUND`; inactive plan = `INVALID_ARGUMENT`; a second trial, or a trial when disabled = `INVALID_ARGUMENT`.
- `Verify` on someone else's payment = `NOT_FOUND`; a payment that failed at the gateway = payment `failed` and the subscription untouched.
- A subscription is `expired` only once `ends_at` has passed; data is never deleted.
- With `BILLING_ENFORCED` off everything works as before.

## Tests
Trial (once, disabled), statuses and days remaining, purchase and verify and extension on active and expired, idempotency, failed payment, invalid plans, isolation, the guard (on/off, write vs read, expired vs active, exempt RPCs), real gRPC, app.

## Acceptance
- [x] The trial is granted once and after it ends the account becomes read-only (with the lock on).
- [x] Buying a plan extends the subscription correctly and verifying again has no effect.
- [x] Reads, reports and export stay open for an expired account.
- [x] `make check` and `make test` are green.

## Implementation status
- ✅ Backend: app `apps.billing` (`Plan`, `Subscription`, `Payment`), one-time trial, `Checkout`/`Verify` with server-side gateway verification, extension from `max(now, current end)` and idempotent, `BillingController` over gRPC, admin, and the **central read-only guard** (`register_call_guard` in the `action` decorator; with `DJANGO_BILLING_ENFORCED` on, write RPCs for an expired account become `PERMISSION_DENIED` while reads, sign-in and billing itself stay open).
- ✅ App: the "Subscription" page (status, trial, plans, purchase, check payment) and a "read-only" banner on home.
- ⚠️ **Business decisions are still open** (question 6): no plan or price has been created (they are created from the admin), the trial defaults to 14 days and `ENFORCED` is off. **There is no real gateway**: `FakeProvider` is for development only and always confirms the payment (**must not be in production**). Opening the gateway URL from the app and returning via deep link needs `url_launcher` and the chosen gateway; for now the URL is shown and the user taps "Check payment". The app has not been run on a device.
- ⏳ Later: a real gateway, auto-renewal, discount codes, invoices, refunds, different features per plan.
