# Summa Open Questions (flow by flow)

The (foreign) client said the app must be completely different from Taraznama but, in the end, still personal accounting. Record the answers here.

Note: the client is international, so the localisation questions (languages, currency, target country, calendar, price sources, bank SMS, a messenger instead of Bale/Telegram) must be settled in section zero.

## Zero: Framework
1. What does "a different shape" mean? Only UI/brand, or the logic and product idea too?
   - **Answer:** everything is different (UI, brand, logic and idea); many new features are coming and some parts are not wanted at all.
   - **Bot:** removed entirely (no Bale, no Telegram, no Eitaa). Flow 6 is dropped.
   - **Bank SMS:** the app reads the SMS messages itself and analyses the amount and transaction automatically from the bank SMS. The user is only asked "What was this purchase for?". That means no manual amount entry, and Taraznama's confirmation queue gives its place to this flow. (Affects flows 3 and 2)
2. What should **not** be in Taraznama's feature set?
   - **Answer (phasing):** phase one is similar to Taraznama in features; new features and bigger differences come in later phases.
   - Phase-one exceptions: no bot, and bank SMS is read automatically (not manual entry).
   - Look and brand are completely different from Taraznama from phase one (only the phase-one features are similar).
   - No precise "what should not exist" list beyond these has been given yet.
3. What should be **added**?
   - Set aside for now; phase one is executed first.
4. Audience: Iranian? Persian and Shamsi only?
   - **Answer:** the target country is Iran only and the language is Persian only (right-to-left, Shamsi). Multiple currencies and wallet types were kept.
   - **Wallet:** during account creation each user creates wallets with any currency; several wallets per currency are possible (for example Toman in 3 banks with 3 separate balances, or cash). When a wallet is created, the initial balance in that currency is asked. The "accounting box" (calculation box) shows all wallets in one place. When recording an expense, it is specified which wallet (currency and bank) it comes from. The app is bookkeeping only and no money moves. Even so, there is a "money management" option in the expenses section: transfers between banks or cash↔bank, with an optional fee; for currency conversion, the user enters the rate and the fee.
   - **Backend:** Django + grpcio.
   - **Update (1404/09/03 — 2026-11-24):** the client said the product language should become English and that support for users outside Iran should be added to all parts of the app in a later phase. Phase 19 (English and LTR) and phase 19b (country profile) were created; "Iran only / Persian only" is no longer a permanent restriction. The working language of docs and code is English from now on; the existing Persian docs are translated on request.
5. Platform: PWA, native app, Bale/Telegram/Eitaa bot?
   - **Decided:** one Flutter app (one codebase for web, mobile and desktop) + a gRPC backend + a separate landing site to introduce the product. A bot and a separate PWA are not part of this decision; if a bot is needed, ask again in flow 6.
6. Is the revenue model and plans the same or different?

## Flow 1: Sign-up and login
- Are mobile + OTP enough, or also email/Google/password? Should the optional password stay?
- Is login through the bot (which Taraznama removed) needed?
- SMS service? Should the limits stay the same?
- A multi-step onboarding?

## Flow 2: Recording expenses and income
- Is entry with a Persian sentence needed? Parser with an LLM or rule-based?
- Are the categories just these 17? Custom categories and limits?
- Splitting an expense, others' shares, excluded from totals?
- "Always-on items" (recurring) and offline entry?
- How many accounts/cards and balances?

## Flow 3: Bank SMS
- Is it needed at all? (expensive in support)
- iPhone with Shortcuts, Android with the SMS app, or manual paste?
- Confirmation queue or direct recording?
- The list of supported banks?

## Flow 4: Loans and installments
- Kinds of debt? Fields? An automatic schedule with an interest rate or a fixed amount?
- Reminders through which channels and how many days before?
- Deducting loans from net worth and the exception for purchase installments?

## Flow 5: Assets and prices
- Kinds of assets? (gold, coins, silver, Tether, crypto, stocks, funds, property, vehicles)
- Price source? Free or paid API? (an ongoing cost)
- Display in grams of gold/dollars and comparison with inflation?
- Target portfolio? Sync with the platform's price? Profit and loss?

## Flow 6: Bot
- **Decision:** there is no messenger bot (Bale/Telegram/Eitaa). Instead there is an **in-app assistant chat** (private to each user; the assistant makes suggestions with a confirmation card, and only the app itself writes to the server after the user confirms). Details in phase 04.
- The rest of this flow's questions are dropped unless they become necessary again.
- Bale, Telegram, or both? Eitaa?
- Only recording and reporting, or AI too? Inline buttons?

## Flow 7: Reports and analysis
- Monthly report, charts, balance (تراز)? CSV and Excel export/import?
- Summary and unusual-spending detection with AI?

## Flow 8: Tools and content
- Public tools for SEO? A public live price? Magazine and help? Who writes the content?

## Flow 9: Payment and subscription
- Gateway? Number of plans? Trial period? Auto-renewal? Invoice and VAT? Referral/partner?

## Flow 10: Support, privacy and admin
- In-app tickets? Contact form? Export and account deletion?
- Admin panel? Temporary support access? Logs, monitoring and a status page?

## After the wrap-up
Scheduling, phasing, requirements and a cost estimate.
