import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/app.dart';
import 'package:summa/features/auth/auth_controller.dart';
import 'package:summa/features/auth/token_store.dart';
import 'package:summa/features/categories/category_controller.dart';
import 'package:summa/features/wallets/entry_models.dart';
import 'package:summa/features/recurring/recurring_controller.dart';
import 'package:summa/features/wallets/ledger_controller.dart';
import 'package:summa/features/wallets/wallet_models.dart';
import 'package:summa/features/wallets/wallets_controller.dart';

import '../auth/fake_auth_api.dart';
import '../recurring/fake_recurring_api.dart';
import '../categories/fake_category_api.dart';
import 'fake_ledger_api.dart';
import 'fake_wallet_api.dart';

Wallet _wallet(String id, String name) => Wallet(
  id: id,
  name: name,
  kind: WalletKind.bank,
  currency: 'IRT',
  bank: '',
  archived: false,
  balanceMinor: 1000000,
);

Future<({FakeLedgerApi ledger, FakeWalletApi wallets})> _pump(
  WidgetTester t,
) async {
  t.view.physicalSize = const Size(800, 6000);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  final wallets = FakeWalletApi()
    ..wallets.addAll([_wallet('w1', 'ملی من'), _wallet('w2', 'نقد من')]);
  final ledger = FakeLedgerApi(wallets)
    ..entries.add(
      Entry(
        id: 'e1',
        walletId: 'w1',
        kind: EntryKind.expense,
        amountMinor: 400000,
        currency: 'IRT',
        occurredAt: DateTime.utc(2026, 11, 1),
        note: 'کفش',
      ),
    );
  wallets.shift('w1', -400000);
  final auth = FakeAuthApi(profileName: 'سارا');
  await t.pumpWidget(
    ProviderScope(
      overrides: [
        authApiProvider.overrideWithValue(auth),
        tokenStoreProvider.overrideWithValue(
          MemoryTokenStore(auth.currentTokens),
        ),
        recurringApiProvider.overrideWithValue(FakeRecurringApi()),
        walletApiProvider.overrideWithValue(wallets),
        ledgerApiProvider.overrideWithValue(ledger),
        categoryApiProvider.overrideWithValue(FakeCategoryApi(ledger)),
      ],
      child: const SummaApp(),
    ),
  );
  await t.pumpAndSettle();
  return (ledger: ledger, wallets: wallets);
}

void main() {
  testWidgets('an empty amount refunds everything that is left', (t) async {
    final s = await _pump(t);

    await t.tap(find.text('برگشت'));
    await t.pumpAndSettle();
    expect(find.text('قابل برگشت: ۴۰۰٬۰۰۰ تومان'), findsOneWidget);
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    final refund = s.ledger.entries.firstWhere(
      (e) => e.kind == EntryKind.refund,
    );
    expect((refund.amountMinor, refund.refundOf), (400000, 'e1'));
    expect(s.wallets.wallets.first.balanceMinor, 1000000);
    expect(find.textContaining('برگشت‌خورده'), findsOneWidget);
    expect(find.text('برگشت'), findsNothing); // nothing left to refund
  });

  testWidgets('a partial refund can go to another wallet', (t) async {
    final s = await _pump(t);

    await t.tap(find.text('برگشت'));
    await t.pumpAndSettle();
    await t.tap(find.text('نقد من').last);
    await t.enterText(find.byType(TextField).at(0), '۱۰۰٬۰۰۰');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(s.wallets.wallets.map((w) => w.balanceMinor), [600000, 1100000]);
    expect(find.text('برگشت'), findsOneWidget); // 300k still refundable
  });

  testWidgets('more than what is left is refused before the server', (t) async {
    final s = await _pump(t);

    await t.tap(find.text('برگشت'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).at(0), '۵۰۰٬۰۰۰');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(find.textContaining('مبلغ برگشت درست نیست'), findsOneWidget);
    expect(s.ledger.entries.where((e) => e.kind == EntryKind.refund), isEmpty);
  });

  testWidgets('a refund shows as a credit and has no refund button', (t) async {
    await _pump(t);
    await t.tap(find.text('برگشت'));
    await t.pumpAndSettle();
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(find.text('+۴۰۰٬۰۰۰ تومان'), findsOneWidget);
    expect(find.text('برگشت وجه'), findsOneWidget); // the refund entry's label
  });
}
