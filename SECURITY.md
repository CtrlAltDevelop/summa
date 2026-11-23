# Security policy

Summa handles personal financial data, so please report vulnerabilities
privately and do not open a public issue.

## Reporting

Use GitHub's private reporting: **Security → Report a vulnerability** on this
repository. Include what you found, how to reproduce it, and the impact. You
will get a reply as soon as the maintainer can read it; please allow a few days.

## Scope

In scope: the Flutter app (`app/`), the backend (`backend/`), the landing site
(`landing/`) and the deployment files (`deploy/`).

Especially interesting: reading or changing another user's data, bypassing
sign-in or the SMS code limits, the app lock and export confirmation, and
anything that stores or leaks raw bank-SMS text.

Out of scope: findings that need a rooted or jailbroken device, missing
hardening on a development setup (`make run-lite`), and automated scanner
output with no demonstrated impact.

## Supported versions

Only the latest commit on `main`. There are no released versions yet.

## Deploying safely

Production settings refuse to start without a strong `DJANGO_SECRET_KEY`
(32+ characters), `DJANGO_ALLOWED_HOSTS`, and a real SMS backend. Serve gRPC
over TLS (the app does this for every non-local host), and restrict `/admin/`
at your reverse proxy (by IP or VPN). Swagger, ReDoc and `openapi.json` are off
in production; set `DJANGO_API_DOCS_ENABLED=true` only where you want them.
