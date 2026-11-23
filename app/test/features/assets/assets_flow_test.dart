import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/app.dart';
import 'package:summa/core/format/persian.dart';
import 'package:summa/features/assets/asset_controller.dart';
import 'package:summa/features/auth/auth_controller.dart';
import 'package:summa/features/auth/token_store.dart';
import 'package:summa/features/categories/category_controller.dart';
import 'package:summa/features/wallets/ledger_controller.dart';
import 'package:summa/features/wallets/wallets_controller.dart';

import '../auth/fake_auth_api.dart';
import '../categories/fake_category_api.dart';
import '../wallets/fake_ledger_api.dart';
import '../wallets/fake_wallet_api.dart';
import 'fake_asset_api.dart';

Future<FakeAssetApi> _pump(
  WidgetTester t, {
  Map<String, int> rates = const {},
  bool withGold = false,
}) async {
  t.view.physicalSize = const Size(800, 9000);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  final wallets = FakeWalletApi();
  final ledger = FakeLedgerApi(wallets);
  final api = FakeAssetApi()..rateTable.addAll(rates);
  if (withGold) {
    await api.create(
      'a',
      symbol: 'GOLD18',
      name: '',
      quantity: '10',
      unitPriceMinor: 7000000,
      manualPriceMinor: 0,
      clientMutationId: 'seed',
    );
    api.created.clear();
  }
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
        assetApiProvider.overrideWithValue(api),
      ],
      child: const SummaApp(),
    ),
  );
  await t.pumpAndSettle();
  return api;
}

void main() {
  test('quantities are normalised without ever becoming a float', () {
    expect(quantityText('۰٫۵'), '0.5');
    expect(quantityText(' ۱۲٬۵ '), '125'); // thousands mark dropped
    expect(quantityText('0,25'), '0.25');
    expect(formatQuantity('0.125'), '۰٫۱۲۵');
  });

  testWidgets('a listed asset is added with its purchase price', (t) async {
    final api = await _pump(t, rates: {'GOLD18': 8000000});

    await t.tap(find.text('دارایی جدید'));
    await t.pumpAndSettle();
    final f = find.byType(TextField);
    await t.enterText(f.at(0), '۱۰٫۵');
    await t.enterText(f.at(1), '۷٬۰۰۰٬۰۰۰');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(api.created.single, {
      'symbol': 'GOLD18',
      'name': '',
      'quantity': '10.5',
      'unit': 7000000,
      'manual': 0,
    });
    expect(find.text('طلای ۱۸ عیار'), findsOneWidget);
    expect(find.textContaining('۱۰٫۵'), findsWidgets);
  });

  testWidgets('another symbol can be chosen', (t) async {
    final api = await _pump(t, rates: {'USD': 60000});

    await t.tap(find.text('دارایی جدید'));
    await t.pumpAndSettle();
    await t.tap(find.text('دلار'));
    await t.pumpAndSettle();
    final f = find.byType(TextField);
    await t.enterText(f.at(0), '۱۰۰');
    await t.enterText(f.at(1), '۵۸٬۰۰۰');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(api.created.single['symbol'], 'USD');
  });

  testWidgets('a custom asset needs a name and today\'s price', (t) async {
    final api = await _pump(t);

    await t.tap(find.text('دارایی جدید'));
    await t.pumpAndSettle();
    await t.tap(find.text('دلخواه'));
    await t.pumpAndSettle();
    final f = find.byType(TextField);
    await t.enterText(f.at(2), '۲');
    await t.enterText(f.at(3), '۱۰۰');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();
    expect(find.text('نام و قیمت امروز لازم است.'), findsOneWidget);
    expect(api.created, isEmpty);

    await t.enterText(f.at(0), 'زمین');
    await t.enterText(f.at(1), '۱۵۰');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(api.created.single['symbol'], '');
    expect(api.created.single['manual'], 150);
    expect(find.text('زمین'), findsOneWidget);
  });

  testWidgets('a bad quantity or price is refused before the server', (
    t,
  ) async {
    final api = await _pump(t, rates: {'GOLD18': 8000000});

    await t.tap(find.text('دارایی جدید'));
    await t.pumpAndSettle();
    final f = find.byType(TextField);
    await t.enterText(f.at(0), '۱٫۱۲۳۴۵۶۷۸۹');
    await t.enterText(f.at(1), '۱۰۰');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();
    expect(find.text('مقدار درست نیست.'), findsOneWidget);

    await t.enterText(f.at(0), '۱');
    await t.enterText(f.at(1), 'x');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(find.text('قیمت درست نیست.'), findsOneWidget);
    expect(api.created, isEmpty);
  });

  testWidgets('the panel shows value and profit from the server rates', (
    t,
  ) async {
    await _pump(t, rates: {'GOLD18': 8000000}, withGold: true);

    expect(find.text('ارزش دارایی‌ها'), findsOneWidget);
    expect(find.text('۸۰٬۰۰۰٬۰۰۰ تومان'), findsWidgets);
    expect(find.text('۱۰٬۰۰۰٬۰۰۰'), findsWidgets); // the profit
  });

  testWidgets('an asset without a known price says so', (t) async {
    await _pump(t, withGold: true);

    expect(find.text('نامشخص'), findsOneWidget);
  });

  testWidgets('buy more and sell go through the asset screen', (t) async {
    final api = await _pump(t, rates: {'GOLD18': 8000000}, withGold: true);

    await t.tap(find.text('طلای ۱۸ عیار'));
    await t.pumpAndSettle();
    final f = find.byType(TextField);
    await t.enterText(f.at(0), '۲٫۵');
    await t.enterText(f.at(1), '۷٬۶۰۰٬۰۰۰');
    await t.tap(find.text('خرید جدید'));
    await t.pumpAndSettle();
    await t.enterText(f.at(0), '۳');
    await t.enterText(f.at(1), '۸٬۱۰۰٬۰۰۰');
    await t.tap(find.text('فروش'));
    await t.pumpAndSettle();

    expect(api.lots.single, {'id': 'a1', 'quantity': '2.5', 'price': 7600000});
    expect(api.sales.single, {'id': 'a1', 'quantity': '3', 'price': 8100000});
  });

  testWidgets('a refused sale explains itself', (t) async {
    final api = await _pump(t, rates: {'GOLD18': 8000000}, withGold: true);
    api.failNext = true;

    await t.tap(find.text('طلای ۱۸ عیار'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).at(0), '۱۰۰');
    await t.enterText(find.byType(TextField).at(1), '۱');
    await t.tap(find.text('فروش'));
    await t.pumpAndSettle();

    expect(find.textContaining('انجام نشد'), findsOneWidget);
  });

  testWidgets('an asset can be deleted', (t) async {
    final api = await _pump(t, rates: {'GOLD18': 8000000}, withGold: true);

    await t.tap(find.text('طلای ۱۸ عیار'));
    await t.pumpAndSettle();
    await t.tap(find.text('حذف دارایی'));
    await t.pumpAndSettle();

    expect(api.assets, isEmpty);
  });

  testWidgets('the prices screen lists known and unknown prices', (t) async {
    await _pump(t, rates: {'USD': 60000});

    await t.tap(find.text('قیمت‌ها'));
    await t.pumpAndSettle();

    expect(find.text('۶۰٬۰۰۰'), findsOneWidget);
    expect(find.text('نامشخص'), findsWidgets); // gold and bitcoin have none
    expect(find.textContaining('منبع: manual'), findsOneWidget);
  });
}
