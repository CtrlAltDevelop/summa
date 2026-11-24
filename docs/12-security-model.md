# Summa security and privacy model (proposal)

> Personal financial data is sensitive. This document unpacks the conflict between "Ollama on the server" and "end-to-end encryption" and proposes one choice.

## Data classification
| Level | Examples | Behaviour |
|---|---|---|
| Critical | Raw SMS text, notes, app passcode, tokens | Not stored (SMS) or field-level encrypted; never in logs |
| Sensitive | Amount, balance, wallet and bank name, category | Visible only to the user; encrypted at rest; no admin access |
| Normal | Settings, reminder time | Ordinary protection |
| Public | Landing content | Cache and CDN |

## The conflict and the choice
- **End-to-end encryption (E2E):** the server never sees the data, but Ollama, insights, server-side reports and smart sync become practically impossible, and processing has to move to the phone.
- **Proposal (for phase one): limited server-read.** The server sees data for parsing and reports, but:
  1. TLS in transit; disk and backups encrypted;
  2. Field-level encryption for notes and any free text (a separate key per user, with the key held in a KMS/vault separate from the database);
  3. **SMS text is not stored after parsing** (only the structured result); stored only with explicit consent to improve patterns;
  4. Admins and support have no access to financial data; support access only with user approval, for 24 hours, logged;
  5. Logs and error tracking carry no amounts or text (filtered before sending).
- **Future path:** an optional "private mode" that parses on the device (a small local model) for those who do not want text to go to the server. Not built in phase one.
- If the client requires E2E: the architecture of phases 04/05 and the reports must move onto the device; this is a big decision and must be made before building starts.

## Authentication and sessions
- Mobile + OTP, optional password; attempt limits and progressive back-off; identical response for a number with an account and without one (prevents account enumeration).
- Sessions are recorded per device; sign out of all devices; changing the password signs out the rest.
- **App lock** with biometrics (or the in-app passcode) on open and for sensitive operations (data import/export, account deletion).
- (Optional later) bind the token to the device.

## Threats and responses
| Threat | Response |
|---|---|
| User A reads user B's data | User filter in every query + an "other user" test for every service; the user id never comes from the client |
| Injection in SMS text (prompt injection) | Model without tools; schema-validated output; recording only on the user's "Register" |
| Leaks from logs and backups | Logs without amounts/text; encrypted backups; restricted access |
| OTP/SMS abuse | Rate limit, progressive back-off, identical response |
| Phone theft | App lock, hiding amounts on the lock screen and in notifications, remote sign-out |
| Load on Ollama (DoS) | Per-user rate limit, queue, maximum text length, regex first |
| Admin abuse | Roles, access log, no access to financial data |
| Incomplete account deletion | Real deletion from the database and backups on schedule (except payment receipts) |

## Rules and transparency
- A "What is stored and what is not" page in the app and on the landing site; consent before the first SMS is sent to the server; full export and account deletion; no data sales and no ads.
- Terms and privacy policy must get a legal review (the reference also said "needs legal review").
