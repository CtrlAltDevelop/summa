import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summa/features/auth/setup_prompt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/app.dart';
import 'package:summa/features/assets/asset_controller.dart';
import 'package:summa/features/networth/networth_controller.dart';
import 'package:summa/features/billing/billing_controller.dart';
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
import '../wallets/fake_ledger_api.dart';
import '../wallets/fake_wallet_api.dart';
import '../billing/fake_billing_api.dart';
import '../networth/fake_networth_api.dart';
import '../assets/fake_asset_api.dart';
import 'fake_category_api.dart';

Future<({FakeLedgerApi ledger, FakeCategoryApi categories})> _pump(
  WidgetTester t,
) async {
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
  final categories = FakeCategoryApi(ledger);
  // Tall enough that the whole home list is built.
  t.view.physicalSize = const Size(800, 4000);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  final auth = FakeAuthApi(profileName: 'سارا');
  await t.pumpWidget(
    ProviderScope(
      overrides: [
        setupPromptEnabledProvider.overrideWithValue(false),
        authApiProvider.overrideWithValue(auth),
        tokenStoreProvider.overrideWithValue(
          MemoryTokenStore(auth.currentTokens),
        ),
        recurringApiProvider.overrideWithValue(FakeRecurringApi()),
        assistantApiProvider.overrideWithValue(FakeAssistantApi()),
        debtApiProvider.overrideWithValue(FakeDebtApi()),
        assetApiProvider.overrideWithValue(FakeAssetApi()),
        networthApiProvider.overrideWithValue(FakeNetWorthApi()),
        billingApiProvider.overrideWithValue(FakeBillingApi()),
        walletApiProvider.overrideWithValue(wallets),
        ledgerApiProvider.overrideWithValue(ledger),
        categoryApiProvider.overrideWithValue(categories),
      ],
      child: const SummaApp(),
    ),
  );
  await t.pumpAndSettle();
  return (ledger: ledger, categories: categories);
}

Future<void> _record(WidgetTester t, String amount, {String? category}) async {
  await t.tap(find.text('ثبت خرج یا درآمد'));
  await t.pumpAndSettle();
  if (category != null) {
    await t.tap(find.text(category));
    await t.pumpAndSettle();
  }
  await t.enterText(find.byType(TextField).at(0), amount);
  await t.tap(find.text('ذخیره'));
  await t.pumpAndSettle();
}

void main() {
  testWidgets('an entry defaults to the "other" category', (t) async {
    final s = await _pump(t);

    await _record(t, '۱۰۰');

    expect(s.ledger.entries.single.categoryId, 'c-other');
  });

  testWidgets('choosing a category records it and shows its name', (t) async {
    final s = await _pump(t);

    await _record(t, '۱۰۰', category: 'خوراک');

    expect(s.ledger.entries.single.categoryId, 'c-food');
    expect(find.textContaining('خوراک'), findsOneWidget);
  });

  testWidgets('switching to income offers the income categories', (t) async {
    final s = await _pump(t);

    await t.tap(find.text('ثبت خرج یا درآمد'));
    await t.pumpAndSettle();
    await t.tap(find.text('درآمد'));
    await t.pumpAndSettle();
    await t.tap(find.text('حقوق'));
    await t.enterText(find.byType(TextField).at(0), '۵۰۰');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(s.ledger.entries.single.categoryId, 'c-salary');
  });

  testWidgets('a limit shows a bar that warns, then goes over', (t) async {
    final s = await _pump(t);
    await _record(t, '۸۵', category: 'خوراک');

    await t.tap(find.text('دسته‌ها و سقف ماهانه'));
    await t.pumpAndSettle();
    await t.tap(find.text('سقف').first);
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).at(0), '۱۰۰');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();
    t.state<NavigatorState>(find.byType(Navigator)).pop();
    await t.pumpAndSettle();

    expect(s.categories.limits['c-food'], ('IRT', 100));
    expect(find.text('سقف این ماه'), findsOneWidget);
    expect(find.textContaining('نزدیک سقفی'), findsOneWidget);

    await _record(t, '۲۰', category: 'خوراک');

    expect(find.textContaining('از سقف گذشتی'), findsOneWidget);
  });

  testWidgets('a new category is added and a custom one can be deleted', (
    t,
  ) async {
    final s = await _pump(t);

    await t.tap(find.text('دسته‌ها و سقف ماهانه'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).at(0), 'سفر');
    await t.tap(find.text('افزودن · دسته‌های خرج'));
    await t.pumpAndSettle();

    expect(s.categories.categories.map((c) => c.name), contains('سفر'));

    await t.ensureVisible(find.text('سفر'));
    await t.tap(find.text('حذف').first);
    await t.pumpAndSettle();

    expect(
      s.categories.categories.map((c) => c.name),
      isNot(contains('خوراک')),
    );
  });

  testWidgets('"other" has no delete action', (t) async {
    await _pump(t);

    await t.tap(find.text('دسته‌ها و سقف ماهانه'));
    await t.pumpAndSettle();

    // expense: food + other, income: salary + other-in -> two deletable rows
    expect(find.text('حذف'), findsNWidgets(2));
  });

  testWidgets('a duplicate name shows the error', (t) async {
    await _pump(t);

    await t.tap(find.text('دسته‌ها و سقف ماهانه'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).at(0), 'خوراک');
    await t.tap(find.text('افزودن · دسته‌های خرج'));
    await t.pumpAndSettle();

    expect(find.textContaining('نام دسته درست نیست'), findsOneWidget);
  });
}
