import { describe, expect, it } from 'vitest';

import { formatDecimal, formatMoney, formatNumber, toLatinDigits } from '../src/format.js';

describe('toLatinDigits', () => {
  it('turns Persian and Arabic digits and separators into ASCII', () => {
    expect(toLatinDigits('۱۲٬۵۰۰٫۵')).toBe('12500.5');
    expect(toLatinDigits('٠١٢٣٤٥٦٧٨٩')).toBe('0123456789');
  });

  it('drops the English thousands separator so a pasted amount parses', () => {
    expect(toLatinDigits('1,500,000')).toBe('1500000');
  });

  it('leaves plain numbers alone', () => {
    expect(toLatinDigits('9876543210')).toBe('9876543210');
  });
});

describe('formatNumber', () => {
  it.each([
    [0, '0'],
    [999, '999'],
    [1000, '1,000'],
    [1500000, '1,500,000'],
    [-2500, '-2,500'],
    [12.6, '13'],
  ])('%s -> %s', (value, expected) => {
    expect(formatNumber(value)).toBe(expected);
  });
});

describe('formatDecimal', () => {
  it.each([
    [1.5, 2, '1.5'],
    [2, 2, '2'],
    [1234.567, 2, '1,234.57'],
    [30, 0, '30'],
  ])('%s with %s places -> %s', (value, places, expected) => {
    expect(formatDecimal(value, places)).toBe(expected);
  });
});

describe('formatMoney', () => {
  it('puts the unit after the amount', () => {
    expect(formatMoney(1500000)).toBe('1,500,000 Toman');
    expect(formatMoney(12, 'USD')).toBe('12 USD');
  });
});
