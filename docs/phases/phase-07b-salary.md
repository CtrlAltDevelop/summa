# Phase 07b: Salary and reminder

## Goal
The user defines their payday (for example the 16th of each Shamsi month); after that day the app asks "did you get it?". If "not yet", it asks again tomorrow. If the money arrives earlier, one tap on "I got this month's salary" records it.

## Dependencies
Phases 02 and 07 (salary is a recurring income; this phase builds the "reminder" behavior on top of it).

## Scope
**In**
- Backend (`apps.recurring` app): a new `postpone` action in `Resolve` ("not yet"): the occurrence moves one day forward and is asked again tomorrow; a new RPC `SettleNow` ("got it/paid" for the next occurrence, even before the 3-day window).
- **Recording date:** confirming a future occurrence (an early receipt) is recorded with **today's** date; an overdue or same-day occurrence keeps its own date.
- `postpone` only for an unanswered occurrence; if the next day is already an occurrence of the same definition, `INVALID_ARGUMENT`.
- `SettleNow`: takes the earliest open occurrence, otherwise creates and confirms the definition's next occurrence on the spot; a variable amount is required; someone else's occurrence is `NOT_FOUND`.
- App: a "Not yet" button on the due card, an "I got this month's salary" (income) / "Paid this month" (expense) button on each definition, a category picker in the definition form (for salary: the "حقوق" (salary) category), the "Did you get it?" text for an income card.

**Out**
Push notification at a set time (07c/15), reminders with a limited number of repeats, defining several salaries in one month.

## Tests
`postpone` (asks again tomorrow, conflict, already answered), early recording date versus overdue occurrence, `SettleNow` (with and without an open occurrence, variable amount, isolation), real gRPC, app (buttons and category).

## Acceptance
- [x] "Not yet" moves the occurrence to tomorrow and it comes back as due tomorrow.
- [x] "I got this month's salary" records the income with today's date.
- [x] `make check` and `make test` are green.

## Status
- ✅ Backend: the `postpone` action ("not yet" → asked again tomorrow, rejecting a clash with the next occurrence), recording date = the minimum of "due date" and "today", `SettleNow`.
- ✅ App: the "Not yet" button, the "Did you get it?" text and a "Got it" button for income, "I got this month's salary"/"Paid this month" on a definition (asks for a variable amount), category picker in the definition form.
- ⚠️ No push notification, so the "reminder" is the in-app card (07c/15). The app has not been run on a device.
