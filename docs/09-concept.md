# The complete Summa idea (proposal, editable)

> Supplementary proposals built on the recorded decisions. Each item becomes a phase once approved. Nothing here is a final decision yet.

## The core loop (3 seconds)
Bank SMS -> the app understands it (amount, wallet) -> one question: "What was it for?" with 3 category suggestions -> recorded, the Taraz balance indicator moves. Everything else is built around this loop.

## Automatic entry, in detail
- **Quick reply:** the "What was it for?" question is answered in the app notification itself (category buttons, without opening the app).
- **Merchant memory:** every user answer is learned (similar SMS -> same category); after a few times it is recorded without asking and only appears for "Confirm" in the weekly report.
- **Linking an SMS to a wallet:** via the card/account number in the SMS; asked from the user the first time and saved.
- **Approval queue:** every ambiguous SMS waits for a single tap; nothing silently lands in reports.
- **Balance in the SMS:** the SMS states the account balance; the app compares it with the computed balance and, if they differ, warns "the wallet balance doesn't match the bank" (automatic reconciliation, a big difference from the Taraznama reference).
- **Manual entry** is always available (a Persian sentence, phase 04).

## Wallets and the vault
- **Computed vault:** the home screen; a card for each wallet with its balance, and the grand total in the base currency. Tap a card -> that wallet's history.
- **Reconciliation:** the user can enter the "real balance" at any time; if it differs, the difference is recorded as an "adjustment" (not an edit of the past).
- **Archive:** a closed wallet (for example a closed account) is archived and its history stays.
- **Custom currency:** gold (grams), Tether and so on as definable currencies.

## Budget and goals
- A monthly budget for each category, in the base currency; a progress bar with color and animation; amount suggested from the average of previous months.
- **Savings goal:** amount + date; funded from one wallet; "how much is left and how much is needed each month".
- **Month balance:** income − spending − installments, one main number; the same "Taraz" indicator as on the landing site.

## Installments and debt
- Installment table, an automatic "paid" from SMS (if a payment SMS arrives it is suggested), push reminders.
- **Debtor/creditor:** "I owe so-and-so / so-and-so owes me" with a date; separate from spending; counted in net worth.

## Assets
- Asset wallet with live prices (gold, coins, Tether, currency, stocks) and profit/loss; portfolios; net worth shown in Toman/gold grams/dollars.
- A "my wealth over time" chart with a point at every change.

## Insights (buildable with the same Ollama or rule-based)
- A plain-language monthly summary, unusual spending, "30% more cafe spending than usual this month", an end-of-month forecast.
- All on our own server, no external service; the user can turn it off.

## Privacy and trust
- No bank connection, no passwords collected; SMS text is not stored after processing (except with consent).
- App lock (biometrics/PIN), a mode that hides amounts on screen, full export and account deletion.

## Product feel
- Animation at meaningful moments: recording a transaction, a balance change, reaching a goal, a budget filling up.
- The landing site shows the core loop live (a chat demo with the real parser).

## Plan proposal (for question 6, just an idea)
- **Free:** one wallet, manual/share entry, a simple budget.
- **Pro:** unlimited multi-currency wallets, automatic SMS reading (full version), bank reconciliation, insights, goals, export.
- No ads and no data sales; revenue only from subscriptions.

## Gaps (identified, not decided)
1. **Historical exchange rate:** should the Toman value of a dollar transaction be computed at "that day's" rate or "today's"? Without this, multi-currency reports become unstable. Proposal: store the rate of the day of entry, and let the report show both.
2. **Wallet types:** credit card (negative balance), BNPL (SnappPay), gift card, crypto; "cash/bank" alone is not enough.
3. **Custom fiscal month:** the month starting on payday, not the first of the Shamsi month.
4. **Recurring income and spending:** monthly salary, subscriptions (Netflix...), automatic detection of recurrence from SMS.
5. **Returns and refunds:** returned goods, chargebacks, friends' share (in Taraznama, "others' share"), splitting costs.
6. **Cheques and due dates** (Sayad cheque, cleared/bounced cheque) and debt with a due date.
7. **Quick-entry tools:** home-screen widget, lock-screen shortcut, search, tags, notes, receipt photo.
8. **Data in/out:** import from Excel/CSV and from Taraznama, backup and restore, a conflict-resolution rule for multi-device sync.
9. **Data security:** end-to-end encryption for financial data, app lock, sessions; a decision is needed: can the server read content (for Ollama and insights) or not? These two conflict.
10. **Operations and legal:** size and cost of the Ollama server, monitoring and database backup, admin panel and roles, laws and privacy, a domestic payment gateway (Zarinpal) versus the stores' in-app purchases.
11. **Not written yet:** each phase's doc, the list of Iranian banks and real SMS samples, visual identity and brand, plan and price (question 6), new features (question 3).

### Status of the gaps after the new decisions
- ✅ Exchange rate: a background service in the backend, approximate (storing the entry-day rate for reports is still a proposal).
- ✅ Wallet types: phase 01b with the country profile (item 2).
- ✅ Returns and refunds: phase 06b. "Others' share" and splitting stay in phase 06 (item 5).
- ✅ Salary and recurring transactions: phases 07, 07b and 07c (item 4).
- ✅ Data import/export with biometrics or the app passcode: phase 15b (item 8).
- ✅ Widget: phase 18 (exact decision in that phase).
- ⏳ Still open: the conflict between end-to-end encryption and Ollama/insights (item 9); custom fiscal month (item 3); cheques (item 6); quick entry other than the widget (item 7).
- Note: "a private chat per user" is server-side access control, not end-to-end encryption; the server still sees the text for processing.

## Idea continued: the assistant chat (proposal)
- **Card types:** transaction (expense/income), transfer between wallets with a fee, return/refund, recurring transaction, salary/installment reminder, budget setting, new wallet. Every card is editable before "Register", and a suspicious field (uncertain amount, guessed wallet) is visibly marked.
- **Several cards in one message:** if the user sends several SMS messages at once, the AI gives several cards and one "Register all" button (with a quick review).
- **Read-only Q&A:** "How much did I spend on cafes this month?" or "What's my total dollar balance?". The AI answers read-only and only from that user's data (through fixed, limited backend queries, not free database access) and shows the number linked to the relevant screen.
- **Quick buttons:** under the chat input: "Record expense", "Paste SMS", "This month", "Balances".
- **Voice input** (optional): saying "ناهار ۲۸۵" (lunch 285) -> text -> the same path.
- **Language:** the AI replies only in Persian; Persian digits (input with English digits is understood too).
- **Error states:** if Ollama is unavailable, the chat says "I can't check right now" and offers a **manual form prefilled with the SMS text** (regex); the app is never left without a manual path. Offline: messages are queued and processed later, and manual entry keeps working.
- **Limits:** per-user rate limit, message length, and automatic deletion of chat history after N days (configurable, and deletable by the user).

## Idea continued: onboarding
1) Language and country -> country profile (currency, calendar, wallets) 2) create the first wallet with its balance 3) bookkeeping hour and payday 4) teach "paste the SMS" with a live example. Every step can be skipped; it can be resumed later from "Getting started" on the home screen.

## Idea continued: undo and audit trail
- **Undo:** after every entry, an "Undo" bar for a few seconds; after that, edit/delete from history.
- **Audit trail:** every transaction says where it came from (manual, chat, SMS, recurring) and who/what created it; edits are separate events and the past is never erased.
- **Soft delete and a trash bin** for transactions (restorable for up to 30 days).

## Idea continued: Iran-specific
- **Card-to-card** and **Satna/Paya/Pol** as transfers with a fee (each bank's default fee from the country profile, editable).
- **Cheque** (Sayad): due date, issued/received, cleared/bounced; shown under installments and debt.
- **Shamsi date** by default and a configurable fiscal month; Persian digits; entering amounts in Rial/Toman with automatic conversion and a configurable display.
- **Common service SMS:** bills, top-ups, fines; templates in the country profile.

## Idea continued: intelligence (all on our own server, can be turned off)
- **Recurrence detection:** "Netflix" three times at monthly intervals -> suggest "make it recurring?".
- **Balance forecast:** "In 5 days a 10 million installment is due and this wallet's balance is 6 million".
- **Anomaly:** spending far above that category's norm -> a gentle reminder, not a scary alert.
- **Short weekly summary** at the bookkeeping hour.

## Idea continued: AI quality
- **Sample set:** a few dozen real SMS messages per bank (with numbers/names removed) in the repo; an automated test that measures accuracy of amount, type and date.
- **Criterion:** the amount must appear verbatim in the text; amount and type accuracy become a CI gate and are measured before any new model/template is released.
- **User feedback:** "This was wrong" on a card -> (with consent) the text without personal information is used to build a template; never without consent.
- **Versioning:** models, prompts and templates are versioned; every parse stores the version that produced it so errors can be traced.

## Idea continued: shared ledger (later)
A family of up to several people; shared and personal wallets; each member sees only what they have allowed. After the first phase, as a separate phase.

## Idea continued: app screens (proposal)
Bottom navigation, 5 sections:
1. **Home:** the "month balance" Taraz indicator (income − spending − installments) with animation, the "What was it for?" card for uncategorized SMS, upcoming due dates, budgets that are nearly full.
2. **Vault:** a card for each wallet (cash, banks, credit card...) with its balance and the grand total in the base currency; tap -> history; a "Real balance" button for reconciliation.
3. **Chat (center button):** the assistant; always one tap away from anywhere in the app.
4. **Reports:** the month, "where it went", day by day, comparison with the previous month, budget, export.
5. **More:** assets and prices, installments/debt/cheques, goals, recurring items, settings (bookkeeping hour, salary, lock, privacy).
- **Quick add** from any screen: expense, income, money management (transfer), return.

## Idea continued: Iran default categories
Food and groceries, restaurants and cafes, transport (Snapp, Tapsi, fuel, metro), bills and charges, rent and home, installments, health, education, leisure and subscriptions (Netflix, Filimo), shopping and clothing, gifts and parties, bank fees, other. Income: salary, project, gift, interest, asset sale, other. A custom category has a name, icon and color; deleting a category -> "Other".
- **Merchant rule:** Snapp/Tapsi -> transport, Digikala -> shopping, Filimo -> subscription, and so on; in the Iran profile and editable in the admin.

## Idea continued: assets and debt (Iran)
- **Assets:** gold (grams, 18-karat), coins (varieties), currency (dollar, euro...), Tether and crypto, stocks and funds, property and cars (manual value). Prices from the backend service; a "stale price" marker if a source goes down.
- **Debt:** bank loan, interest-free loan (qarz al-hasanah), purchase installment, cheque, "I owe so-and-so / so-and-so owes me".
- **Net worth** in Toman, gold grams and dollars; a chart over time; loan deduction selectable (a purchase installment is never deducted, as in the reference).
- **Inflation:** an optional view "what your wealth is in gold grams" to see the effect of inflation.

## Idea continued: landing site (proposed structure)
1) Hero: headline + live chat demo + the "Taraz" indicator (Three.js) 2) three steps: paste the SMS -> AI understands -> one-tap record 3) the multi-wallet vault 4) reminders and salary 5) security and privacy (raw text not stored, biometrics, no bank password) 6) prices (from the admin) 7) FAQ (from the admin) 8) journal and guides 9) download: Bazaar/Myket/Google Play links/direct download.
- Mobile-first; a simple version (no WebGL) for weak devices; load speed and Persian SEO; all texts editable in the admin.

## Idea continued: admin panel (Unfold)
Content (prices, FAQ, journal, texts), the Iran profile (categories, merchant rules, banks, SMS templates, default fees), rates (source and last update), users and subscriptions (without seeing financial data), a queue of unparsed SMS messages (only with user consent), feature flags, Ollama and queue status. Roles: content editor, support (limited and logged access), admin.

## Risks and suggested order
**Main risks:**
1. SMS parse accuracy with a small model on Persian (mitigation: regex first, validation, sample set, approval queue).
2. The Ollama server: cost and latency (mitigation: small model, queue, cache, regex for most SMS messages).
3. Android and distribution: Play does not accept `READ_SMS`; the shared share path solves it (chosen).
4. Privacy: the SMS text goes to the server; transparency and not storing it are required.
5. Exchange rate and gold price: a reliable source in Iran (the client provides an API).

**Suggested order for the first releasable version (a small, complete slice):**
00 foundation -> 01 login -> 01b wallets -> 02 ledger -> 03 categories -> 04 chat and parse -> 05 SMS -> 15 lock -> 16 landing.
After that: 02b money management, 06b returns, 07 recurring, 07b/07c reminders, 08 installments, 09 assets, 11 reports, 12 offline, 13 subscription, 15b import/export, 18 widget.
Reason: the core value (SMS -> accounting) and the landing site get into users' and the market's hands sooner, and the remaining features are built on top.

## Idea continued: identity and tone
- **Tone:** calm, friendly, never scolding ("cafes ran a bit higher this month", not "you blew the budget!"); polite colloquial Persian; short.
- **Visual feel:** modern and animation-rich, different from Taraznama (which is dark/gold); possible directions: light and airy with a single accent color, or glassy/soft with a gentle gradient. The final choice in phase 00 with a few samples.
- **Name and symbol:** "Summa" (sum/summary) -> the "Taraz" indicator and the sum symbol (Σ) can become the visual ring.
- **Empty states and small joys:** every empty screen has one clear action; success moments (a goal, a healthy budget) get a short, quiet animation.

## Idea continued: notifications without fatigue
- A maximum number of notifications per day, quiet hours, categories (urgent: due dates/balance; normal: bookkeeping hour; low: weekly summary). The user turns off each type separately.
- Sensitive notifications do not show amounts on the lock screen (configurable).
- "Not yet" on the salary reminder sets it to tomorrow, and after 3 times it gets gentler (weekly).

## Idea continued: accessibility and quality
- Adjustable font and size, sufficient contrast, reduced motion, screen-reader support for cards and charts (text equivalents).
- Usage analytics without breaching privacy: anonymous, aggregated events, off by default, never amounts or text.
- Tests: unit for parse/balance/rate, integration for every gRPC service, an "other user" test, and an end-to-end test of the main flow (SMS -> card -> record -> balance).

## Idea continued: release and revenue (proposal)
- **Distribution:** landing site (Persian SEO) + Bazaar and Myket (full version) + Google Play (version without automatic SMS) + direct download; iOS after Android is stable (Shortcuts/share).
- **First users:** people with installments and several bank accounts who are tired of notebooks/Excel; the core message: "Paste your bank SMS and your bookkeeping becomes automatic".
- **Subscription:** monthly/quarterly/yearly via a domestic gateway (such as Zarinpal), no auto-renewal, at the end of the subscription the account becomes read-only and data is not deleted; 14 days free without a card. (Reference design; price and plan after question 6.)
- **Trust:** a "what is stored and what is not" page on the landing site and inside the app; no ads and no data sales.
- **Feedback:** in-app ticket + "This was wrong" on a card (with consent) -> improved templates.
