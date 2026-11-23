import { describe, expect, it } from 'vitest';

import { formatDecimal, formatNumber, toLatinDigits, toPersianDigits } from '../src/format.js';

describe('digits', () => {
  it('turns Latin digits into Persian ones', () => {
    expect(toPersianDigits('0123456789')).toBe('۰۱۲۳۴۵۶۷۸۹');
    expect(toPersianDigits('۱۲ and 3')).toBe('۱۲ and ۳');
  });

  it('turns Persian and Arabic digits and separators back to ASCII', () => {
    expect(toLatinDigits('۱۲٬۵۰۰٫۵')).toBe('12500.5');
    expect(toLatinDigits('٠١٢٣٤٥٦٧٨٩')).toBe('0123456789');
  });

  it('round-trips', () => {
    expect(toLatinDigits(toPersianDigits('9876543210'))).toBe('9876543210');
  });
});

describe('formatNumber', () => {
  it.each([
    [0, '۰'],
    [999, '۹۹۹'],
    [1000, '۱٬۰۰۰'],
    [1500000, '۱٬۵۰۰٬۰۰۰'],
    [-2500, '-۲٬۵۰۰'],
    [12.6, '۱۳'],
  ])('%s -> %s', (value, expected) => {
    expect(formatNumber(value)).toBe(expected);
  });
});

describe('formatDecimal', () => {
  it.each([
    [1.5, 2, '۱٫۵'],
    [2, 2, '۲'],
    [1234.567, 2, '۱٬۲۳۴٫۵۷'],
    [30, 0, '۳۰'],
  ])('%s with %s places -> %s', (value, places, expected) => {
    expect(formatDecimal(value, places)).toBe(expected);
  });
});
