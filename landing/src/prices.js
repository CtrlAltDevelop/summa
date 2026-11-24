import { heading } from './content.js';
import { el } from './dom.js';
import { formatDecimal, formatNumber } from './format.js';

export const TEXT = {
  rates: "Today's prices",
  ratesNote: 'Prices are approximate. Summa is not an exchange and gives no buy or sell advice.',
  unknown: 'Unknown',
  stale: 'Stale',
  plans: 'Plans',
  soon: 'Plans are coming soon.',
  toman: 'Toman',
  days: 'days',
};

/** The price table. A symbol with no known price says so instead of showing 0. */
export function renderRates(rates) {
  const rows = (rates ?? []).map((r) =>
    el(
      'tr',
      {},
      el('th', { scope: 'row' }, `${r.name} (${r.unit})`),
      el('td', {}, r.known ? `${formatNumber(Number(r.price))} ${TEXT.toman}` : TEXT.unknown),
      el('td', { class: 'muted' }, r.known && r.stale ? TEXT.stale : ''),
    ),
  );
  return el(
    'section',
    { id: 'prices' },
    heading(TEXT.rates),
    el('div', { class: 'glass block' }, el('table', {}, el('tbody', {}, ...rows))),
    el('p', { class: 'muted' }, TEXT.ratesNote),
  );
}

/** Plans come from the admin; with none on sale the section says "soon". */
export function renderPlans(plans) {
  const body = plans?.length
    ? el(
        'div',
        { class: 'grid' },
        ...plans.map((p) =>
          el(
            'article',
            { class: 'card glass' },
            el('h3', {}, p.name),
            el('p', { class: 'price' }, `${formatNumber(p.price_minor)} ${TEXT.toman} · ${formatDecimal(p.period_days, 0)} ${TEXT.days}`),
            p.description ? el('p', {}, p.description) : null,
          ),
        ),
      )
    : el('p', { class: 'muted' }, TEXT.soon);
  return el('section', { id: 'plans' }, heading(TEXT.plans), body);
}
