import 'package:flutter_test/flutter_test.dart';
import 'package:summa/core/format/persian.dart';

void main() {
  group('toPersianDigits', () {
    test('converts Latin and Arabic-Indic digits', () {
      expect(toPersianDigits('12 ٣٤'), '۱۲ ۳۴');
    });
    test('leaves other characters alone', () {
      expect(toPersianDigits('abc/-'), 'abc/-');
    });
  });

  group('toLatinDigits', () {
    test('converts Persian digits back', () {
      expect(toLatinDigits('۱۴۰۵/۰۹'), '1405/09');
    });
  });

  group('formatNumber', () {
    test('groups thousands with Persian separator and digits', () {
      expect(formatNumber(12850000), '۱۲٬۸۵۰٬۰۰۰');
    });
    test('handles zero and small numbers', () {
      expect(formatNumber(0), '۰');
      expect(formatNumber(999), '۹۹۹');
    });
    test('keeps the sign of negative numbers', () {
      expect(formatNumber(-1500), '-۱٬۵۰۰');
    });
    test('rounds fractions', () {
      expect(formatNumber(1234.6), '۱٬۲۳۵');
    });
  });

  group('Jalali dates', () {
    test('formats a known date', () {
      // 2026-11-22 is 1 Azar 1405.
      final date = DateTime(2026, 11, 22);
      expect(formatJalaliDate(date), '۱۴۰۵/۰۹/۰۱');
      expect(formatJalaliLong(date), '۱ آذر ۱۴۰۵');
    });
  });
}
