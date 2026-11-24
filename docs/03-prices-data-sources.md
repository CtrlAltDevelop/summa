# Price sources

Refresh: every 1 minute from all sources simultaneously. If one source is down, the others take over.

| Asset | Source and rule |
|---|---|
| Tether and crypto | **Median** of Nobitex, Wallex, Bitpin; for Tether, Tetherland as well |
| Gold and silver ounce | Gold API; for gold, PAXG if it is down |
| 18-karat gold | Milli -> TGJU -> Tehran Gold and Jewelry Union -> Alanchand (the first source that responds) |
| Coins | TGJU -> Union -> Alanchand (first response) |
| Silver | Silver ounce x Tether |
| Stocks and funds | Closing price from the Tehran Stock Exchange trading system; every 2 minutes during market hours; outside market hours, the price of the last trading day |
| Gold funds | Iran Commodity Exchange (20 funds, such as Tala, Ayar, Kahroba, Zar) |

## Fallback when all domestic gold sources are down
18-karat gram price = global ounce (USD) ÷ 31.1035 × 0.75 × Tether (Toman). The domestic market premium is not included, so it differs from the real price.

## If all sources for one price are down
The last price is kept and shown as "a few minutes ago" (stale).

## Syncing with the user's platform
The percentage difference is stored and applied to later prices. More than 40% is rejected (likely a typo). "Reset to zero" removes the difference.

## The `/prices` page
- Converter: Toman, 10 million, 100 million, 1 billion, gold grams, 100 Tether.
- Board for 18-karat gold / Tether / silver with history.
- Table: Emami coin, Bahar Azadi, half, quarter, gram coin, gold ounce, silver ounce, BTC, ETH, SOL, XRP, BNB, TRX, DOGE, ADA, NOT, SHIB with 24-hour change.
- "Gold funds, today" table and how closely each tracks the gold price.
- Fee comparison of gold platforms (Milli 0.5%, Melli Gold 0.8%, Talasi 0.7% in the home page sample; sample figures). Referral links are labelled.

## Cost note
All of these sources are unofficial or public APIs and may have limits or costs; they must be budgeted separately in the project estimate.
