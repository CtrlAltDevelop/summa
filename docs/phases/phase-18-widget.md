# Phase 18: Phone home-screen widget

## Goal
Show a small summary (net worth and this month's spending) on the phone's home screen without opening the app.

## Dependencies
Phase 02.

## Scope decision
- **Data:** the widget needs no new data; it is read in the app from the existing RPCs (`NetWorth` and the month report), and the app writes the latest value for the widget. The widget does not talk to the backend directly (no token is kept in the widget).
- **Privacy:** the widget does not show amounts on the lock screen unless the user turns that on in settings (default off), and it is compatible with the app lock.
- **Native code:** WidgetKit (iOS) and App Widget (Android) can only be verified on a device; the `home_widget` package is suggested.

**Outside this delivery:** no native code or new dependency was added, because it cannot be built and tested in this environment.

## Acceptance
- [x] Scope, data source and privacy were decided and recorded.
- [ ] Native implementation and on-device testing.

## Status
- 📄 Decision document only. ⏳ Implementation in the first session with access to a device/simulator.
