import 'package:flutter_test/flutter_test.dart';
import 'package:summa/features/wallets/wallet_models.dart';

void main() {
  group('parseMinor', () {
    test('whole toman with Persian digits and separators', () {
      expect(parseMinor('۱٬۵۰۰٬۰۰۰', 'IRT'), 1500000);
    });
    test('dollars keep two fractional digits', () {
      expect(parseMinor('12.5', 'USD'), 1250);
      expect(parseMinor('۱۲٫۰۵', 'USD'), 1205);
    });
    test('negative amounts parse', () {
      expect(parseMinor('-500', 'IRT'), -500);
    });
    test('too many fractional digits is refused', () {
      expect(parseMinor('1.234', 'USD'), isNull);
      expect(parseMinor('1.5', 'IRT'), isNull);
    });
    test('garbage is refused', () {
      expect(parseMinor('abc', 'IRT'), isNull);
      expect(parseMinor('1.2.3', 'USD'), isNull);
      expect(parseMinor('', 'IRT'), isNull);
      expect(parseMinor('.', 'USD'), isNull);
    });
  });

  group('formatMinor', () {
    test('groups whole units in Persian', () {
      expect(formatMinor(1500000, 'IRT'), '۱٬۵۰۰٬۰۰۰');
    });
    test('shows fractional digits for dollars', () {
      expect(formatMinor(1205, 'USD'), '۱۲٫۰۵');
      expect(formatMinor(-5, 'USD'), '-۰٫۰۵');
    });
    test('amounts beyond 32 bits keep every digit', () {
      expect(formatMinor(50000000000, 'IRT'), '۵۰٬۰۰۰٬۰۰۰٬۰۰۰');
    });
  });

  test('only credit card and BNPL may open in debt', () {
    expect(WalletKind.creditCard.allowsDebt, isTrue);
    expect(WalletKind.bnpl.allowsDebt, isTrue);
    expect(WalletKind.cash.allowsDebt, isFalse);
  });
}
