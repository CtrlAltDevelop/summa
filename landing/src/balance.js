/** How far the scale may tip, in radians (about 20 degrees). */
export const MAX_TILT = 0.35;

/**
 * The beam's angle for a pair of totals. Equal totals sit level; spending more
 * than the income tips one way, earning more the other. The curve is soft so a
 * big number does not slam the beam to its stop.
 * @param {number} income
 * @param {number} expense
 */
export function tilt(income, expense) {
  const total = income + expense;
  if (total <= 0) return 0;
  const share = (income - expense) / total; // -1 .. 1
  return Math.tanh(share * 1.5) * MAX_TILT;
}

/** A fresh sample account: nothing recorded yet. */
export function emptyAccount() {
  return { income: 0, expense: 0, entries: [] };
}

/**
 * The account after a suggestion card is registered. Pure: returns a new
 * account. Transfers do not change the totals.
 * @param {{income:number, expense:number, entries:object[]}} account
 * @param {{kind:string, amount_minor:number}} card
 */
export function register(account, card) {
  const next = { ...account, entries: [...account.entries, card] };
  if (card.kind === 'income') next.income += card.amount_minor;
  if (card.kind === 'expense') next.expense += card.amount_minor;
  return next;
}
