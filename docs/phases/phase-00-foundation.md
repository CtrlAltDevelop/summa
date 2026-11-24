# Phase 00: Foundation

## Goal
A ready-to-work repository that every later phase builds on: a gRPC backend, a Flutter app with a design system and motion, CI, and an end-to-end "hello" demo.

## Dependencies
None.

## Scope
**In**
- Repository skeleton per `docs/06-architecture.md`: `backend/`, `app/`, `deploy/` (landing comes in phase 16).
- Backend: Django + grpcio (from `django-ninja-starter` if suitable, with the extra apps switched off); PostgreSQL, Redis, Celery in docker compose; environment settings; a sample `Ping` service; `.proto` layout and stub generation (Python and Dart).
- App: Flutter, Riverpod + freezed, navigation, Persian l10n and RTL, Shamsi calendar, Persian digits, dark glass theme (the only theme).
- **Design system:** tokens (colour, type, spacing, radius, motion), base `Sm*` widgets, icons, animation rules (duration/curve, reduced motion), a gallery page (`/debug/gallery`), **rule:** raw colour/radius/icon values outside the tokens are forbidden and enforced by a test.
- Visual identity: 2-3 sample directions (light/airy, soft/glass, ...) with an appearance entirely different from taraznama; final pick before the phase ends.
- CI: ruff, mypy, `makemigrations --check`, `buf lint`, stubs up to date, pytest with coverage, `dart format`, `flutter analyze`, `flutter test`.
- `Makefile` with `setup`, `dev`, `serve`, `grpc`, `proto`, `check`, `test`.
- End-to-end demo: the app calls `Liveness` on the gRPC backend and shows the result with an animation.

**Out**
Login, wallets, every other feature.

## Interfaces
`HealthController.Liveness` (present in the starter). Settings: `.env.example`.

## Rules and edges
- No secrets in the repo; `.env` is in gitignore.
- gRPC-Web for the web (proxy) or web later; if the web is not the first target, desktop/mobile take priority.
- Numbers and dates always go through the shared formatting layer (Persian/Shamsi); tested.

## Security and privacy
Logs carry no user data; dependencies are pinned; no telemetry.

## Tests
Unit for number/date formatting and tokens; widget test for the gallery; widget test for the health screen with a fake service; the raw-value ban test.

## Acceptance
- [ ] `make setup && make run-lite` comes up on a clean machine.
- [ ] The app calls `Liveness` and shows the response.
- [ ] `make check` and `make test` green; new-code coverage >= 80%.
- [ ] CI green.
- [ ] The gallery shows every widget in RTL with the dark glass theme.
- [ ] The raw-value ban test passes with no exceptions.
- [ ] The visual identity (dark glass, client's choice) is recorded in `docs/brand.md`.

## Status
- ✅ Backend skeleton (from the starter; the shop/wallet/club/support/cms/notifications apps switched off), Flutter app (Android/iOS/macOS; id `com.summa.app`), tokens and `Sm*` widgets, `/debug/gallery`, Persian l10n, Shamsi number/date formatting, health demo, raw-value ban test, Makefile, compose, CI.
- ⏳ Outside this run: bundled Persian font (system font for now), `docs/brand.md`, web (decision: not for now), running CI on GitHub (no remote).
