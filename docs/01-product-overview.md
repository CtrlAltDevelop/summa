# Reference product overview (Taraznama)

> This file describes the reference product, not Summa. Our project is named **Summa**.

## Identity
- **Taraznama (ترازنما)**: personal accounting plus asset and installment management. Tagline: "Expenses, installments and assets, in one place."
- Currently in a free trial period. It is not a wallet, an exchange, a lender or an investment advisor; it has no buying or selling and gives no buy advice.
- It does not connect to banks and does not collect bank passwords.
- Founder: Mohammad Faramarznia (personal letter on the About page). Holds an eNamad trust seal. First release: 11 Mehr 1405.
- Audience: Iranians aged 24 to 41 with installments/loans/cheques, assets in gold/Tether/crypto/stock market, and who track monthly spending.

## Platforms
- PWA web app (installable on iPhone/Android/desktop, offline, syncs after reconnecting).
- Bale and Telegram bot (Telegram usually needs a VPN).
- Bank SMS (iPhone Shortcuts; an Android SMS app is "on the way").
- No native app.

## Site map
| Path | Content |
|---|---|
| `/` | Landing: problem, three steps, features, calculator, security, comparison, testimonials, pricing, FAQ |
| `/prices` | Live prices + converter + coin/crypto/gold-fund table |
| `/tools` | 5 calculators, no sign-up |
| `/bot` | Introduction to the Bale/Telegram assistant with an interactive sample |
| `/pricing` | Plans, waitlist |
| `/journal` | Journal (6 articles) |
| `/help` | 7 sections, 22 articles |
| `/login`, `/dashboard` | Login and the app |
| `/install` | PWA install guide |
| `/changelog` | 92 change entries |
| `/status` | Service status (ping every 30 seconds) |
| `/contact` | Contact form (8 topics, 4000 characters) |
| `/about`, `/security`, `/privacy`, `/terms`, `/disclosure` | About and legal pages |

## Main features (five tools)
| Feature | Status |
|---|---|
| Asset wallet with live prices | Live |
| Installment calendar with reminders | Live |
| Bookkeeping (categories, caps) | Live |
| Taraznama AI (Persian Q&A over the user's own data) | In development |
| Shared family ledger (up to 4 people) | In development |

## Plans
The trial period is free for now. After launch: a 14-day free trial of the Efficient plan without a card. Payment monthly, quarterly (10% less), or yearly (4 months free). Prices are in Toman including VAT. Price increases are announced 14 days ahead.

| Feature | Basic | Efficient (recommended) | Advanced (soon) |
|---|---|---|---|
| Asset wallet with live prices | ✅ | ✅ | ✅ |
| Net worth (Toman/gold gram/dollar) | ✅ | ✅ | ✅ |
| Loans and installments | up to 3 active | unlimited | unlimited |
| App/Bale/Telegram reminders | ✅ | ✅ | ✅ |
| Bookkeeping and budget | manual only | ✅ | ✅ |
| Automatic entry (SMS, bot, Shortcuts, sentence) | ❌ | ✅ | ✅ |
| CSV export | ❌ | ✅ | ✅ |
| Goal portfolios | ❌ | 5 | 20 |
| SMS reminders | ❌ | in progress | in progress |
| Excel import | ❌ | ❌ | in progress |
| Taraznama AI | ❌ | ❌ | in progress |
| AI monthly summary and unusual-spending detection | ❌ | ❌ | in progress |
| AI automatic categorization | ❌ | ❌ | in progress |
| Shared family ledger (4 people) | ❌ | ❌ | in progress |

### Prices (unclear)
- Yearly: 1,590 / 3,190 / 6,900 thousand Toman. Founder price for Advanced: 6,900 thousand Toman a year for the first 200 people on the waitlist.
- Monthly is written on the page as "133199 / 266399 / 575990 thousand Toman"; probably about 133, 266 and 576 thousand Toman. Needs confirmation.

## Subscription rules (draft, "needs legal review")
- Payment via Zarinpal, no auto-renewal; each payment buys a fixed number of days.
- After the subscription ends the account becomes read-only; data is not deleted; export is still possible.
- Plan change: remaining days carry over. Account deletion: no refund for remaining days.
- Refunds: policy not yet set. Official invoices are not issued yet.
- Discount codes apply only to subscription purchases (not the trial period).

## Revenue model
Subscription plus labelled referral links (fee comparison of gold platforms: Milli, Melli Gold, Talasi). No ads and no selling data. Referral details on `/disclosure` were not read.

## Change history (highlights)
- 11 Mehr: first release (ledger, SMS queue, loans/installments, live assets, bot, offline, encrypted storage)
- 12 Mehr: full website, contact form, SMS login; login via bot removed
- 16 Mehr: stock market and funds, 20 gold funds
- 22 Mehr: rebrand ("Qestyar" -> "Taraznama Assistant", "Tools" -> "Calculators")
- 3 Aban: coins
- 13 Aban: gold fallback order; configurable reminder time
- 16 Aban: split expenses and excluded-from-totals
- 17 Aban: loans without deduction from net worth
- 18 Aban: portfolios
- 22 Aban: bot connection confirmation
- 23 Aban: "Regulars"
- 26 Aban: in-app support ticket
