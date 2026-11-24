import { describe, expect, it } from 'vitest';

import { TEXT, renderPlans, renderRates } from '../src/prices.js';
import { prefersReducedMotion } from '../src/motion.js';

const rate = (over) => ({ symbol: 'USD', name: 'دلار', unit: 'دلار', price: '61000', known: true, stale: false, ...over });

describe('prices', () => {
  it('shows a known price in toman', () => {
    const table = renderRates([rate()]);

    expect(table.querySelector('th').textContent).toBe('دلار (دلار)');
    expect(table.querySelector('td').textContent).toBe(`61,000 ${TEXT.toman}`);
  });

  it('says unknown instead of showing zero', () => {
    const table = renderRates([rate({ known: false, price: '' })]);

    expect(table.querySelector('td').textContent).toBe(TEXT.unknown);
    expect(table.textContent).not.toContain('۰ ');
  });

  it('marks an old price', () => {
    expect(renderRates([rate({ stale: true })]).querySelector('td.muted').textContent).toBe(TEXT.stale);
    expect(renderRates([rate()]).querySelector('td.muted').textContent).toBe('');
  });

  it('always carries the not-an-exchange note', () => {
    expect(renderRates([]).textContent).toContain('not an exchange');
  });

  it('lists the plans from the admin with their price and period', () => {
    const section = renderPlans([{ name: 'ماهانه', description: 'همه امکانات', price_minor: 150000, period_days: 30 }]);

    expect(section.querySelector('h3').textContent).toBe('ماهانه');
    expect(section.querySelector('.price').textContent).toBe(`150,000 ${TEXT.toman} · 30 ${TEXT.days}`);
    expect(section.textContent).toContain('همه امکانات');
  });

  it('says plans are coming when none are on sale', () => {
    for (const plans of [[], null, undefined]) {
      expect(renderPlans(plans).textContent).toContain(TEXT.soon);
    }
  });
});

describe('prefersReducedMotion', () => {
  it('follows the system setting and is false without matchMedia', () => {
    expect(prefersReducedMotion({ matchMedia: () => ({ matches: true }) })).toBe(true);
    expect(prefersReducedMotion({ matchMedia: () => ({ matches: false }) })).toBe(false);
    expect(prefersReducedMotion({})).toBe(false);
    expect(prefersReducedMotion(undefined)).toBe(false);
  });
});
