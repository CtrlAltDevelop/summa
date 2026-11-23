/** Pure calculators for the public site. Inputs are plain numbers; bad input -> null. */

const positive = (n) => Number.isFinite(n) && n > 0;

/** Monthly payment of a loan: principal, yearly percent rate (0 = interest-free), months. */
export function loanPayment(principal, yearlyPercent, months) {
  if (!positive(principal) || !positive(months) || !(yearlyPercent >= 0) || !Number.isInteger(months)) return null;
  const monthly = yearlyPercent / 100 / 12;
  const payment = monthly === 0 ? principal / months : (principal * monthly) / (1 - (1 + monthly) ** -months);
  const total = payment * months;
  return { payment, total, interest: total - principal };
}

/** Whole months of saving `monthly` to reach `goal`, with a yearly percent return (0 = none). */
export function monthsToGoal(goal, monthly, yearlyPercent = 0) {
  if (!positive(goal) || !positive(monthly) || !(yearlyPercent >= 0)) return null;
  const rate = yearlyPercent / 100 / 12;
  if (rate === 0) return Math.ceil(goal / monthly);
  return Math.ceil(Math.log(1 + (goal * rate) / monthly) / Math.log(1 + rate));
}

/** Convert between two symbols priced in toman (price per one unit). */
export function convert(amount, fromPrice, toPrice) {
  if (!positive(amount) || !positive(fromPrice) || !positive(toPrice)) return null;
  return (amount * fromPrice) / toPrice;
}
