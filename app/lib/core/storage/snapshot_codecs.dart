import '../../features/categories/category_models.dart';
import '../../features/wallets/entry_models.dart';
import '../../features/wallets/wallet_models.dart';

/// JSON for what the offline cache keeps. Dates are ISO-8601 in UTC.
Map<String, Object?> walletToJson(Wallet w) => {
  'id': w.id,
  'name': w.name,
  'kind': w.kind.wire,
  'currency': w.currency,
  'bank': w.bank,
  'archived': w.archived,
  'balance': w.balanceMinor,
};

Wallet walletFromJson(Map<String, Object?> j) => Wallet(
  id: j['id']! as String,
  name: j['name']! as String,
  kind: WalletKind.fromWire(j['kind']! as String),
  currency: j['currency']! as String,
  bank: j['bank']! as String,
  archived: j['archived']! as bool,
  balanceMinor: j['balance']! as int,
);

Object walletListToJson(WalletList l) => {
  'wallets': l.wallets.map(walletToJson).toList(),
  'totals': [
    for (final t in l.totals)
      {'currency': t.currency, 'balance': t.balanceMinor},
  ],
};

WalletList walletListFromJson(Object? raw) {
  final j = raw! as Map<String, Object?>;
  return WalletList(
    wallets: [
      for (final w in j['wallets']! as List<Object?>)
        walletFromJson(w! as Map<String, Object?>),
    ],
    totals: [
      for (final t in j['totals']! as List<Object?>)
        CurrencyTotal(
          currency: (t! as Map<String, Object?>)['currency']! as String,
          balanceMinor: (t as Map<String, Object?>)['balance']! as int,
        ),
    ],
  );
}

Object entriesToJson(List<Entry> entries) => [
  for (final e in entries)
    {
      'id': e.id,
      'walletId': e.walletId,
      'kind': e.kind.wire,
      'amount': e.amountMinor,
      'currency': e.currency,
      'at': e.occurredAt.toUtc().toIso8601String(),
      'note': e.note,
      'category': e.categoryId,
      'outside': e.outsideTotals,
      'split': e.splitId,
      'refundOf': e.refundOf,
      'refunded': e.refundedMinor,
    },
];

List<Entry> entriesFromJson(Object? raw) => [
  for (final item in raw! as List<Object?>)
    Entry(
      id: (item! as Map<String, Object?>)['id']! as String,
      walletId: (item as Map<String, Object?>)['walletId']! as String,
      kind: EntryKind.fromWire(item['kind']! as String),
      amountMinor: item['amount']! as int,
      currency: item['currency']! as String,
      occurredAt: DateTime.parse(item['at']! as String),
      note: item['note']! as String,
      categoryId: item['category']! as String,
      outsideTotals: item['outside']! as bool,
      splitId: item['split']! as String,
      refundOf: item['refundOf']! as String,
      refundedMinor: item['refunded']! as int,
    ),
];

Object categoriesToJson(List<Category> categories) => [
  for (final c in categories)
    {'id': c.id, 'name': c.name, 'kind': c.kind.wire, 'other': c.isOther},
];

List<Category> categoriesFromJson(Object? raw) => [
  for (final item in raw! as List<Object?>)
    Category(
      id: (item! as Map<String, Object?>)['id']! as String,
      name: (item as Map<String, Object?>)['name']! as String,
      kind: CategoryKind.fromWire(item['kind']! as String),
      isOther: item['other']! as bool,
    ),
];
