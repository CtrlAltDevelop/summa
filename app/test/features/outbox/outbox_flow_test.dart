import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/app.dart';
import 'package:summa/features/assets/asset_controller.dart';
import 'package:summa/features/auth/auth_controller.dart';
import 'package:summa/features/auth/token_store.dart';
import 'package:summa/features/categories/category_controller.dart';
import 'package:summa/features/networth/networth_controller.dart';
import 'package:summa/features/wallets/ledger_controller.dart';
import 'package:summa/features/wallets/wallet_models.dart';
import 'package:summa/features/wallets/wallets_controller.dart';

import '../assets/fake_asset_api.dart';
import '../auth/fake_auth_api.dart';
import '../categories/fake_category_api.dart';
import '../networth/fake_networth_api.dart';
import '../wallets/fake_ledger_api.dart';
import '../wallets/fake_wallet_api.dart';

Future<FakeLedgerApi> _pump(WidgetTester t) async {
  t.view.physicalSize = const Size(800, 12000);
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
  final auth = FakeAuthApi(profileName: 'سارا');
  await t.pumpWidget(
    ProviderScope(
      overrides: [
        authApiProvider.overrideWithValue(auth),
        tokenStoreProvider.overrideWithValue(
          MemoryTokenStore(auth.currentTokens),
        ),
        walletApiProvider.overrideWithValue(wallets),
        ledgerApiProvider.overrideWithValue(ledger),
        categoryApiProvider.overrideWithValue(FakeCategoryApi(ledger)),
        assetApiProvider.overrideWithValue(FakeAssetApi()),
        networthApiProvider.overrideWithValue(FakeNetWorthApi()),
      ],
      child: const SummaApp(),
    ),
  );
  await t.pumpAndSettle();
  return ledger;
}

Future<void> _recordOffline(WidgetTester t, FakeLedgerApi ledger) async {
  ledger.offline = true;
  await t.tap(find.text('ثبت خرج یا درآمد'));
  await t.pumpAndSettle();
  await t.enterText(find.byType(TextField).at(0), '۱۰۰٬۰۰۰');
  await t.enterText(find.byType(TextField).at(1), 'نان');
  await t.tap(find.text('ذخیره'));
  await t.pumpAndSettle();
}

void main() {
  testWidgets('with no connection the entry is queued, not lost', (t) async {
    final ledger = await _pump(t);

    await _recordOffline(t, ledger);

    expect(ledger.entries, isEmpty);
    expect(find.text('تراکنش در انتظار ارسال: ۱'), findsOneWidget);
    expect(
      find.textContaining('نان · ۱۰۰٬۰۰۰ تومان · در انتظار ارسال'),
      findsOneWidget,
    );
    expect(find.text('ارسال دوباره'), findsOneWidget);
  });

  testWidgets('retrying after the connection is back sends it exactly once', (
    t,
  ) async {
    final ledger = await _pump(t);
    await _recordOffline(t, ledger);

    ledger.offline = false;
    await t.tap(find.text('ارسال دوباره'));
    await t.pumpAndSettle();

    expect(ledger.entries.single.amountMinor, 100000);
    expect(ledger.entries.single.note, 'نان');
    expect(find.textContaining('در انتظار ارسال'), findsNothing);
  });

  testWidgets('still offline on retry keeps the entry queued', (t) async {
    final ledger = await _pump(t);
    await _recordOffline(t, ledger);

    await t.tap(find.text('ارسال دوباره'));
    await t.pumpAndSettle();

    expect(find.text('تراکنش در انتظار ارسال: ۱'), findsOneWidget);
    expect(ledger.entries, isEmpty);
  });

  testWidgets('a refused entry is listed and can be dismissed', (t) async {
    final ledger = await _pump(t);
    await _recordOffline(t, ledger);

    ledger.offline = false;
    ledger.refuseRecord = WalletFailure.invalid;
    await t.tap(find.text('ارسال دوباره'));
    await t.pumpAndSettle();

    expect(find.text('این تراکنش‌ها ثبت نشدند'), findsOneWidget);
    expect(find.text('تراکنش در انتظار ارسال: ۱'), findsNothing);

    await t.tap(find.text('حذف').first);
    await t.pumpAndSettle();
    expect(find.text('این تراکنش‌ها ثبت نشدند'), findsNothing);
  });

  testWidgets('a normal online save still goes straight to the server', (
    t,
  ) async {
    final ledger = await _pump(t);

    await t.tap(find.text('ثبت خرج یا درآمد'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).at(0), '۵۰۰');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(ledger.entries, hasLength(1));
    expect(find.textContaining('در انتظار ارسال'), findsNothing);
  });
}
