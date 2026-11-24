import { convert, loanPayment, monthsToGoal } from './calculators.js';
import { heading } from './content.js';
import { el } from './dom.js';
import { formatDecimal, formatNumber, toLatinDigits } from './format.js';

export const TEXT = {
  title: 'Free tools',
  note: 'No sign-up needed; the results are approximate.',
  loan: 'Loan calculator', amount: 'Loan amount (Toman)', rate: 'Yearly interest (%)', months: 'Number of months',
  payment: 'Monthly payment', total: 'Total paid', interest: 'Total interest',
  goal: 'Savings goal', goalAmount: 'Target amount (Toman)', monthly: 'Saved each month (Toman)', yearsMonths: 'months',
  convert: 'Currency and gold converter', value: 'Amount', from: 'From', to: 'To',
  invalid: 'Check the values above.',
}

const num = (input) => Number(toLatinDigits(input.value.trim()) || NaN);
const field = (label, control) => el('label', {}, el('span', {}, label), control);
const input = () => el('input', { inputmode: 'decimal', dir: 'ltr', autocomplete: 'off' });

function tool(title, inputs, compute) {
  const out = el('p', { class: 'result', 'aria-live': 'polite' });
  const update = () => out.replaceChildren(...compute());
  const form = el('article', { class: 'card glass' }, el('h3', {}, title), ...inputs, out);
  form.addEventListener('input', update);
  return form;
}

/** Each tool is a small form; `compute` returns text nodes for the result line. */
export function renderTools(rates) {
  const [amount, rate, months] = [input(), input(), input()];
  const loan = tool(TEXT.loan, [field(TEXT.amount, amount), field(TEXT.rate, rate), field(TEXT.months, months)], () => {
    const r = loanPayment(num(amount), num(rate) || 0, num(months));
    return [r ? `${TEXT.payment}: ${formatNumber(r.payment)} · ${TEXT.total}: ${formatNumber(r.total)} · ${TEXT.interest}: ${formatNumber(r.interest)}` : TEXT.invalid];
  });
  const [goal, monthly, ret] = [input(), input(), input()];
  const save = tool(TEXT.goal, [field(TEXT.goalAmount, goal), field(TEXT.monthly, monthly), field(TEXT.rate, ret)], () => {
    const n = monthsToGoal(num(goal), num(monthly), num(ret) || 0);
    return [n === null ? TEXT.invalid : `${formatNumber(n)} ${TEXT.yearsMonths}`];
  });
  const known = (rates ?? []).filter((r) => r.known && Number(r.price) > 0);
  const section = [heading(TEXT.title), el('p', { class: 'muted lead-note' }, TEXT.note), el('div', { class: 'grid' }, loan, save, known.length ? converter(known) : null)];
  return el('section', { id: 'tools' }, ...section);
}

function converter(known) {
  const value = input();
  const options = () => known.map((r, i) => el('option', { value: i }, r.name));
  const [from, to] = [el('select', {}, ...options()), el('select', {}, ...options())];
  const pick = (s) => Number(known[s.value].price);
  return tool(TEXT.convert, [field(TEXT.value, value), field(TEXT.from, from), field(TEXT.to, to)], () => {
    const r = convert(num(value), pick(from), pick(to));
    return [r === null ? TEXT.invalid : `${formatDecimal(r, 4)} ${known[to.value].name}`];
  });
}
