# Summa: Reference Research Docs (Taraznama, taraznama.com)

**Summa** is a personal-accounting app (expenses, installments, assets) for a foreign client, built with an identity and shape completely different from Taraznama. These docs are a study of Taraznama as a feature reference and must not be copied verbatim.
Research date: 1405/09/01 (2026-11-22).

## Recorded decisions
- Stack: a Flutter app, a gRPC backend, and a landing site for introduction (similar to the structure of the taskforge project, which has no landing site). Details in [AGENTS.md](../AGENTS.md). [Live preview of the landing site](https://ctrlaltdevelop.github.io/summa/) (static, no backend).
- Backend: Django + grpcio. Iran only and Persian only (multiple currencies kept). Bot removed; bank SMS is automatic. Look and brand are different from phase one.

## Index
1. [product-overview.md](01-product-overview.md): product identity, platforms, site map, plans and revenue model
2. [features-flows.md](02-features-flows.md): user flows (login, recording expenses, bank SMS, installments, assets, bot, tools, support)
3. [prices-data-sources.md](03-prices-data-sources.md): price sources and fallback rules
4. [security-privacy.md](04-security-privacy.md): security, privacy, legal items
5. [open-questions.md](05-open-questions.md): open questions for the client, flow by flow
6. [architecture.md](06-architecture.md): architecture and principles
7. [roadmap.md](07-roadmap.md): the phase-one phases (one feature per phase)
8. [phase-template.md](08-phase-template.md): the phase document template
9. [concept.md](09-concept.md): the full idea (supplementary proposals, not yet a final decision)
10. [data-model.md](10-data-model.md): data model, gRPC services and the parsing pipeline (initial proposal)
11. [parsing-spec.md](11-parsing-spec.md): sentence and SMS parsing spec, confidence and tests (initial proposal)
12. [security-model.md](12-security-model.md): security and privacy model; the E2E vs Ollama conflict (proposal)
13. [phases/phase-00-foundation.md](phases/phase-00-foundation.md): phase 00 document (ready to start)
14. [phases/phase-01b-wallets.md](phases/phase-01b-wallets.md): phase 01b document (wallets)
15. [phases/phase-02-ledger.md](phases/phase-02-ledger.md): phase 02 document (ledger)
16. [phases/phase-02b-transfers.md](phases/phase-02b-transfers.md): phase 02b document (transfers between wallets)
17. [phases/phase-03-categories.md](phases/phase-03-categories.md): phase 03 document (categories and limits)
18. [phases/phase-04-assistant.md](phases/phase-04-assistant.md): phase 04 document (assistant chat)
19. [phases/phase-05-sms.md](phases/phase-05-sms.md): phase 05 document (bank SMS)
20. [phases/phase-06-split.md](phases/phase-06-split.md): phase 06 document (split and excluded from totals)
21. [phases/phase-06b-refunds.md](phases/phase-06b-refunds.md): phase 06b document (returns and refunds)
22. [phases/phase-07-recurring.md](phases/phase-07-recurring.md): phase 07 document (recurring transactions)
23. [phases/phase-07b-salary.md](phases/phase-07b-salary.md): phase 07b document (salary and reminder)
24. [phases/phase-07c-accounting-hour.md](phases/phase-07c-accounting-hour.md): phase 07c document (bookkeeping hour)
25. [phases/phase-08-debts.md](phases/phase-08-debts.md): phase 08 document (loans and installments)
26. [phases/phase-09-assets.md](phases/phase-09-assets.md): phase 09 document (assets and prices)
27. [phases/phase-10-networth.md](phases/phase-10-networth.md): phase 10 document (net worth and portfolios)
28. [phases/phase-11-reports.md](phases/phase-11-reports.md): phase 11 document (reports and export)
29. [phases/phase-12-sync.md](phases/phase-12-sync.md): phase 12 document (offline and sync)
30. [phases/phase-13-billing.md](phases/phase-13-billing.md): phase 13 document (subscription and payment)
31. [phases/phase-14-support.md](phases/phase-14-support.md): phase 14 document (support)
32. [phases/phase-15-privacy.md](phases/phase-15-privacy.md): phase 15 document (account, privacy and app lock)
33. [phases/phase-15b-data.md](phases/phase-15b-data.md): phase 15b document (data import and export)
34. [phases/phase-16b-cms.md](phases/phase-16b-cms.md): phase 16b document (landing content management)
35. [phases/phase-16-landing.md](phases/phase-16-landing.md): phase 16 document (landing site)
36. [phases/phase-17-calculators.md](phases/phase-17-calculators.md): phase 17 document (public calculators)
37. [phases/phase-18-widget.md](phases/phase-18-widget.md): phase 18 document (widget, scope decision only)
38. [phases/phase-19-english.md](phases/phase-19-english.md): phase 19 document (English and LTR)
39. [phases/phase-19b-country-profiles.md](phases/phase-19b-country-profiles.md): phase 19b document (country profile)

## Research limitations
- All public pages were read, except `/disclosure` (a 503 error twice; the list of referral partners and the referral revenue model are unknown).
- `/login` and `/dashboard` render with JavaScript and their content was not captured. The login flow was extracted from a help article.
- The `/pricing` prices were garbled in extraction (details in the first file).
- The pricing page has no direct link to the features. The feature descriptions were in the 22 `/help` articles.
- The content is summarised and rewritten, not a verbatim copy of the site's text.
