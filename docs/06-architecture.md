# Summa Architecture

## Decisions
| Area | Choice |
|---|---|
| App | Flutter, one codebase (Android, iOS, web, desktop) |
| Backend | Django + grpcio (gRPC for app data). REST only for webhooks, uploads and payments |
| Database and background jobs | PostgreSQL, Redis, Celery |
| Landing site | Separate site built with **Three.js**, interactive; visitors can try the product right there (a demo usable without signing up). Introduction, pricing, calculators, magazine, help |
| Design and motion | Modern, animation-rich UI in the app (Flutter animations, Rive/Lottie for complex cases) and on the landing site; design system and motion rules in phase 00 |
| SMS parsing | Ollama (small model) on our own server + per-bank regex patterns; no external service |
| Bot | **None** (no Bale, no Telegram, no Eitaa) |
| Language and market | **Iran only and Persian only** (right-to-left, Shamsi calendar, Persian digits). Strings are kept in the Flutter l10n files only for tidiness; another language is not a goal. **Multiple currencies and wallet types are kept** |

## Principles
1. **Contract first:** the `.proto` files are the source of truth; stubs are generated and never edited by hand.
2. **Each user's data is separate:** every query is scoped to the authenticated user; the user id is never accepted from the client.
3. **Money:** an integer in the smallest unit (never a float), together with a currency code. Currency conversion happens only in the display and reporting layer.
4. **Swappable calendar and currency:** storage is always UTC and Gregorian; display is Shamsi or Gregorian according to the user's setting.
5. **Event-driven:** every change is an event; this is the foundation for offline/sync and for a full data export.
6. **Offline:** a local database in the app + a queue of changes with a unique `client_mutation_id` (idempotent).
7. **Bank SMS (the shared path for all platforms):** the user hands over the SMS text with "Share to Summa" (share) or by copying and pasting it into a box inside the app. The text goes to the backend, where a small **Ollama** model turns it into a structure (amount, withdrawal/deposit type, date, balance, merchant if present) and returns the result to the app together with a report. Then comes the confirmation queue and the question "What was this for?".
   - **Validation without an LLM:** the model's output is accepted only against a fixed schema (JSON), and the amount must appear verbatim in the SMS text; otherwise it is rejected or sent to the confirmation queue with low confidence. Each bank's pattern (regex) comes first, and the model runs only if it does not match.
   - **Security:** SMS text is data, not instructions (prompt injection); the model has no tools and no access. Raw text is not stored after processing (or only with the user's consent, to improve the parser), never appears in logs, and travels only between the app and our own server, never to an external service.
   - **Privacy:** before the first send, the user sees that the text goes to the server. Rate limiting and a queue (Celery) keep load on the model under control.
   - Automatic SMS reading on Android (the full version) is only an optional enhancement and calls this same path automatically. iOS: Shortcuts calls the same API.
8. **Reminders:** push notifications (the replacement for a bot); SMS and email are optional.
9. **Asset prices:** a central price service with multi-source fallback and a stale marker; the sources depend on the target market (open).

## Wallets and currency
- The target market is Iran only and the language is Persian only; the calendar is Shamsi (Gregorian only for displaying foreign currencies if needed). **Currencies stay open** (any ISO currency and custom currencies such as gold/Tether).
- **Wallet** = (currency + bank or "cash" + name + balance). A user can have several wallets per currency. The initial balance is collected at creation and recorded as an "initial balance" event, not as a number typed onto the account.
- Every transaction is attached to one wallet and records its value in that wallet's currency. The balance is always computed from events.
- The "accounting box" (calculation box): all wallets, the balance of each, and a grand total in the user's chosen **base currency** using conversion rates (rate source: the conversion API the client provides in phase 09).
- **Money management** (a kind of entry in the expenses section, with no real movement of money; bookkeeping only): the user records transfers between wallets: bank ↔ bank, cash ↔ bank (cash deposit and withdrawal).
  - Each transfer is a pair of events: an outflow from the source and an inflow to the destination, sharing one transfer id. It is left out of the totals for expenses, income and categories.
  - A **fee** is optional and entered by the user; it has its own amount and currency, is recorded as an ordinary expense (category "Fee" / کارمزد) from the source wallet, and counts in the expense totals.
  - **Currency conversion:** when the source and destination have different currencies, the app **asks the user for the conversion rate** (default: the system's latest rate as a suggestion, editable) and computes the destination amount; the user can also override the final amount by hand. The rate used is stored on that transfer and never changes afterwards. The conversion fee is collected there as well.
- Bank SMS: the sending bank determines the suggested wallet; the user can change it in the confirmation queue.

## In-app assistant chat (no messenger bot)
- The chat is an environment where the user sends messages: they can write a sentence, or **send an SMS text and say what it was for**.
- The chat lives only inside the app and is **private to each user**: every access is authenticated and scoped to that user.
- **The AI only analyses and replies.** For example: "Do you want me to register a transfer between your accounts, from card X to card Y?" The AI interacts only with the user in the chat; it has no write tool and no direct access to data.
- An AI suggestion is displayed as a **card** (a transaction card, a transfer, a reminder...). The "Register" button on the card is only a **shortcut**: when pressed, **the user's phone** sends the normal register request (the same one the manual form sends) to the server with the card's content. Nothing more. The user can edit the content before pressing it.
- Result: the only write path is the app's normal authenticated requests; if the AI is wrong or gets tricked (prompt injection), nothing is registered without the user's confirmation.

## Iran profile
- One configuration profile for Iran: default currency (Toman/Rial), Shamsi calendar, **wallet types**, the list of banks and SMS patterns, rate sources. It is kept in the backend and edited from the admin. We do not build a multi-country structure (YAGNI); only the configuration stays separate from code.

## FX rates
- A background service (Celery beat) fetches rates every few hours and keeps them in the backend; the app and the landing site read only from the backend. The rate is approximate and is meant for displaying the grand total and for suggestions in currency conversion, not for trading.

## Reminders
- A reminder scheduling service (push): salary (a specific day + "not yet" -> tomorrow), the daily bookkeeping hour, the due date of a recurring transaction (+ a warning about insufficient balance before it), installments. Each user has their own hour and time zone.

## Authentication for sensitive operations
- Data export/import and other sensitive operations: device biometrics first. If the device has no biometrics, the app asks the user to enable the **in-app passcode** first, and then asks for that passcode for confirmation. Without this authentication, no data file is handed over or accepted.

## Design and motion
- A visual identity completely different from Taraznama; the design system (color, type, spacing, motion) lives in tokens, with no raw values in widgets.
- Animation is part of the product: screen transitions, recording a transaction, charts, number counting, empty and loading states.
- Constraints: respect the system "reduce motion" setting, smooth 60fps on mid-range devices, usable with a keyboard and a screen reader.
- Landing: a Three.js scene with device-based quality control (a simple fallback on weak mobiles or with reduced motion), without leaving content and the CTA only inside the canvas (SEO and accessibility).

## Landing and backend
- The landing site takes its data from **the same backend**; everything variable can be edited from the admin panel without redeploying: prices and plans, copy and translations, FAQs, magazine and help, the live sample price, announcements.
- The backend exposes a read-only public API (REST with caching and ETag) for the landing site; editing goes through the admin (the `cms` app in Django, the Unfold panel) with a content-editor role.
- Versioning and preview: a content change is a draft first, then it is published.
- Landing demo: the user types a sentence into a chat/input (such as "قهوه ۹۵" — "coffee 95"), **the same real backend parser** answers on a sample account (amount, category, category-change buttons), and the "Taraz" (تراز, "balance") indicator at the top of the page reacts to each entry (a Three.js scene). The sample account is wiped automatically, is rate limited, and never touches anyone's real data.

## Repository layout (target)
```
summa/
  AGENTS.md  README.md
  docs/              Persian docs and phases
  app/               Flutter
  backend/           Django + gRPC (+ .proto next to the services)
  landing/           introduction site
  deploy/            docker compose, CI
```

## Open / depends on section zero
- Price sources and the asset list for non-Iranian markets (gold/Tether/stock market are specific to Iran).
- The list of banks and SMS templates, specific to each country.
- Revenue model and plans (question 6).
