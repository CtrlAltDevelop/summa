# Phase 14: Support

## Goal
The user opens a support ticket from inside the app and sees their own conversation with the team and can reply.

## Dependencies
Phase 01.

## Scope
**In**
- Backend: the ready-made `apps.support` app (tickets and chat, admin, SLA, categories, four transports) is used; it was **only switched on**: `DJANGO_SUPPORT_ENABLED=true` in `.env.example`, the proto in the Dart list (`DART_PROTOS`) and an integration test for a Summa user (open a ticket, conversation, isolation between two users, subject and body required). The "who sees what" rules (internal team messages, someone else's ticket = `NOT_FOUND`) are the ones the app's own tests cover.
- App: a "Support" page (the user's own tickets with status, last-message date and a "new message" badge), a new-ticket form (subject and body), a conversation page (user and support messages, replying).

**Out**
Live chat (WebSocket) and new-message notifications (need push), attachments and uploads, rating, ticket categorization by the user, a **public contact form for people without an account** (on the landing site, phase 16), the support agent panel (it is the Django admin).

## Rules and edges
- Each ticket is visible and writable only to its owner; others get `NOT_FOUND`.
- A ticket without a subject or without a body = `INVALID_ARGUMENT`.
- With the subscription read-only mode (phase 13), opening a ticket is **not possible**, because `Open`/`Send` are writes; this is unfortunate for an account that needs to renew (it has to contact us through another channel). Decision: in phase 13 "support" was not added to the list of reads because the `apps.support` module is separate from the billing rules; **needs a client decision** (can an expired account open a ticket?). Until then `BILLING_ENFORCED` is off.

## Tests
Backend: three integration tests with a Summa login. App: widgets (empty list, opening a ticket, validation, error, conversation and reply, support message and unread badge).

## Acceptance
- [x] The user opens a ticket and replies.
- [x] Another user cannot see their ticket or write in it.
- [x] `make check` and `make test` are green.

## Implementation status
- ✅ Backend switched on with three integration tests; app: list, new ticket, conversation.
- ⚠️ No notifications and no live chat; the app has not been run on a device.
