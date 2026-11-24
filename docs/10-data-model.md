# Data Model and Services (initial proposal)

> A high-level sketch to align the phases. The details of each table and RPC are finalised in that phase's own document.

## Principles
- **Event-driven:** the source of truth is an event ledger (append-only); balances and reports are computed or materialised from it.
- Money = an integer in the smallest unit + a currency code. No floats.
- Every row is tied to a `user_id`; every query is filtered by the authenticated user (an "other user" test for every service).
- Time is always UTC; display uses Shamsi and the user's time zone (default Asia/Tehran).
- Every write carries a unique `client_mutation_id` (idempotent, the foundation of offline).

## Entities
| Entity | Key fields | Note |
|---|---|---|
| `User` | mobile number, name, base currency, bookkeeping hour, time zone | |
| `Wallet` | type (cash/bank/credit card/BNPL/gift card/crypto/gold), currency, bank, name, archived | the balance is not stored; it comes from events |
| `LedgerEvent` | wallet, direction (in/out), amount, currency, time, kind (income/expense/transfer/fee/adjustment/initial balance/refund), source (manual/chat/SMS/recurring), `transfer_id`, `refund_of`, conversion rate | immutable; an edit = a replacement event |
| `Transaction` (view) | category, note, tag, "excluded from totals", splits | aggregates one transaction's events for display |
| `Category`, `Budget` | name, icon, color; monthly limit | defaults come from the Iran profile |
| `Recurring` | pattern, period, wallet, fixed/variable amount, status | generates a "due" -> asks the user |
| `Reminder` | type (salary/hour/installment/recurring), time, status (open/done/snoozed) | "not yet" -> tomorrow |
| `Debt`, `Installment` | type, principal, count, due dates, paid | a payment = an expense event |
| `Asset`, `AssetLot` | type, quantity, purchase price, portfolio | the price comes from `Rate` |
| `Rate` | symbol, price, source, time | updated by Celery beat |
| `ChatThread`, `ChatMessage` | user, text, role, cards (JSON), status | user only; auto-deleted after N days |
| `SmsParse` | model/pattern version, structured result, confidence | raw text is not stored by default |
| `Device`, `Session` | device, token, last used | |
| `Plan`, `Subscription` | plan, status, end | after the answer to question 6 |
| Landing content | `Page`, `FaqItem`, `Article`, `PricingPlan`, `IranProfile` | editable in the admin |

## gRPC services (authenticated user)
`AuthService`, `WalletService`, `LedgerService`, `CategoryService`, `BudgetService`, `ChatService` (streams the AI reply), `ParseService` (SMS/sentence -> card), `RecurringService`, `ReminderService`, `DebtService`, `AssetService`, `RateService`, `ReportService`, `SyncService`, `ExportService`, `AccountService`.
- **A public read-only REST API** for the landing site (content, prices, sample rates) with caching and ETag, and a limited endpoint with a sample account for the chat demo.
- Data is written only through these services; `ChatService` and `ParseService` never call `LedgerService` directly (card -> Register button -> app).

## SMS/sentence pipeline
Text -> cleaning (Persian/English digits, whitespace) -> bank regex -> (if no match) Ollama with JSON output -> validation (amount verbatim in the text, type, plausible date) -> confidence score -> card (+ suggested wallet and category) -> user confirmation -> the normal `LedgerService.Create` request.

## Operations
- Celery: rates, reminders, deleting old chats, report materialisation, processing the SMS queue.
- Observability: structured logs without amounts or SMS text; parse-accuracy counters (without content); Ollama and queue status.
- Encrypted database backup; account deletion = real deletion of the user's data (except the payment receipt).
