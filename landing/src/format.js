const PERSIAN = '۰۱۲۳۴۵۶۷۸۹';
const THOUSANDS = '٬';
const DECIMAL = '٫';

/** Latin digits -> Persian digits. */
export function toPersianDigits(text) {
  return String(text).replace(/\d/g, (d) => PERSIAN[Number(d)]);
}

/** Persian and Arabic-Indic digits (and the Persian separators) -> plain ASCII. */
export function toLatinDigits(text) {
  return String(text)
    .replace(/[۰-۹]/g, (d) => String(PERSIAN.indexOf(d)))
    .replace(/[٠-٩]/g, (d) => String(d.charCodeAt(0) - 0x0660))
    .replaceAll(THOUSANDS, '')
    .replaceAll(DECIMAL, '.');
}

/** 1500000 -> ۱٬۵۰۰٬۰۰۰ (whole numbers; negative keeps its sign). */
export function formatNumber(value) {
  const rounded = Math.round(Number(value));
  const sign = rounded < 0 ? '-' : '';
  const digits = String(Math.abs(rounded)).replace(/\B(?=(\d{3})+(?!\d))/g, THOUSANDS);
  return toPersianDigits(sign + digits);
}

/** A decimal number with at most `places` fractional digits, in Persian digits. */
export function formatDecimal(value, places = 2) {
  const [whole, fraction = ''] = Number(value).toFixed(places).split('.');
  const trimmed = fraction.replace(/0+$/, '');
  const head = formatNumber(whole);
  return trimmed ? `${head}${DECIMAL}${toPersianDigits(trimmed)}` : head;
}
