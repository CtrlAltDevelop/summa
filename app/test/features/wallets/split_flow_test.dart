import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/app.dart';
import 'package:summa/features/auth/auth_controller.dart';
import 'package:summa/features/auth/token_store.dart';
import 'package:summa/features/categories/category_controller.dart';
import 'package:summa/features/recurring/recurring_controller.dart';
import 'package:summa/features/assistant/assistant_controller.dart';
import 'package:summa/features/debts/debt_controller.dart';
import 'package:summa/features/wallets/ledger_controller.dart';
import 'package:summa/features/wallets/wallet_models.dart';
import 'package:summa/features/wallets/wallets_controller.dart';

import '../auth/fake_auth_api.dart';
import '../recurring/fake_recurring_api.dart';
import '../debts/fake_debt_api.dart';
import '../assistant/fake_assistant_api.dart';
import '../categories/fake_category_api.dart';
import 'fake_ledger_api.dart';
import 'fake_wallet_api.dart';

Future<({FakeLedgerApi ledger, FakeWalletApi wallets, FakeCategoryApi cats})>
_pump(WidgetTester t) async {
  t.view.physicalSize = const Size(800, 6000);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  final wallets = FakeWalletApi()
    ..wallets.add(
      const Wallet(
        id: 'w1',
        name: 'ملی من',
        kind: WalletKind.bank,
        currency: 'IRT',
        bank: '',
        archived: false,
        balanceMinor: 1000000,
      ),
    );
  final ledger = FakeLedgerApi(wallets);
  final cats = FakeCategoryApi(ledger);
  final auth = FakeAuthApi(profileName: 'سارا');
  await t.pumpWidget(
    ProviderScope(
      overrides: [
        authApiProvider.overrideWithValue(auth),
        tokenStoreProvider.overrideWithValue(
          MemoryTokenStore(auth.currentTokens),
        ),
        recurringApiProvider.overrideWithValue(FakeRecurringApi()),
        assistantApiProvider.overrideWithValue(FakeAssistantApi()),
        debtApiProvider.overrideWithValue(FakeDebtApi()),
        walletApiProvider.overrideWithValue(wallets),
        ledgerApiProvider.overrideWithValue(ledger),
        categoryApiProvider.overrideWithValue(cats),
      ],
      child: const SummaApp(),
    ),
  );
  await t.pumpAndSettle();
  return (ledger: ledger, wallets: wallets, cats: cats);
}

void main() {
  testWidgets('a split records each part and charges the sum', (t) async {
    final s = await _pump(t);

    await t.tap(find.text('تقسیم خرج'));
    await t.pumpAndSettle();
    final fields = find.byType(TextField);
    await t.enterText(fields.at(0), '۳۰۰٬۰۰۰');
    await t.enterText(fields.at(1), '۱۰۰٬۰۰۰');
    await t.pumpAndSettle();
    expect(find.text('جمع: ۴۰۰٬۰۰۰ تومان'), findsOneWidget);
    await t.tap(find.text('بیرون از جمع').last); // second part: others' share
    await t.pumpAndSettle();
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(s.ledger.entries.map((e) => e.amountMinor), [300000, 100000]);
    expect(s.ledger.entries.map((e) => e.outsideTotals), [false, true]);
    expect(s.ledger.entries.map((e) => e.splitId).toSet(), hasLength(1));
    expect(s.wallets.wallets.single.balanceMinor, 600000);
    expect(find.textContaining('تقسیم‌شده'), findsWidgets);
  });

  testWidgets('a part can be added and every part needs an amount', (t) async {
    final s = await _pump(t);

    await t.tap(find.text('تقسیم خرج'));
    await t.pumpAndSettle();
    await t.tap(find.text('افزودن بخش'));
    await t.pumpAndSettle();
    expect(find.text('بخش ۳'), findsOneWidget);
    await t.enterText(find.byType(TextField).at(0), '۱۰۰');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(find.textContaining('حداقل دو بخش'), findsOneWidget);
    expect(s.ledger.entries, isEmpty);
  });

  testWidgets('an expense outside the totals leaves the budget alone', (
    t,
  ) async {
    final s = await _pump(t);
    s.cats.limits['c-food'] = ('IRT', 1000);

    await t.tap(find.text('ثبت خرج یا درآمد'));
    await t.pumpAndSettle();
    await t.tap(find.text('خوراک'));
    await t.tap(find.text('بیرون از جمع'));
    await t.enterText(find.byType(TextField).at(0), '۵۰۰');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(s.ledger.entries.single.outsideTotals, isTrue);
    expect(s.wallets.wallets.single.balanceMinor, 999500);
    final budgets = await s.cats.budgets(
      'a',
      start: DateTime(2026),
      end: DateTime(2027),
    );
    expect(budgets.single.spentMinor, 0);
    expect(find.textContaining('بیرون از جمع'), findsWidgets);
  });

  testWidgets('income has no outside-the-totals choice', (t) async {
    await _pump(t);

    await t.tap(find.text('ثبت خرج یا درآمد'));
    await t.pumpAndSettle();
    expect(find.text('بیرون از جمع'), findsOneWidget);
    await t.tap(find.text('درآمد'));
    await t.pumpAndSettle();

    expect(find.text('بیرون از جمع'), findsNothing);
  });
}
