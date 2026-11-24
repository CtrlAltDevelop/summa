# Phase 04: Assistant chat and recording by sentence

## Goal
In a private chat the user writes a sentence like «۲۵۰ هزار تومن خرید نان» (250 thousand Toman, bought bread); the assistant understands it and offers a **suggestion card**. The card's "Register" button sends the normal record request from the user's phone. The assistant has no write access to the ledger.

## Dependencies
Phases 02, 02b and 03.

## Scope
**In**
- Backend (`apps.assistant` app): `ChatMessage` (private to each user), gRPC service `AssistantController`: `Send` / `History` / `Clear`.
- **Rule-based Persian parser** (`parser.py`, a pure function with no I/O): Persian/Arabic digits, thousands separators, the units "هزار/میلیون/میلیارد" (thousand/million/billion) and currencies (تومن, ریال, دلار, یورو, درهم, لیر, تتر), expense/income detection from keywords, "دیروز/پریروز/امروز" (yesterday/the day before yesterday/today), category from the keywords of the default categories, wallet from its name or bank, and **transfers** ("از X به Y", i.e. "from X to Y", same currency only).
- The amount must appear **verbatim** in the text (its digits are in the sentence); an amount is never constructed from anything else.
- The assistant's reply is Persian text plus (if it understood) a card: kind, amount, currency, wallet, category, note, time. If it did not understand, it gives guidance and creates no card.
- `Send` is idempotent via `client_mutation_id`; at most 500 characters; rate limit of 30 messages per minute per user; `Clear` truly deletes all the user's messages.
- App: chat screen (bubbles, input, card with a "Register" button). "Register" goes to `LedgerController.Record` (or `Transfer`), nothing else.

**Out**
Language model (Ollama) and SMS parsing (phase 05: the same parser + bank template + Ollama), question answering over data (after 11), streaming replies, automatic deletion of old chats (Celery, phase 15), landing demo (16), numbers written in words («پنجاه هزار», fifty thousand).

## Rules and edges
- The card is only a suggestion; an unknown wallet or category = empty, and the app asks the user.
- A category the user has deleted is not suggested; fall back to "سایر" (Other).
- A transfer between two currencies creates no card; the assistant points to the transfer form.
- Other users' messages are never visible (every query is scoped to the user).

## Tests
Parser: parameterized tables (amount and unit, Persian digits, category, kind, date, wallet, transfer, failures and invalid amount). Service: storing two messages, idempotency, isolation, rate limit, length, clearing. Real gRPC. App: chat widget and registering from a card.

## Acceptance
- [x] «۲۵۰ هزار تومن خرید نان» yields an expense card of 250,000 Toman with the food category.
- [x] "Register" on the card sends the normal record request; the assistant writes nothing.
- [x] "Other user" test and rate-limit test.
- [x] `make check` and `make test` are green.

## Status
- ✅ Backend: `apps.assistant` (`ChatMessage`, `AssistantController` with Send/History/Clear), rule-based Persian parser (39 parameterized tests), rate limit of 30 messages per minute, idempotency, real deletion with `Clear`.
- ✅ App: chat screen, card with a "Register" button that sends the normal `Record`/`Transfer` (with a fixed id per card), wallet picker when the card has no wallet, "yesterday/the day before yesterday" time reaches the server.
- ⚠️ The language model (Ollama) is not installed/connected; only the rule-based parser. Numbers in words («پنجاه هزار») are not supported. The app has not been run on a device.
- Note: the proto field is named `card_present` instead of `has_card`, because `has_card` clashed with `card` in Dart.
- ⏳ Later: Ollama validated by the same parser (05), automatic deletion of old chats (15), question answering over data (after 11).
