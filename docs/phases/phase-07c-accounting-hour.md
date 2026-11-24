# Phase 07c: Accounting hour

## Goal
The user sets a daily hour; from that hour on, the app reminds them to settle today's accounts: occurrences waiting for an answer, transactions without a category, or that nothing has been recorded today.

## Dependencies
Phases 02, 03 and 07.

## Scope
**In**
- Backend (`apps.assistant` app): a `UserPreference` model (accounting hour, or empty); RPCs `SetAccountingHour` and `Digest` on `AssistantController`.
- **Daily digest** (`Digest`) in Tehran time: the number of today's transactions, today's transactions without a category ("سایر" (Other) or uncategorized), occurrences waiting for an answer, low-balance warnings, the configured hour and `should_remind`.
- `should_remind` is true if an hour is set, the current hour (Tehran) is >= that hour, and (an occurrence is waiting, or a transaction has no category, or nothing has been recorded today).
- Hour `-1` turns the reminder off; the valid range is 0 to 23.
- App: a reminder card on the home screen (when `should_remind`), an hour picker, and a `ReminderScheduler` interface for a daily local notification.

**Out**
A real operating-system notification (needs the native `flutter_local_notifications` plugin or push and device setup, which cannot be verified here). The default `ReminderScheduler` implementation is a no-op and the place to plug in the plugin is clear; until then the reminder is seen only while the app is open. (Phase 15: privacy and notification settings.)

## Tests
Setting and turning off the hour and validation, digest counts with a fixed clock (Tehran midnight boundary), `should_remind` in different cases, isolation, real gRPC, app (card, hour, scheduler).

## Acceptance
- [x] With hour 20 and an open occurrence, `should_remind` is true from 20:00 Tehran time and not before.
- [x] A turned-off hour or another user never gets a reminder.
- [x] `make check` and `make test` are green.

## Status
- ✅ Backend: `UserPreference.accounting_hour`, `SetAccountingHour` (0 to 23 or -1 to turn off), `Digest` (today's count in Tehran time with the midnight boundary, uncategorized, waiting occurrence, balance warning, `should_remind`).
- ✅ App: the "حساب‌وکتاب امروز" (today's accounts) card, hour picker, the `ReminderScheduler` interface (no-op by default) called when the hour is saved.
- ⚠️ **A real operating-system notification is not built**; the card is seen only while the app is open. Wiring the native plugin is phase 15's job (or whenever it can be tested on a device).
