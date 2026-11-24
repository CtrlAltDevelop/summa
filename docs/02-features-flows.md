# User flows and rules

## 1. Sign-up and login
- Only **mobile + 6-digit SMS code**; then name; password optional (at least 10 characters). "Log in with password" appears only when a password is set.
- "This is not my device": 8-hour session. Normal session: 30 days idle or 90 days total.
- Limits: code valid for 5 minutes; 5 guesses per code; at most 5 codes per hour per number; resend interval 60 to 180 seconds; after 10 wrong codes in a day, a wait from 1 minute up to 60 minutes (escalating); after 5 wrong passwords the same escalating wait.
- The response to a code request is the same for a number with an account and one without.
- Forgot password: log in with an SMS code, then "Settings -> Security and devices -> Change password". Changing the password logs out all other devices.
- Login via the bot has been removed; the bot only attaches to an existing account.
- Code does not arrive: check the number, wait for the countdown; promotional-SMS blocking on the line may cause delay.
- Getting started (first ten minutes): 1) record one expense 2) set monthly salary in settings 3) add installments 4) connect the bot under "Connections". Assets are optional.

## 2. Recording expenses and income
Three ways, one ledger:
1. **Web app**: the "Add expense" button or the N key; one sentence like "ناهار ۲۸۵" (lunch 285) -> amount, category, date. "Save and next" for back-to-back entry. "Regulars": recurring items; fixed price with one tap, variable price needs only the amount. Manually editing a field detaches it from the sentence.
2. **Bot**: the same sentence; the reply looks like "خرج ثبت شد: ۲۸۵ هزار تومان 🍔 غذا" (expense recorded: 285 thousand Toman, food); an "Undo" button and buttons to change the category.
3. **Bank SMS**: goes to the approval queue.

### Sentence interpretation rules
- A number under 1000 = thousand Toman.
- A number from 1000 to 100,000 without a unit: ambiguous; it guesses from that category's history, otherwise asks.
- Formats: "۲ میلیون و ۵۰۰" (2 million and 500), "125,000", "۲٫۵ میلیون" (2.5 million), "دو و نیم میلیون" (two and a half million).
- Times, dates and counts ("۳ نفر", 3 people) are not amounts.
- "دیروز" (yesterday) / "پریروز" (the day before yesterday) change the date.
- A leading "+" in a message = income (for example "+۵۰ میلیون حقوق", +50 million salary).
- Ambiguous message ("خرید طلا" buying gold, "قرض دادم" I lent money): it asks first.
- Every input has a unique ID; a duplicate message is not recorded twice.
- Edit/delete from "Transactions".

### Splitting expenses and excluding from totals ("Advanced settings")
- Three modes: normal, split across several categories, outside the totals.
- Split: each part has its own category, amount and note. Example: 10 million of which 2 million is a gift; the category filter shows only that category's share.
- "👥 Others' share": not counted (for example a dinner your friends will pay for later).
- "Outside the totals": stays in history (struck through) but does not appear in totals, categories, caps, the monthly summary or bot replies. The account balance changes unless "don't touch the balance either" is chosen.
- Excel export: an "In totals" column; splits part by part.

### Categories and caps
- 17 default categories: 13 expense (food, groceries, cafe, transport, car, bills and charges, home, shopping, health, leisure, gifts, installments, other) + 4 income (salary, project, asset sale, other income).
- Custom category: name, symbol, color. Deleting a category -> its expenses move to "Other".
- Monthly cap for each category. Amber above 80%, red once over the cap. Suggestion: the average of the previous two months.
- Keyword categorization ("قهوه" coffee -> cafe, "اسنپ" Snapp -> transport, "قبض برق" electricity bill -> bills and charges).

### Monthly report
- "Everyday spending for the month" card: spending without installments as a percentage of salary + the remainder.
- "Transactions" page: spending (with comparison to the previous month), income, balance, daily average; "Where it went" (pie chart + filter); "Day by day"; month navigation.
- Bot "This month": salary, installments (and the number remaining), spending so far, remainder.
- "Month export": CSV with columns date, type, amount, category, account, note, source (Efficient plan).
- If the totals look low: unconfirmed SMS messages in the queue.

## 3. Bank SMS
- Input: SMS text sent to the bot, pasted into the queue, or an iPhone Shortcuts automation.
- Shortcuts: token under "Connections" (shown only once); a "Message" automation for the bank sender; a "Get Contents of URL" action with POST; header `Authorization: Bearer <token>`; body `{ "text": "<SMS>" }`; "Run Immediately". Not tested on all banks.
- Android: the SMS app is "on the way"; for now, send the text to the bot.
- Amount Rial -> Toman. Approval queue: "Approve" (moves to transactions) / "Delete". Until approved, it appears in no report.
- Detecting a duplicate of a manual expense: "merge suggestion".
- SMS text is kept for up to 500 characters for review.

## 4. Loans and installments
- Shamsi calendar. Types: bank loan, Sayad cheque, SnappPay/DigiPay, phone/car installments, and so on.
- Adding: amount, count, due day; previously paid installments are ticked.
- "Paid" -> that installment's expense is recorded in the ledger.
- "With loan deduction": each loan can be subtracted from net worth or not; it affects only the net worth figure and its chart (not installments or reminders). A purchase installment (for example a car) is never subtracted.
- **Reminders** (only via a connected bot): default time 9 AM Tehran; days before: same day, 1, 2 (default), 3, 5, 7; an "I paid" button; a nightly reminder at 21:30 if no expense was recorded that day; turn off with the "Reminders" tick. SMS reminders are being built.

## 5. Assets
- Types: gold (melted, 18-karat), coins (Emami, Bahar Azadi, half, quarter, gram, Parsian), silver, Tether, crypto, stocks on the Bourse/Farabourse, exchange-traded funds, gold funds (Commodity Exchange), cash. Options and futures are not supported.
- Stocks/funds: search by ticker/name, quantity, purchase price per unit (optional, for profit and loss), "where do you keep it" (brokerage, shown separately).
- Net worth = assets − loans (per "with loan deduction") in Toman, **gold grams** (divided by the price per gram) and dollars; growth compared with inflation.
- **Portfolios** (Efficient 5, Advanced 20): name, color, optional target amount; "All" and "Main" tabs; moving only changes where an item is displayed (average purchase price and profit/loss stay fixed) with "Undo"; deleting a portfolio -> assets go to "Main"; loans/cards/accounts are never in a portfolio. After a downgrade to Basic existing portfolios stay but creating/adding is locked.
- Syncing the gold price with the user's platform ("Settings -> Price sync with platform"): the percentage difference is stored and applied to later prices; more than 40% is rejected; it has "Reset to zero".

## 6. Bale and Telegram bot
- Connecting: "Connections -> Connect Bale/Telegram", send the code with `/start`, confirm "Yes, connect" (name and last 4 digits of the mobile are shown). Disconnect with "قطع" (disconnect).
- Commands: "این ماه" (this month), "اقساط" (installments), "دارایی" (assets: net worth in Toman/gold grams/dollars), "راهنما/سلام/کمک" (help/hello/help); natural questions like "این ماه چقدر خرج کردم؟" (how much did I spend this month?).
- Recording expenses/income and bank SMS (sections 2 and 3).
- Connection confirmation and rate limits on uploads/forms (22 Aban).

## 7. Calculators (`/tools`, no sign-up, nothing stored)
1. **Installment calculator**: principal, annual rate, number of installments, annual inflation.
   - Installment = principal × monthly rate ÷ (1 − (1+monthly rate)^(−n)); monthly rate = annual ÷ 12.
   - Present value of installment n = installment ÷ (1+inflation)^(n÷12); their sum against the loan principal.
   - Example: 100 million, 23%, 24 installments, inflation 40% -> total paid 125.7 million, present value 90.2 million, last installment 51% of today's value.
   - Each installment shown as a "coin" proportional to its value today.
2. **Real loan cost** (`/tools/loan`): is the interest above or below inflation?
3. **Net worth in gold grams**: did you get richer, or did the Toman shrink? (Formula: net worth ÷ gold price per gram, this year compared with last year)
4. **Golden goal**: when will you reach X grams of gold?
5. **Month balance**: how in rhythm is this month with last month?

The inputs and exact formulas for 3 to 5 were not on the site.

## 8. Support and account
- **In-app ticket** ("Support" in the menu): topic (something broke / subscription and payment / account and login / question / suggestion); no title (first line serves); up to 3 images; suggested article while typing; reply in the same ticket + numeric badge + bell + bot message (without the reply text); "My problem is solved" closes it and writing again reopens it; device/version info is automatic; support access to data only with user approval for 24 hours and logged. A password/code/card number is never requested.
- **Contact form**: 8 topics (suggestion, problem, account, subscription and payment, collaboration, media, security report, other); encrypted.
- **Export** full JSON; **account deletion** irreversible (payment receipts remain).
- The "anonymous aggregate usage" tick is off by default; promotional-SMS privacy setting (service SMS cannot be turned off).
- Device list in settings.

## 9. Content
- Journal (6 articles): "What is Taraznama?", "Where does your money go at month end?", "Gold fund or melted gold?", "Did you get richer or did the Toman shrink?", "Is interest-free installment really interest-free?", "Soot/mithqal/gram".
- Useful content notes: soot = 1/1000 gram; 18-karat = 750 per thousand; market melted gold is about 705; mithqal = 4.608 grams; mazaneh = price of one mithqal of melted gold; 18-karat gram ≈ mazaneh ÷ 4.33; ounce = 31.1035 grams.
- Articles link to the tools and features (CTA).
- Help: getting started, daily bookkeeping, assistant and SMS, installments and loans, assets and prices, account and login, data and privacy.

## 10. Technical considerations
- Event-driven architecture: every change is an event; a JSON export of all events.
- Multi-device sync + offline (local storage, later sync).
- Persian sentence parser (Persian/word digits, relative dates, keyword categories).
- Bank SMS parser, Rial to Toman conversion, duplicate detection.
- Reminder scheduler with Tehran time zone.
- Central price service with multi-source fallback and a stale marker.
- Two-platform bot; Telegram needs a server outside Iran.
- SMS: Faraz SMS; payment: Zarinpal.
