# Phase 19b: Country profiles (beyond Iran)

## Goal
A user outside Iran can run the app with their own currency, calendar, bank
list and price sources, instead of the single hard-coded Iran profile.

## Dependencies
19 (English and LTR), 01b (wallets), 05 (bank SMS), 09 (assets and prices).

## Scope
**In**
- Generalize the existing Iran config into a `CountryProfile`: default
  currency, calendar, wallet types, bank list, SMS template pack, price and FX
  sources, number format. Iran becomes one row, not the only shape.
- Profile chosen at signup (default from the device region), changeable later
  in settings.
- Calendar per profile: Gregorian alongside Shamsi, including month boundaries
  for monthly budgets, recurring transactions and reports.
- Banks and SMS templates per profile; a profile may ship with none.
- FX and asset price sources per profile, refreshed by the same Celery beat
  job; still approximate, still backend-only.
- Admin: profiles editable the way the Iran config already is.

**Out** (other phases)
- Payment gateways and billing outside Iran — extends phase 13, its own phase.
- Tax, legal or regulatory text per country.
- Asset classes that do not already exist in phase 09.
- Automatic SMS reading on Android for a new country's banks — extends 05.

## Interfaces
- proto: `CountryProfile` message, `GetCountryProfiles` / `GetCountryProfile`
  RPCs, `country` on user settings next to `locale`.
- App: country row in settings; wallet creation reads wallet types and banks
  from the active profile; date pickers read the calendar from it.
- Backend: the parser selects its template pack by profile; the price service
  selects its sources by profile.

## Rules and edges
- Changing country never rewrites existing wallets, currencies or past
  transactions. Base currency stays the user's own choice, independent of the
  profile's default.
- A profile with no SMS templates degrades to manual entry and says so; it
  does not fail silently or guess with another country's regexes.
- A profile with no price source for an asset class hides that class rather
  than showing a stale or wrong number.
- Monthly periods follow the profile's calendar; a user who switches calendars
  keeps past periods as they were recorded.
- The amount-appears-verbatim rule for parsing holds for every profile.

## Security and privacy
- Profiles are config, not user data; a user reads profiles but writes only
  their own `country` field.
- Outbound price and FX requests carry no user identity, for any profile.
- Raw SMS text is still not stored by default, whatever the profile.

## Tests
- Unit: calendar conversion and month boundaries for both calendars;
  profile-driven formatting.
- Parser: each shipped template pack, plus the no-templates fallback.
- Integration: switching country leaves existing wallets and history intact.
- Isolation: one user's profile change is invisible to another user.
- Price service: a profile with a missing source degrades, not crashes.

## Acceptance
- [ ] Iran is a profile row, with no Iran-specific branch left in app code.
- [ ] A second profile ships and is usable end to end.
- [ ] Gregorian calendar correct for budgets, recurring entries and reports.
- [ ] No-templates and no-price-source paths degrade with a clear message.
- [ ] Switching country does not alter stored money or history.
- [ ] `make check` and `make test` green.
