import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/app.dart';
import 'package:summa/features/assets/asset_controller.dart';
import 'package:summa/features/networth/networth_controller.dart';
import 'package:summa/features/billing/billing_controller.dart';
import 'package:summa/features/auth/auth_controller.dart';
import 'package:summa/features/auth/auth_models.dart';
import 'package:summa/features/auth/token_store.dart';
import 'package:summa/features/categories/category_controller.dart';
import 'package:summa/features/recurring/recurring_controller.dart';
import 'package:summa/features/assistant/assistant_controller.dart';
import 'package:summa/features/debts/debt_controller.dart';
import 'package:summa/features/wallets/ledger_controller.dart';
import 'package:summa/features/wallets/wallets_controller.dart';

import '../categories/fake_category_api.dart';
import '../wallets/fake_ledger_api.dart';
import '../wallets/fake_wallet_api.dart';
import '../billing/fake_billing_api.dart';
import '../networth/fake_networth_api.dart';
import '../assets/fake_asset_api.dart';
import '../recurring/fake_recurring_api.dart';
import '../debts/fake_debt_api.dart';
import '../assistant/fake_assistant_api.dart';
import 'fake_auth_api.dart';

Future<MemoryTokenStore> _pump(
  WidgetTester tester,
  FakeAuthApi api, {
  Tokens? stored,
}) async {
  // Tall enough that the whole home list (and its sign-out button) is built.
  tester.view.physicalSize = const Size(800, 8000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final store = MemoryTokenStore(stored);
  final wallets = FakeWalletApi();
  final ledger = FakeLedgerApi(wallets);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authApiProvider.overrideWithValue(api),
        tokenStoreProvider.overrideWithValue(store),
        recurringApiProvider.overrideWithValue(FakeRecurringApi()),
        assistantApiProvider.overrideWithValue(FakeAssistantApi()),
        debtApiProvider.overrideWithValue(FakeDebtApi()),
        assetApiProvider.overrideWithValue(FakeAssetApi()),
        networthApiProvider.overrideWithValue(FakeNetWorthApi()),
        billingApiProvider.overrideWithValue(FakeBillingApi()),
        walletApiProvider.overrideWithValue(wallets),
        ledgerApiProvider.overrideWithValue(ledger),
        categoryApiProvider.overrideWithValue(FakeCategoryApi(ledger)),
      ],
      child: const SummaApp(),
    ),
  );
  await tester.pumpAndSettle();
  return store;
}

void main() {
  testWidgets('new person: phone, code, name, then home', (t) async {
    final api = FakeAuthApi();
    final store = await _pump(t, api);

    expect(find.text('ورود به سومّا'), findsOneWidget);
    await t.enterText(find.byType(TextField), '۰۹۱۲۳۴۵۶۷۸۹');
    await t.tap(find.text('ارسال کد'));
    await t.pumpAndSettle();
    expect(api.calls, contains('start:۰۹۱۲۳۴۵۶۷۸۹'));
    expect(find.text('کد تأیید'), findsOneWidget);

    await t.enterText(find.byType(TextField), '۱۲۳۴۵۶');
    await t.pumpAndSettle();
    expect(find.text('اسمت چیه؟'), findsOneWidget);
    expect(await store.read(), isNotNull);

    await t.enterText(find.byType(TextField), 'سارا');
    await t.tap(find.text('ادامه'));
    await t.pumpAndSettle();
    expect(find.text('سلام سارا'), findsOneWidget);
  });

  testWidgets('existing person goes straight to home after the code', (
    t,
  ) async {
    final api = FakeAuthApi(profileName: 'رضا');
    await _pump(t, api);

    await t.enterText(find.byType(TextField), '09123456789');
    await t.tap(find.text('ارسال کد'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField), '123456');
    await t.pumpAndSettle();

    expect(find.text('سلام رضا'), findsOneWidget);
  });

  testWidgets('a short number is refused without calling the server', (
    t,
  ) async {
    final api = FakeAuthApi();
    await _pump(t, api);

    await t.enterText(find.byType(TextField), '0912');
    await t.tap(find.text('ارسال کد'));
    await t.pumpAndSettle();

    expect(find.textContaining('این شماره درست نیست'), findsOneWidget);
    expect(api.calls, isEmpty);
  });

  testWidgets('a wrong code shows an error and clears the field', (t) async {
    final api = FakeAuthApi();
    await _pump(t, api);
    await t.enterText(find.byType(TextField), '09123456789');
    await t.tap(find.text('ارسال کد'));
    await t.pumpAndSettle();

    await t.enterText(find.byType(TextField), '000000');
    await t.pumpAndSettle();

    expect(find.textContaining('کد درست نیست'), findsOneWidget);
    expect(t.widget<TextField>(find.byType(TextField)).controller!.text, '');
  });

  testWidgets('too many requests shows the waiting message', (t) async {
    final api = FakeAuthApi()..startFailure = AuthFailure.tooMany;
    await _pump(t, api);

    await t.enterText(find.byType(TextField), '09123456789');
    await t.tap(find.text('ارسال کد'));
    await t.pumpAndSettle();

    expect(find.textContaining('تلاش‌ها زیاد بود'), findsOneWidget);
  });

  testWidgets('resend unlocks after the countdown', (t) async {
    final api = FakeAuthApi();
    await _pump(t, api);
    await t.enterText(find.byType(TextField), '09123456789');
    await t.tap(find.text('ارسال کد'));
    await t.pumpAndSettle();

    expect(find.textContaining('ارسال دوباره تا'), findsOneWidget);
    await t.pump(const Duration(seconds: 61));

    expect(find.text('ارسال دوباره کد'), findsOneWidget);
    await t.tap(find.text('ارسال دوباره کد'));
    await t.pump();
    expect(api.calls.where((x) => x.startsWith('start:')), hasLength(2));
    await t.pump(const Duration(seconds: 61));
  });

  testWidgets('a stored session opens home directly', (t) async {
    final api = FakeAuthApi(profileName: 'سارا');
    await _pump(t, api, stored: api.currentTokens);
    expect(find.text('سلام سارا'), findsOneWidget);
  });

  testWidgets('offline at start offers a retry', (t) async {
    final api = FakeAuthApi(profileName: 'سارا')
      ..meFailure = AuthFailure.offline;
    await _pump(t, api, stored: api.currentTokens);
    expect(find.textContaining('اتصال برقرار نشد'), findsOneWidget);

    api.meFailure = null;
    await t.tap(find.text('تلاش دوباره'));
    await t.pumpAndSettle();
    expect(find.text('سلام سارا'), findsOneWidget);
  });

  testWidgets('sign out returns to the login screen', (t) async {
    final api = FakeAuthApi(profileName: 'سارا');
    final store = await _pump(t, api, stored: api.currentTokens);

    await t.tap(find.text('خروج'));
    await t.pumpAndSettle();

    expect(find.text('ورود به سومّا'), findsOneWidget);
    expect(await store.read(), isNull);
  });
}
