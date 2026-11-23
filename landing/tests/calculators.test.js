import { describe, expect, it } from 'vitest';
import { convert, loanPayment, monthsToGoal } from '../src/calculators.js';

describe('loanPayment', () => {
  it('splits an interest-free loan evenly', () => {
    expect(loanPayment(1200, 0, 12)).toEqual({ payment: 100, total: 1200, interest: 0 });
  });
  it('matches the annuity formula', () => {
    const r = loanPayment(100000, 12, 12);
    expect(r.payment).toBeCloseTo(8884.88, 2);
    expect(r.interest).toBeCloseTo(r.total - 100000, 6);
  });
  it.each([[0, 1, 1], [100, -1, 12], [100, 1, 0], [100, 1, 1.5], [NaN, 1, 1]])('rejects %s', (...a) => {
    expect(loanPayment(...a)).toBeNull();
  });
});

describe('monthsToGoal', () => {
  it('rounds up without a return', () => expect(monthsToGoal(1000, 300)).toBe(4));
  it('needs fewer months with a return', () => expect(monthsToGoal(1000, 300, 24)).toBeLessThanOrEqual(4));
  it('rejects bad input', () => {
    expect(monthsToGoal(0, 1)).toBeNull();
    expect(monthsToGoal(1, 0)).toBeNull();
    expect(monthsToGoal(1, 1, -5)).toBeNull();
  });
});

describe('convert', () => {
  it('goes through the toman price', () => expect(convert(2, 100, 50)).toBe(4));
  it('rejects unknown prices', () => {
    expect(convert(1, 0, 5)).toBeNull();
    expect(convert(1, 5, NaN)).toBeNull();
  });
});
