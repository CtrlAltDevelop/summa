# Phase One Roadmap

Phase one = feature parity with Taraznama, with a completely different look and brand, no bot, and automatic bank SMS. Each row is one user-facing feature (one document in `docs/phases/`). Do them in order; mark ✅ after acceptance.

| # | Phase | Description | Depends on |
|---|---|---|---|
| 00 | Foundation | Repo skeleton, Django+gRPC backend, Flutter app, Persian l10n and RTL, a modern design system with animation rules and brand, CI | |
| 01 | Login | Mobile number + SMS code, optional password, sessions and devices, attempt limits | 00 |
| 01b | Wallets | Create a wallet with any currency and bank (several per currency, cash), initial balance at creation, the accounting box (all balances and a total in the base currency); **wallet types** (cash, bank account, credit card, BNPL, gift card, crypto, gold...) based on the **Iran profile** (Iran only; multiple currencies stay) | 01 |
| 02 | Ledger | Manual entry of expenses/income with a wallet choice (currency and bank), transaction list and edit/delete | 01b |
| 02b | Money management | Transfers between wallets (bank↔bank, cash↔bank) in the expenses section, optional fee, currency conversion with a user-supplied rate and fee | 01b, 02 |
| 03 | Categories and limits | Default and custom categories, monthly limit with a warning | 02 |
| 04 | Assistant chat and sentence entry | In-app chat, private to each user. The user sends a sentence or an SMS text along with its topic; the AI only analyses and replies/suggests in the chat (e.g. "Register a transfer from card X to card Y?") with a card. The "Register" button is a shortcut: the user's phone sends the normal register request with the card's content; the AI has no write access. Interpreting the sentence (amount, category, date) is Persian only. The landing demo connects to this same parser | 02, 03 |
| 05 | Bank SMS | Share or paste the SMS text; parse with Ollama + regex and validation; report the result to the app, confirmation queue, the "What was this for?" question, duplicate detection. Optional enhancement: automatic reading on Android (the full version) | 02 |
| 06 | Split and excluded from totals | Splitting an expense across categories, others' shares, kept out of the totals | 02, 03 |
| 06b | Returns and refunds | Record a return or refund against an earlier transaction (full or partial), to the same wallet or another; in reports it reduces the expense and the link to the original transaction is kept | 02 |
| 07 | Recurring transactions | A "recurring" option when recording; automatic deduction from the chosen wallet; near the due date, a report if the balance is low; on the due day it asks: "Deducted from this account? / From another account / Cancelled" | 01b, 02 |
| 07b | Salary and reminder | Define the salary day (e.g. the 16th) or record "I received this month's salary"; after that day a "Did you get it?" reminder; if "not yet", again tomorrow | 02 |
| 07c | Bookkeeping hour | The user sets a daily hour, and at that hour a notification arrives so they can settle their accounts | 02 |
| 08 | Loans and installments | Kinds of debt, installment schedule, "Paid", push reminders | 02 |
| 09 | Assets and prices | Assets, the price service and currency conversion rates: **a background service (Celery) in the backend refreshes rates every few hours and all clients read only from the backend**; rates are approximate (we are not an exchange). The client supplies the API in this phase; profit and loss | 01 |
| 10 | Net worth and portfolios | Net worth (multiple units), loan deduction, target portfolio | 08, 09 |
| 11 | Reports and export | Monthly report, charts, CSV export | 02, 03 |
| 12 | Offline and sync | Local database, change queue, multiple devices | 02 |
| 13 | Subscription and payment | Plans, payment gateway, trial period (after question 6) | 01 |
| 14 | Support | In-app tickets, contact form | 01 |
| 15 | Account, privacy and app lock | App lock (biometrics; if the device has none, the in-app passcode is enabled first), account deletion, privacy settings | 01 |
| 15b | Data import and export | Full data export and file import (CSV/Excel). **Before handing over a file or accepting an import, authenticate:** biometrics; if the device has no biometrics, the user first enables the in-app passcode and then enters that passcode to confirm | 15 |
| 16 | Landing site | Interactive site with Three.js, a live chat demo (the real parser on a sample account) with the "Taraz" indicator that reacts, content and prices from the backend API and editable in the admin, introduction, pricing, help, magazine, legal pages. Independent of the app and can be built in parallel | 00 |
| 16b | Landing content management | A `cms` app in the backend: price/plan, copy, translations, FAQ, magazine; draft and publish; a public API with caching | 00 |
| 17 | Public calculators | Installment calculator and other tools without sign-up, integrated with the landing demo | 16 |
| 18 | Widget | Phone home-screen widget; scope and features are decided in this phase | 02 |
| 19 | English and LTR | A second language, `en`, in the app and landing site, a language picker, left-to-right layout, date/number formats by language; server-side texts also in the user's language | 00, 16 |
| 19b | Country profile | Generalize the Iran configuration into a "country profile": default currency, calendar (Gregorian alongside Shamsi), wallet types, banks and SMS templates, price and rate sources; country choice at sign-up and in settings | 19, 01b, 05, 09 |

## After phase one (from section 3 of the questions)
The new features have not been specified yet; each becomes its own phase.

## Rule
One phase = one feature. Do not let a second thing into a phase; write a new phase document.
