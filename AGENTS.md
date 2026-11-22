# AGENTS.md — Summa

Canonical instructions for any AI agent or human working in this repo.
`CLAUDE.md`, `GEMINI.md` etc. are pointers only; new rules go **here**.

## What this is

Summa: a personal-accounting app (expenses, installments/loans, assets) for a
client, deliberately different in identity and form from the
reference app taraznama.com. Docs are Persian (`docs/`): reference research plus
`docs/05-open-questions.md`, the client questions answered flow by flow starting
at section zero (what "different" means, audience, platform, revenue).

## Stack (modelled on `/Users/m.zarif/GitHub/taskforge`)

| Part | Choice |
|------|--------|
| App | Flutter, one codebase |
| Backend | Django + grpcio (gRPC), PostgreSQL, Redis, Celery |
| Landing site | Separate interactive site (Three.js) with a live chat demo (real backend parser on a sample account; a "تراز" indicator reacts); its content (prices, plans, copy, FAQ) comes from the backend API and is editable in the admin (taskforge has none) |
| SMS parsing | Share/paste text → backend Ollama small model + per-bank regex, schema-validated, amount must appear verbatim in the text; raw text not stored by default |
| Money | Per-user wallets (currency + bank/cash); balances from events; initial balance asked at wallet creation; base currency for totals; "money management" entries = paired transfer events (excluded from totals) + optional fee as a normal expense; cross-currency transfers use a user-entered rate; target market Iran only, Persian only, but multiple currencies/wallet types are kept |
| Assistant | In-app chat, private per user. The AI only analyses and replies in chat; its suggestion is a card whose "Register" button is a shortcut: the user's phone sends the normal register request with the card's content. The AI has no write access |
| Iran profile | One config for Iran: currency, Shamsi calendar, wallet types, banks/SMS templates, rate sources; editable in admin; kept as config, not as a multi-country system |
| FX rates | Celery beat refreshes every few hours on the backend; all clients read from the backend; approximate |
| Sensitive ops | Export/import and similar require biometrics; without biometrics, enable the in-app passcode first, then confirm with it |
| UI | Modern, animation-rich (app and landing); respect reduced-motion; tokens only |

Commands (root `Makefile`): `make setup`, `make run-lite` (no Docker: REST :8010 + gRPC :50051), `make macos`, `make proto` (Python and Dart stubs; add new protos to `DART_PROTOS`), `make check`, `make test`. App id `com.summa.app`; dark glass theme only; no web target for now.

Details: `docs/06-architecture.md`; phases: `docs/07-roadmap.md`. No bot. Iran and Persian only (RTL, Shamsi calendar); multiple currencies kept. Strings still go through Flutter l10n files, but extra languages are not a goal. `app/` and `backend/` exist (phase 00); `landing/` comes in phase 16.

## Rules

0. Work one phase at a time in `docs/07-roadmap.md` order; one feature per phase; a phase doc (`docs/08-phase-template.md`) comes before code.
1. Docs are Persian. Keep wording rewritten, never copied from taraznama.com.
2. Client answers go into `docs/05-open-questions.md`; run `docs-sync` after.
3. Section zero answers decide localisation (languages, currency, calendar,
   price sources, bank SMS, messenger); revisit later flows after it.
4. Commits: see `.agents/skills/commit/SKILL.md` (emoji Conventional Commits,
   `docs/GIT_COMMIT_CONVENTIONS.md`). Commit only when asked.

## Agents and skills (`.agents/`, symlinked from `.claude/`)

| Name | Kind | Use for |
|------|------|---------|
| `commit` | skill | Logical commits, push only when asked |
| `docs-sync` | agent | Keep docs consistent after decisions |
| `code-reviewer` | agent | Read-only diff review (user data isolation first) |
| `verifier` | agent | Run lint, types, proto drift, tests |
| `test-writer` | agent | Write backend and Flutter tests |
| `proto-regen` | agent | Regenerate and check gRPC stubs |

Ported and generalized from `/Users/m.zarif/GitHub/taskforge/.agents`. Not ported: `start-phase` and `phase-auditor` (need phase docs and a roadmap; add them when Summa gets `docs/phases/`).
