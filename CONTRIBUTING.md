# Contributing

Thanks for helping with Summa. The canonical project rules are in
[AGENTS.md](AGENTS.md); this page is the short version.

## Ground rules

- **One phase, one feature.** Work follows `docs/07-roadmap.md` in order, and a
  phase document (`docs/08-phase-template.md`) comes before code.
- **Docs are Persian.** UI strings go through the Flutter l10n files
  (`app/lib/l10n/app_fa.arb`). Write wording yourself; do not copy it from other apps.
- **Per-user data isolation first.** Every backend call is scoped to the signed-in
  user; new endpoints need a test that another user cannot reach the data.
- **Tokens only in the UI:** colors, spacing and motion come from
  `app/lib/core/ui/tokens/`, never as literals in widgets.

## Setup

```bash
make setup
make run-lite    # backend without Docker
make macos       # app, in another terminal
```

## Before you open a pull request

```bash
make check       # lint, types, migrations, protos, format, analyze
make test        # pytest and flutter test
make landing-test
```

Changed a `.proto`? Run `make proto` and commit the generated files.

## Commits

Emoji Conventional Commits, one logical change each, for example
`📦 add(wallets): archive a wallet`. Details in
[docs/GIT_COMMIT_CONVENTIONS.md](docs/GIT_COMMIT_CONVENTIONS.md).

## Security

Do not report vulnerabilities in issues. See [SECURITY.md](SECURITY.md).
