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
