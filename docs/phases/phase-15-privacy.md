# Phase 15: Account, privacy and app lock

## Goal
The user protects the app with a lock (biometrics or an in-app passcode), chooses how long chat history is kept, and can **truly** delete their account. Sensitive operations (account deletion, and in 15b data export/import) run only after strong authentication.

## Dependencies
Phase 01.

## Scope
**In**
- **App lock** (on-device): an in-app passcode (4 to 8 digits) stored in secure storage with **PBKDF2-HMAC-SHA256 and a salt**; biometrics through the `Authenticator` interface (real implementation with `local_auth`); the app locks on start and after a configurable time in the background; **attempt throttling**: after 5 wrong passcodes in a row, a wait (30 seconds, doubling up to 15 minutes) that closing the app does not reset.
- **Strong-auth gate** (`StrongAuth`): if the active lock uses biometrics, it asks for biometrics; if the device has no biometrics and no passcode is enabled, it first asks the user to **enable the app passcode** and then confirms with that passcode. This is the project rule for data export/import and account deletion.
- **Backend** (new app `apps.privacy`): `PrivacyController`: `GetSettings` / `SetChatRetention` / `DeleteAccount`.
  - **Account deletion**: all of the user's data (wallets, ledger, categories, budgets, recurring items, debts, assets, portfolios, chat, card links, tickets, sessions and tokens) is **truly** erased; **only payment receipts** remain (`Payment.user` is set to null and `user_ref` is kept). The confirmation phrase `DELETE` is required.
  - **Chat retention**: `chat_retention_days` (0 = forever, up to 365); the `manage.py prune_chats` command deletes older messages.
- App: a "Privacy and security" screen (enable/disable the lock, set and change the passcode, biometrics, auto-lock delay, chat retention, delete account).

**Out**
Server-side re-confirmation with an SMS code for account deletion (for now: the on-device gate plus the confirmation phrase), encrypting the cache file and the queue (key from secure storage), hiding amounts on the lock screen and in notifications, sessions and signing out other devices, account deletion that also purges backups (deployment plan, phase 17). `local_auth` has not been tested on a real device.

## Rules and edges
- A wrong confirmation phrase = `INVALID_ARGUMENT` and nothing is deleted; deletion happens once and cannot be undone.
- `chat_retention_days` outside 0 to 365 = `INVALID_ARGUMENT`.
- Account deletion never touches any other user.
- The app passcode never goes to the server and never appears in logs.

## Tests
Backend: deletion (every user-owned model ends up empty except receipts, wrong phrase, other user untouched, tokens stop working), chat retention (setting, validation, the command removes only messages older than each user's limit), gRPC. App: passcode hash and verification, attempt throttling, lock lifecycle (start, background), strong gate (biometrics, no biometrics -> passcode, passcode enablement), settings, account deletion.

## Acceptance
- [x] With the lock on: the app locks on start and after the background period, and unlocks with the passcode or biometrics.
- [x] Without biometrics, a sensitive operation first enables the app passcode.
- [x] Account deletion erases all data and payment receipts remain.
- [x] `make check` and `make test` are green.

## Status
- ✅ Backend: the `apps.privacy` app (`UserPrivacy`, `PrivacyController`: `GetSettings`/`SetChatRetention`/`DeleteAccount`), real account deletion with a test that "no row pointing at the user remains in any registered model", payment receipts remain (`Payment.user` set to null and `user_ref` kept), the `prune_chats` command.
- ✅ App: app lock (PBKDF2-HMAC-SHA256 with a salt, verified against a standard vector; a wait after 5 wrong passcodes, doubling up to 15 minutes, that closing the app does not reset; lock on start and after the background period with a selectable delay), `confirmStrongAuth` (biometrics, or the app passcode with mandatory enablement), the "Privacy and security" screen, account deletion with the strong gate and the `DELETE` phrase that also wipes everything on the device and returns to the sign-in screen.
- ⚠️ **`local_auth` has not been tested on a real device** (only behind the `Authenticator` interface with a fake); the platform settings (`FlutterFragmentActivity`, `USE_BIOMETRIC`, `NSFaceIDUsageDescription`) were added but the Android/iOS builds were not run. Account deletion has only the on-device gate plus the phrase (server-side SMS confirmation later). The cache file and queue are still not encrypted. Hiding amounts on the lock screen/notifications was not built.
