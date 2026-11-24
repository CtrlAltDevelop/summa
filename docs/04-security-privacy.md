# Security and Privacy

## Encryption and storage
- The content of each entry is encrypted with AES-256-GCM-grade encryption before it is stored. The key is kept separate from the database. Backups are encrypted.
- Name and mobile number stay readable (needed for login).
- Password: scrypt with a random salt. Common passwords or ones based on the mobile number are rejected.
- SMS code, session token, bank SMS token: one-way (hashed).
- Backups: 7 daily, 4 weekly, 3 monthly (up to 3 months).
- A copy of the data for offline work in the browser/phone.
- The hosting provider and the server's country have not been decided.

## Access
- Login with an SMS code; the password is optional.
- The session cookie is not readable from JavaScript; 30 days idle / 90 days total / 8 hours for "this is not my device".
- Device list; changing the password signs out the other devices.
- Rate limit: code valid 5 minutes, 5 guesses, 5 codes per hour per number, progressive lockout from 1 to 60 minutes, 10 wrong codes per day. Counting is by number, connection and service, and survives a restart.
- The response to a code request is identical for a number with an account and one without.
- No advertising trackers in the app. Google Analytics and Microsoft Clarity only on public pages (some fields are masked in Clarity).
- By default, support sees only the name, mobile number and usage statistics; financial data only with the user's temporary permission (up to 24 hours) and with a log of every view.
- Aggregate reporting only with consent (off by default) and a minimum of 5 users.
- The "if the database leaks" table: only the name, mobile number, type and time of each entry.

## Data that is kept
Mobile number, name, password hash, assets/loans/installments/transactions/categories/settings, Bale/Telegram user id and username (if connected), bank SMS text (up to 500 characters), contact-form messages, payment receipts (if subscribed).

## Data that is not collected
Bank password, dynamic password (OTP), full card number, contact list, precise location. There is no bank connection.

## Third parties
- Faraz SMS (فراز اس‌ام‌اس): the number and SMS text.
- Bale/Telegram: the messages sent to the bot.
- ZarinPal (زرین‌پال; Shaparak): amount, order description, mobile number. Card details only on the ZarinPal page; stored: order/transaction id, reference, amount, plan and period, status, fee, masked card, discount code.
- Price sources (Nobitex, Wallex, Gold API and others): they receive no user data.
- Clarity: probably on a Microsoft server outside Iran.

## Waiting list
Mobile number and chosen plan, encrypted, with the consent time; used only for a single notification; a keyed hash prevents duplicates and enables opt-out; unrelated to any account.

## SMS messages
- Service messages (account status, end of trial, price change, outage, security): cannot be turned off.
- News and offers: an unsubscribe link in each message or "Settings -> Privacy". The "no" hash is kept even after the account is deleted.

## User control
Full JSON export; deleting the account and all its data (irreversible except for receipts).

## Vulnerability reporting
The contact form with the subject "Security report"; a request not to disclose before it is fixed.

## "Needs legal review" items (per the site itself)
Draft of the statement and fund referral, the refund policy (undetermined), the official invoice, how long receipts are kept, discount codes, transferring Clarity data abroad, cookie consent.

## Terms of use (summary)
- Governing law: the Islamic Republic of Iran. One account per person, tied to the mobile number.
- Prices come from third-party sources; they may be late or inaccurate; no guarantee.
- "As is"; no uptime guarantee; major changes in the changelog.
- Liability is limited to the extent the law allows; no numeric cap is stated.
- Referral links are labelled; details at `/disclosure`.
