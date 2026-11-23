import 'package:shamsi_date/shamsi_date.dart';

const _latinDigits = '0123456789';
const _persianDigits = '۰۱۲۳۴۵۶۷۸۹';
const _arabicDigits = '٠١٢٣٤٥٦٧٨٩';
const _thousandsSeparator = '٬';
const _groupSize = 3;

/// Replaces Latin and Arabic-Indic digits with Persian ones.
String toPersianDigits(String input) {
  final out = StringBuffer();
  for (final rune in input.runes) {
    final ch = String.fromCharCode(rune);
    final latin = _latinDigits.indexOf(ch);
    final arabic = _arabicDigits.indexOf(ch);
    if (latin >= 0) {
      out.write(_persianDigits[latin]);
    } else if (arabic >= 0) {
      out.write(_persianDigits[arabic]);
    } else {
      out.write(ch);
    }
  }
  return out.toString();
}

/// Replaces Persian and Arabic-Indic digits with Latin ones (for parsing).
String toLatinDigits(String input) {
  final out = StringBuffer();
  for (final rune in input.runes) {
    final ch = String.fromCharCode(rune);
    final persian = _persianDigits.indexOf(ch);
    final arabic = _arabicDigits.indexOf(ch);
    if (persian >= 0) {
      out.write(_latinDigits[persian]);
    } else if (arabic >= 0) {
      out.write(_latinDigits[arabic]);
    } else {
      out.write(ch);
    }
  }
  return out.toString();
}

/// Whole number with Persian digits and `٬` thousands separators.
String formatNumber(num value) {
  final negative = value < 0;
  final digits = value.abs().round().toString();
  final groups = <String>[];
  for (var end = digits.length; end > 0; end -= _groupSize) {
    final start = end - _groupSize < 0 ? 0 : end - _groupSize;
    groups.insert(0, digits.substring(start, end));
  }
  final text = groups.join(_thousandsSeparator);
  return toPersianDigits(negative ? '-$text' : text);
}

const _monthNames = [
  'فروردین', 'اردیبهشت', 'خرداد', 'تیر', 'مرداد', 'شهریور',
  'مهر', 'آبان', 'آذر', 'دی', 'بهمن', 'اسفند', //
];

/// `۱۴۰۵/۰۹/۰۱`
String formatJalaliDate(DateTime date) {
  final j = Jalali.fromDateTime(date);
  final month = j.month.toString().padLeft(2, '0');
  final day = j.day.toString().padLeft(2, '0');
  return toPersianDigits('${j.year}/$month/$day');
}

/// `۱ آذر ۱۴۰۵`
String formatJalaliLong(DateTime date) {
  final j = Jalali.fromDateTime(date);
  return toPersianDigits('${j.day} ${_monthNames[j.month - 1]} ${j.year}');
}

/// The Shamsi month containing [moment], as `[start, end)` in UTC.
({DateTime start, DateTime end}) shamsiMonthWindow(DateTime moment) {
  final j = Jalali.fromDateTime(moment);
  final nextYear = j.month == 12 ? j.year + 1 : j.year;
  final nextMonth = j.month == 12 ? 1 : j.month + 1;
  return (
    start: Jalali(j.year, j.month, 1).toDateTime().toUtc(),
    end: Jalali(nextYear, nextMonth, 1).toDateTime().toUtc(),
  );
}

/// Parses `۱۴۰۵/۰۹/۱۵` (any digits, `/` or `-`) into the Gregorian date at
/// local midnight; `null` if it is not a real Shamsi date.
DateTime? parseJalaliDate(String input) {
  final parts = toLatinDigits(input.trim()).split(RegExp('[/-]'));
  if (parts.length != 3) return null;
  final y = int.tryParse(parts[0]);
  final m = int.tryParse(parts[1]);
  final d = int.tryParse(parts[2]);
  if (y == null || m == null || d == null) return null;
  if (m < 1 || m > 12 || d < 1 || d > 31) return null;
  try {
    final date = Jalali(y, m, d).toDateTime();
    final back = Jalali.fromDateTime(date);
    return back.year == y && back.month == m && back.day == d ? date : null;
  } on Object {
    return null;
  }
}

/// `2026-12-06`, the form the backend takes for a plain date.
String isoDate(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

/// A quantity as the server wants it: Latin digits and `.` (never a float).
String quantityText(String input) =>
    toLatinDigits(input.trim())
        .replaceAll('٫', '.')
        .replaceAll(',', '.')
        .replaceAll('٬', '');

/// Persian digits for a decimal quantity such as `0.5` -> `۰٫۵`.
String formatQuantity(String quantity) =>
    toPersianDigits(quantity.replaceAll('.', '٫'));
