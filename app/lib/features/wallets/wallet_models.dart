import '../../core/format/persian.dart';

/// Wallet kinds the server accepts (Iran profile). Values are wire names.
enum WalletKind {
  cash('cash'),
  bank('bank'),
  creditCard('credit_card'),
  bnpl('bnpl'),
  giftCard('gift_card'),
  crypto('crypto'),
  gold('gold');

  const WalletKind(this.wire);
  final String wire;

  /// Kinds that may open with a negative balance (what the user owes).
  bool get allowsDebt => this == creditCard || this == bnpl;

  static WalletKind fromWire(String wire) =>
      values.firstWhere((k) => k.wire == wire, orElse: () => cash);
}

/// Currency code to fractional digits; mirrors the backend profile.
const Map<String, int> currencyDecimals = {
  'IRT': 0,
  'IRR': 0,
  'USD': 2,
  'EUR': 2,
  'AED': 2,
  'TRY': 2,
  'USDT': 2,
};

const baseCurrency = 'IRT';

class Wallet {
  const Wallet({
    required this.id,
    required this.name,
    required this.kind,
    required this.currency,
    required this.bank,
    required this.archived,
    required this.balanceMinor,
  });

  final String id;
  final String name;
  final WalletKind kind;
  final String currency;
  final String bank;
  final bool archived;
  final int balanceMinor;
}

class CurrencyTotal {
  const CurrencyTotal({required this.currency, required this.balanceMinor});

  final String currency;
  final int balanceMinor;
}

class WalletList {
  const WalletList({required this.wallets, required this.totals});

  static const empty = WalletList(wallets: [], totals: []);

  final List<Wallet> wallets;
  final List<CurrencyTotal> totals;

  List<Wallet> get active => wallets.where((w) => !w.archived).toList();
}

enum WalletFailure { invalid, offline, notFound, unknown }

class WalletException implements Exception {
  const WalletException(this.failure);
  final WalletFailure failure;
}

/// `۱٬۵۰۰٫۵۰` style text for an amount in minor units.
String formatMinor(int minor, String currency) {
  final decimals = currencyDecimals[currency] ?? 0;
  if (decimals == 0) return formatNumber(minor);
  final scale = _pow10(decimals);
  final whole = minor.abs() ~/ scale;
  final fraction = (minor.abs() % scale).toString().padLeft(decimals, '0');
  final sign = minor < 0 ? '-' : '';
  return localDigits(
    '$sign${formatNumber(whole).replaceFirst('-', '')}$decimalMark$fraction',
  );
}

/// Parses what the user typed (Persian or Latin digits, `٬`/`,` separators,
/// `.`/`٫` decimal mark) into minor units. Returns null if it is not a number
/// or has more fractional digits than the currency allows.
int? parseMinor(String input, String currency) {
  final decimals = currencyDecimals[currency] ?? 0;
  var text = toLatinDigits(input.trim())
      .replaceAll('٬', '')
      .replaceAll(',', '')
      .replaceAll('٫', '.');
  if (text.isEmpty) return null;
  final negative = text.startsWith('-');
  if (negative) text = text.substring(1);
  final parts = text.split('.');
  if (parts.length > 2 ||
      parts.any((p) => p.isNotEmpty && int.tryParse(p) == null)) {
    return null;
  }
  final whole = parts[0].isEmpty ? '0' : parts[0];
  final fraction = parts.length == 2 ? parts[1] : '';
  if (fraction.length > decimals || (parts[0].isEmpty && fraction.isEmpty)) {
    return null;
  }
  final minor =
      int.parse(whole) * _pow10(decimals) +
      (fraction.isEmpty ? 0 : int.parse(fraction.padRight(decimals, '0')));
  return negative ? -minor : minor;
}

int _pow10(int n) {
  var out = 1;
  for (var i = 0; i < n; i++) {
    out *= 10;
  }
  return out;
}
