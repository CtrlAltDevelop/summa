# Phase 16: Landing site

## Goal
A public interactive site that introduces Summa: a 3D "balance" (scale) scene and a live chat demo powered by the real backend parser; content and prices come from the backend API.

## Dependencies
Phases 00 and 16b.

## Scope
**In**
- `landing/`: Vite + plain JavaScript + Three.js. The `make landing` command (with an `/api` proxy to :8010) and `make landing-test`.
- A Three.js scale that tilts as income/expense is entered in the demo; Three.js loads after the text and separately (code-split); without WebGL or with `prefers-reduced-motion`, only a text indicator is shown.
- Chat demo: `POST /api/v1/assistant/demo` (no account, rate-limited, at most 200 characters); the result accumulates on a local sample account and moves the scale.
- Prices from `/billing/plans`, rates from `/assets/rates`, copy (home, FAQ, about, menus) from the CMS (`/cms/...`).

**Out**
Calculators (17), magazine and guides in the UI (only the CMS data is ready).

## Tests
vitest: formatting, balance logic, API client, CMS content mapping, demo, prices (52 tests).

## Acceptance
- [x] `vite build` succeeds; tests are green.
- [x] Content and prices come from the backend.
- [x] Reduced motion and missing WebGL are supported.

## Status
- ✅ All of the above.
- ⚠️ Not checked in a real browser against a live backend; the Three.js bundle is about 530 KB (132 gzip) and loads separately. The legal pages are drafts and need legal review.
