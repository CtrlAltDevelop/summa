# Sentence and SMS parsing spec (initial proposal)

> Basis for phases 04 and 05. The rules below are the minimum expected behaviour; every rule has a test. Rewritten, partly independent of the reference, not copied.

## 1. Input cleanup
- Normalize digits (Persian, Arabic, English), letters ("ي ك" → "ی ک"; Arabic yeh/kaf to Persian), zero-width non-joiners and extra spaces, and thousands separators (`,` `٬` `،`).
- Strip links and long tracking numbers from the amount finder's input (but keep them for tracing).

## 2. Amount
- **Unit:** "ریال" or "ر" (Rial) → divide by 10 to get Toman; "تومان/تومن/ت" (Toman) no conversion; "هزار تومان" (thousand Toman) ×1000; "میلیون" (million), "میلیارد" (billion); "k" = thousand.
- **Expressions:** "۲ میلیون و ۵۰۰" (2 million and 500), "۲٫۵ میلیون" (2.5 million), "دو و نیم میلیون" (two and a half million), "۲۸۵ هزار" (285 thousand).
- **Ambiguity:** a number without a unit in a sentence → guess from the history of the same category; otherwise the card shows a "Unit?" prompt (Toman / thousand Toman). **Bank SMS** is usually in Rial, but each bank pattern has its own default unit.
- **Not an amount:** time of day (14:30), dates, counts ("۳ نفر", 3 people), card numbers, tracking codes.
- **Golden rule:** the extracted amount must appear verbatim in the input text (after cleanup); otherwise confidence is zero.

## 3. Direction and type
- **Outflow (expense):** withdrawal, purchase, payment, transfer from, fee, installment, top-up (برداشت، خرید، پرداخت، انتقال از، کارمزد، قسط، شارژ).
- **Inflow (income):** deposit, receipt, savings deposit, salary, reversed fee/refund (واریز، دریافت، سپرده، حقوق، کارمزد معکوس/بازگشت).
- Sentence: a leading "+" in the message = income; "برگشت/مرجوعی/پس گرفتم" (returned / refund / I got it back) → suggest a refund against the earlier transaction (phase 06b).
- "انتقال بین حساب‌های خودم" (transfer between my own accounts; card-to-card, Paya, etc.) → suggest a transfer card (phase 02b), not an expense.
- **Ignored:** dynamic/one-time passwords, activation codes, ads, "failed" (ناموفق) SMS, and any message without an amount; a failed message may show a gentle reminder and is not recorded.

## 4. Date and time
- Common Shamsi formats (`۱۴۰۵/۰۹/۰۱`, `۰۹/۰۱`, with time) → UTC using the Asia/Tehran zone.
- Sentence: "دیروز" (yesterday), "پریروز" (the day before yesterday), "شنبه" (Saturday), "اول ماه" (first of the month); no date = now.
- A future date more than 1 day ahead, or a past date more than 1 year back → low confidence.

## 5. Wallet
- Suggest a wallet from the **partial card/account number** (last 4 digits) and the **bank sender**; the user confirms the first time and the mapping is stored.
- If the SMS includes a balance: compare with the computed balance → a difference raises a reconciliation warning.

## 6. Category and merchant
- If a merchant name or keyword is in the text (اسنپ, دیجی‌کالا, …; Snapp, Digikala) → Iran-profile rules → category suggestion.
- User memory: the previous category for the same merchant/pattern takes priority.
- No merchant (the common case for bank SMS) → a "What was this for?" card with 3 suggestions.

## 7. Confidence score and behaviour
| Confidence | Condition | Behaviour |
|---|---|---|
| High | Bank pattern matched, amount, direction and date valid, wallet mapped | Pre-filled card, one tap to "Register" |
| Medium | Generic regex/Ollama only, everything valid | Card with the suspect field highlighted |
| Low | Amount not verbatim in the text, unknown type, implausible date | Empty card for manual completion (or "I didn't understand") |
- No level records **silently**; recording always happens when the user taps "Register" (or a recurring rule the user enabled themselves).
- **Duplicate detection:** amount + wallet + close time (±5 minutes) + direction → "This was already recorded, merge?".

## 8. Sample set and tests
- A folder of samples per bank: `SMS text` → `expected output` (JSON), with names and numbers anonymized.
- CI gate: amount accuracy ≥ 99% and direction ≥ 98% on the sample set (thresholds open to revision with real data); every new model/pattern/prompt is measured before release.
- Negative samples (passwords, ads, failed) → output "ignored".
- Every user-reported error (with consent) becomes a sample.

## 9. Ollama prompt (principles, not text)
- Output is JSON only with a fixed schema; low temperature; the user message is data only, with a clear delimiter; the model has no tools; an invalid response → one retry → "I didn't understand".
- Model choice: small and multilingual with Persian ability; measured on the sample set before choosing; the model version is recorded on every `SmsParse`.
