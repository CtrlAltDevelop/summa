import { describe, expect, it } from 'vitest';

import { MAX_TILT, emptyAccount, register, tilt } from '../src/balance.js';

describe('tilt', () => {
  it('is level with nothing, or with equal totals', () => {
    expect(tilt(0, 0)).toBe(0);
    expect(tilt(500, 500)).toBe(0);
  });

  it('tips opposite ways for earning more and spending more', () => {
    expect(tilt(900, 100)).toBeGreaterThan(0);
    expect(tilt(100, 900)).toBeLessThan(0);
    expect(tilt(900, 100)).toBeCloseTo(-tilt(100, 900));
  });

  it('never passes its stop, however lopsided', () => {
    expect(Math.abs(tilt(1e12, 1))).toBeLessThanOrEqual(MAX_TILT);
    expect(Math.abs(tilt(1, 1e12))).toBeLessThanOrEqual(MAX_TILT);
  });

  it('grows with the imbalance', () => {
    expect(tilt(600, 400)).toBeLessThan(tilt(900, 100));
  });
});

describe('register', () => {
  it('adds an income and an expense to their own totals', () => {
    let account = emptyAccount();
    account = register(account, { kind: 'income', amount_minor: 500 });
    account = register(account, { kind: 'expense', amount_minor: 200 });

    expect([account.income, account.expense, account.entries.length]).toEqual([500, 200, 2]);
  });

  it('leaves totals alone for a transfer, and never mutates its input', () => {
    const before = emptyAccount();
    const after = register(before, { kind: 'transfer', amount_minor: 900 });

    expect([after.income, after.expense, after.entries.length]).toEqual([0, 0, 1]);
    expect(before.entries).toEqual([]);
  });
});
