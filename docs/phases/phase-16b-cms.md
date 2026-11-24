# Phase 16b: Landing content management

## Goal
The landing site's copy, FAQ, menus and plan prices are edited through the backend and admin, not in the site's code.

## Dependencies
Phase 00 (and 13 for plan prices).

## Scope
**In**
- Backend: the ready-made `apps.cms` app (pages, sections, typed multilingual fields, drafts and scheduled publishing, menus, preview, sitemap, JSON export/import, admin) **was switched on**: `DJANGO_CMS_ENABLED=true` and `DJANGO_CMS_LANGUAGES=fa`. The public read API is the same `GET /api/v1/cms/pages|menus|site`.
- **Initial content** (Persian copy, rewritten and our own, not copied from the reference) in `landing/content/landing.json`: the pages `home` (hero, three steps, features, privacy), `faq`, `about`, `privacy`, `terms`, and two menus. It is loaded with `manage.py cms_import landing/content/landing.json` (idempotent), and after that everything is edited from the admin. **The legal pages are explicitly marked "draft, needs legal review".**
- **Plan prices** come from phase 13's `Plan`s: `GET /api/v1/billing/plans` is public; no price lives in code or content.
- **Live rates:** `GET /api/v1/assets/rates` is public and read-only (approximate).
- **Chat demo:** `POST /api/v1/assistant/demo` runs the real parser on a sample account (two wallets and the default categories); no sign-in, nothing stored, at most 200 characters and 20 requests per minute per address.

**Out**
Writing content through the API (deliberately absent; use the admin), translation into another language (Persian only), CDN caching and the `Cache-Control` header (deployment), detecting the real client address behind a reverse proxy for demo rate limiting (a deployment decision; for now `REMOTE_ADDR`).

## Tests
Content import and reading from the API (pages, three steps, five features, four FAQ items, draft legal pages, menus, idempotency), demo (sentence -> card, named wallet, transfer, no amount, length, per-address rate limit, nothing stored), public `plans`, public `rates`.

## Acceptance
- [x] The initial content imports and is read from the API.
- [x] The demo works without an account and stores nothing.
- [x] `make check` and `make test` are green.

## Status
- ✅ All of the above. To build the site on this API, continue to phase 16.
