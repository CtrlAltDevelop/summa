# Phase 05: Bank SMS

## Goal
The user pastes the text of a bank SMS; the app understands the amount, direction, card, balance and time, suggests a wallet from the last 4 digits of the card, and asks "what was it for?" with 3 suggested categories. Registering always happens when the user taps "Register".

## Dependencies
Phases 02, 03 and 04 (sentence parser, categories).

## Scope
**In**
- Backend (`apps.assistant` app): a pure `SmsParser` (`sms_parser.py`), Shamsi date conversion (`calendar.py`, Asia/Tehran time zone), the `ParseSms` and `LinkCard` services on `AssistantController`, the `SmsCardLink` model (last 4 digits → wallet).
- **The SMS text is not stored**; only the structured result is returned to the app and only the card → wallet mapping is kept.
- Rules (per `docs/11-parsing-spec.md`): amount verbatim in the text; default currency is Rial (divided by 10 for a Toman wallet; if not divisible = low confidence); balance, time, card number and date are not counted as the amount; direction from a keyword or a `+`/`-` sign; **ignored**: dynamic/one-time passwords, failed transactions, ads, messages without an amount.
- Confidence: high (everything valid and the wallet mapped), medium (unknown wallet or no date), low (unknown direction, amount not convertible, implausible date).
- **Duplicate detection:** same wallet, same amount, same direction, ±5 minutes → the existing transaction id.
- 3 suggested categories: from keywords in the text, otherwise the user's own most-used categories, otherwise the defaults.
- **Ollama (optional):** when `DJANGO_ASSISTANT_LLM_URL` is set and the regex understands nothing, the model's JSON output is **validated** against a schema and the same "amount in text" rule, and its confidence is at most medium. With it unset there are no network calls at all.
- App: "SMS" screen: paste text, result card, wallet choice (and saving the mapping), 3 categories, duplicate warning, a "Register" button (the same `Record`).

**Out**
Automatic intake from share-intent/notifications (native Android/iOS code), reading SMS in the full version, a real sample set per bank and a CI accuracy gate (real data is needed), detecting transfers between the user's own accounts, refunds (06b).

## Rules and edges
- A date more than 1 day in the future or more than 1 year in the past → low confidence. No date → now.
- The last 4 digits must be exactly 4 digits; the mapping is only for the user's own wallet (`NOT_FOUND` for others').
- At most 1000 characters; the same rate limit as chat.

## Tests
Parser (parameterized tables: SMS kinds, ignored cases, amount versus balance/time/card, Shamsi date), calendar conversion, service (mapping, confidence, duplicates, category suggestion, isolation), LLM validator with a fake transport, real gRPC, app.

## Acceptance
- [x] Common withdrawal/deposit/purchase SMS samples are understood correctly.
- [x] Dynamic passwords, failed transactions and ads are not registrable.
- [x] The wallet is suggested from the last 4 digits and remembered after confirmation.
- [x] Duplicates are detected; the SMS text is stored nowhere.
- [x] `make check` and `make test` are green.

## Status
- ✅ Backend: pure SMS parser (24 tests), Shamsi → Tehran UTC conversion, `ParseSms`/`LinkCard`, card → wallet mapping, confidence, duplicates, 3 suggested categories, the SMS text is not stored.
- ✅ LLM (Ollama) validator with a schema, the "amount in text" rule, one retry and a transport tested against a local server; without `DJANGO_ASSISTANT_LLM_URL` there are no network calls. **Not run against a real model** (Ollama is not installed on this machine).
- ✅ App: "SMS" screen (paste → card → wallet/kind/category → "Register") and saving the card mapping.
- ⚠️ The bank templates are generic and were checked against synthetic samples; a real sample set per bank and a CI accuracy gate need customer data. Automatic intake (share-intent/notification) and Android SMS reading are not built (native code).
- ⏳ Later: refunds (06b), hooking into notifications (07c/15).
