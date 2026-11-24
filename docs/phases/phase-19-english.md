# Phase 19: English and LTR

## Goal
A user who does not read Persian can use the app and the landing site in
English, with a left-to-right layout, without losing anything the Persian UI
offers.

## Dependencies
00 (l10n scaffolding and design system), 16 (landing), 16b (landing CMS).

## Scope
**In**
- A second locale `en` next to `fa`: `app/lib/l10n/app_en.arb` complete, no
  missing keys, no Persian left in widgets.
- Locale picker in settings, plus first-run default from the device locale;
  the choice is stored per user and survives reinstall.
- Directionality follows the locale (`TextDirection.rtl` for `fa`,
  `ltr` for `en`) with no restart; every screen checked in both.
- Digits, dates, decimal and thousand separators follow the locale, not the
  wallet currency.
- Landing: `en` values in the existing CMS `values` map, a language switch,
  `<html lang dir>` set per locale, English `title`/`description` per page.
- Assistant chat and SMS parsing answer in the user's locale; the parser
  itself stays Persian-only until 19b brings non-Iran SMS templates.
- Project docs and code comments are written in English from here on.

**Out** (other phases)
- Any third language.
- Currency, calendar, banks or price sources per country — phase 19b.

## Interfaces
- proto: `locale` on the user settings message, returned by the profile RPC
  and accepted by the update RPC; server-generated text (notifications, SMS
  parse results, assistant replies) honours it.
- App: settings screen gains a language row; `MaterialApp.locale` driven by it.
- Landing: `?lang=en` / `#/en`, and the CMS API returns all locales so the
  client can switch without a round trip.
- Push notifications and emails render in the stored locale.

## Rules and edges
- Money is formatted by wallet currency; everything else by locale. Changing
  the language never changes a stored amount or currency.
- Shamsi stays the calendar for `fa`. The Gregorian option belongs to 19b, so
  an `en` user before 19b still sees Shamsi dates — state this in the UI.
- A missing `en` string is a build failure, not a silent fallback to Persian.
- Offline: the locale is local state, applied before the first sync.
- Reduced motion, font fallback and line-height rules apply to the Latin font
  as they do to Vazirmatn.

## Security and privacy
- The locale is per-user settings data, isolated like every other user field;
  one user's locale is never readable by another.
- No new data is collected. The device locale is read once on first run and
  not sent anywhere beyond the stored setting.

## Tests
- Unit: formatting (dates, digits, separators) in both locales.
- l10n: a test that fails when `app_en.arb` is missing a key `app_fa.arb` has.
- Widget: golden or layout tests for the main screens in LTR.
- Integration: changing the locale updates server-generated text on the next
  response.
- Isolation: a second user's locale change does not affect the first.
- Landing: `content.js` tests extended for an `en` value and for the switch.

## Acceptance
- [ ] `app_en.arb` complete; the missing-key test passes.
- [ ] Every screen reviewed in LTR; no clipped or mirrored-wrong layout.
- [ ] Locale survives restart and reinstall-with-login.
- [ ] Server text (notifications, assistant, parse results) arrives in English.
- [ ] Landing switches language without a reload and sets `lang`/`dir`.
- [ ] Dates, digits and separators correct in both locales.
- [ ] `make check` and `make test` green.

## Status
Done in the app: `app_en.arb` (parity test), a locale controller with a
device-locale first-run default and a language row in Privacy and security,
RTL/LTR following the locale, and locale-aware digits, separators and Shamsi
month names. The existing Persian docs are translated.
Not done yet: the proto `locale` field and server-generated text in English,
the per-user (reinstall-surviving) locale, the landing language switch, and an
LTR layout review of every screen.
