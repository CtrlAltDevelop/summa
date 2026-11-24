import { LOCALE } from './locale.js';

const PERSIAN = '۰۱۲۳۴۵۶۷۸۹';
const formatters = new Map();

const formatter = (places) => {
  const key = String(places);
  if (!formatters.has(key)) formatters.set(key, new Intl.NumberFormat(LOCALE, { maximumFractionDigits: places }));
  return formatters.get(key);
};

/**
 * Persian and Arabic-Indic digits (and their separators) -> plain ASCII, so a
 * pasted amount parses whatever keyboard it was typed on.
 */
export function toLatinDigits(text) {
  return String(text)
    .replace(/[۰-۹]/g, (d) => String(PERSIAN.indexOf(d)))
    .replace(/[٠-٩]/g, (d) => String(d.charCodeAt(0) - 0x0660))
    .replaceAll('٬', '')
    .replaceAll('٫', '.')
    .replaceAll(',', '');
}

/** 1500000 -> 1,500,000 (whole numbers; negative keeps its sign). */
export function formatNumber(value) {
  return formatter(0).format(Math.round(Number(value)));
}

/** A number with at most `places` fractional digits; trailing zeros dropped. */
export function formatDecimal(value, places = 2) {
  return formatter(places).format(Number(value));
}

/** A money amount with its unit, e.g. "1,500,000 Toman". */
export function formatMoney(value, unit = 'Toman') {
  return `${formatNumber(value)} ${unit}`;
}
