# Phase 01: Login

## Goal
The user signs in with a mobile number and an SMS code (an account is created automatically for a new number), gives their name, and stays in the app.

## Dependencies
Phase 00.

## Scope
**In**
- Backend: the starter's `sms_code` login (no separate sign-up: a new number creates the account at code verification), `rotation` token mode (access + refresh with reuse detection), SMS filter behind a swappable backend (dev: console; an Iranian provider later).
- **Iranian numbers:** `09123456789`, `9123456789`, `+98 912 345 6789`, `0098…`, and Persian/Arabic digits all normalize to `+989123456789`; foreign numbers with `+` stay accepted.
- Display name: after login, if empty, the app asks and saves it with `AccountService.Update`.
- App: number screen, code screen (6 digits, resend countdown, auto-submit after the last digit), name screen, token kept in the device **secure storage**, automatic token refresh, sign-out, session kept between runs.
- Limits (configuration, not new code): code valid 5 minutes; 5 guesses; resend >= 60 seconds; at most 5 codes per hour per number.

**Out**
Optional password, sessions and device list, app lock and biometrics (phase 15), a real SMS provider (depends on the client's choice), Google sign-in and similar.

## Interfaces
gRPC: `SmsCodeController.LoginStart/LoginVerify/Logout`, `AccountService.Me/UpdateProfile`, and token refresh from the `rotation`-mode service. Screens: login, code, name.

## Rules and edges
- The start response is identical for a number with an account and without one (accounts cannot be enumerated).
- Invalid number: a clear Persian message, no SMS sent.
- Wrong code: attempt counter; past the limit the challenge is voided and the user must request a new code.
- Access expiry → automatic refresh; an invalid or reused refresh → sign-out and back to the login screen.
- No internet: a clear error, no endless spinner.

## Security and privacy
- Tokens live only in Keychain/Keystore (secure storage), never in logs or `SharedPreferences`.
- The SMS code appears in the server log only with the console backend (development only); production system checks warn about it.
- The number is masked in logs.

## Tests
Backend: number normalization (Iranian forms, Persian digits, foreign, invalid), the full login flow with an in-memory SMS backend (new and existing number), wrong guess, attempts exhausted.
App: unit tests for token storage and refresh, widget tests for all three screens (empty/error/loading states), full flow with a fake client.

## Acceptance
- [x] An Iranian number in any common form is accepted and stored the same way.
- [x] New number: code → name → home; existing number: code → home.
- [x] The session survives closing and reopening the app; an expired token refreshes automatically.
- [x] Sign-out revokes the token and clears storage.
- [x] The start response is identical for a number with an account and without one.
- [x] "Other user" test: every profile read belongs only to the authenticated user.
- [x] `make check` and `make test` green; new-code coverage >= 80%.

## Status
- ✅ Backend: `sms_code` login (rotation token mode); an Iranian number normalizes in any form and with Persian/Arabic digits; settings: 6-digit code, 5 minutes, 5 guesses, resend >= 60 seconds, 5 codes per hour.
- ✅ **Starter gRPC bug fix:** wrong code, expired code, rate limiting and invalid number were turning into `UNKNOWN` on the gRPC path; they now map to `INVALID_ARGUMENT`/`NOT_FOUND`/`RESOURCE_EXHAUSTED` through `register_grpc_error` (tested).
- ✅ App: number, code, name and home (temporary) screens, `AuthGate`, secure token storage, automatic refresh with a single retry, sign-out; 35 tests.
- ✅ End-to-end check against a real gRPC server from Dart: local number → code → token → name → refresh → sign-out (after sign-out the token is rejected).
- ⚠️ Not yet run on a device/simulator (Keychain secure storage and the real appearance not seen).
- ⏳ Real SMS provider: console backend only (the code appears in the dev server log). Once a provider is chosen, one class with `send(destination, body)` is added.
- Note: I did not build taraznama's "progressive back-off after a wrong code"; the starter has only an attempt counter + cooldown + hourly cap, which I judged sufficient.
