import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/app.dart';
import 'package:summa/features/assets/asset_controller.dart';
import 'package:summa/features/auth/auth_controller.dart';
import 'package:summa/features/auth/token_store.dart';
import 'package:summa/features/categories/category_controller.dart';
import 'package:summa/features/networth/networth_controller.dart';
import 'package:summa/features/networth/networth_models.dart';
import 'package:summa/features/wallets/ledger_controller.dart';
import 'package:summa/features/wallets/wallet_models.dart';
import 'package:summa/features/wallets/wallets_controller.dart';

import '../assets/fake_asset_api.dart';
import '../auth/fake_auth_api.dart';
import '../categories/fake_category_api.dart';
import '../wallets/fake_ledger_api.dart';
import '../wallets/fake_wallet_api.dart';
import 'fake_networth_api.dart';

Future<FakeNetWorthApi> _pump(
  WidgetTester t, {
  NetWorth? worth,
  bool withGold = false,
}) async {
  t.view.physicalSize = const Size(800, 10000);
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
  final assets = FakeAssetApi()..rateTable['GOLD18'] = 8000000;
  if (withGold) {
    await assets.create(
      'a',
      symbol: 'GOLD18',
      name: '',
      quantity: '1',
      unitPriceMinor: 7000000,
      manualPriceMinor: 0,
      clientMutationId: 'seed',
    );
  }
  final api = FakeNetWorthApi();
  if (worth != null) api.worth = worth;
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
        assetApiProvider.overrideWithValue(assets),
        networthApiProvider.overrideWithValue(api),
      ],
      child: const SummaApp(),
    ),
  );
  await t.pumpAndSettle();
  return api;
}

NetWorth _worth({
  bool stale = false,
  List<String> unconverted = const [],
  int unpriced = 0,
  int? usd = 20000,
  String gold = '1.5',
}) => NetWorth(
  totalMinor: 12000000,
  walletsMinor: 5000000,
  assetsMinor: 9000000,
  debtsMinor: 2000000,
  usdMinor: usd,
  goldGrams: gold,
  stale: stale,
  unconverted: unconverted,
  unpricedAssets: unpriced,
);

void main() {
  testWidgets('the card shows toman, dollars, gold and the parts', (t) async {
    await _pump(t, worth: _worth());

    expect(find.text('خالص دارایی'), findsOneWidget);
    expect(find.text('۱۲٬۰۰۰٬۰۰۰ تومان'), findsOneWidget);
    expect(find.text('۲۰۰٫۰۰ دلار'), findsOneWidget);
    expect(find.text('۱٫۵ گرم طلای ۱۸ عیار'), findsOneWidget);
    expect(find.text('کیف‌ها: ۵٬۰۰۰٬۰۰۰'), findsOneWidget);
    expect(find.text('بدهی‌ها: ۲٬۰۰۰٬۰۰۰'), findsOneWidget);
  });

  testWidgets('equivalents without a rate are left out', (t) async {
    await _pump(t, worth: _worth(usd: null, gold: ''));

    expect(find.textContaining('دلار'), findsNothing);
    expect(find.textContaining('گرم طلا'), findsNothing);
  });

  testWidgets('warnings say what was left out or is old', (t) async {
    await _pump(
      t,
      worth: _worth(stale: true, unconverted: ['AED', 'EUR'], unpriced: 2),
    );

    expect(find.textContaining('کهنه‌اند'), findsOneWidget);
    expect(find.textContaining('ارزهای بدون نرخ'), findsOneWidget);
    expect(find.textContaining('AED، EUR'), findsOneWidget);
    expect(find.textContaining('دارایی بدون قیمت: ۲'), findsOneWidget);
  });

  testWidgets('a basket is created with the picked wallet and asset', (
    t,
  ) async {
    final api = await _pump(t, worth: _worth(), withGold: true);

    await t.tap(find.text('سبد هدف جدید'));
    await t.pumpAndSettle();
    final f = find.byType(TextField);
    await t.enterText(f.at(0), 'پیش‌پرداخت');
    await t.enterText(f.at(1), '۱۰۰٬۰۰۰٬۰۰۰');
    await t.tap(find.text('ملی من').last);
    await t.tap(find.text('طلای ۱۸ عیار').last);
    await t.pumpAndSettle();
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    final c = api.created.single;
    expect(c['name'], 'پیش‌پرداخت');
    expect(c['target'], 100000000);
    expect(
      c['items'],
      containsAll([
        const BasketItemRef('wallet', 'w1'),
        const BasketItemRef('asset', 'a1'),
      ]),
    );
    expect(find.text('پیش‌پرداخت'), findsOneWidget);
  });

  testWidgets('an item can be un-picked again', (t) async {
    final api = await _pump(t, worth: _worth());

    await t.tap(find.text('سبد هدف جدید'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).at(0), 'x');
    await t.enterText(find.byType(TextField).at(1), '۱۰۰');
    await t.tap(find.text('ملی من').last);
    await t.pumpAndSettle();
    await t.tap(find.text('ملی من').last);
    await t.pumpAndSettle();
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(api.created.single['items'], isEmpty);
  });

  testWidgets('a missing name or a bad target is refused', (t) async {
    final api = await _pump(t, worth: _worth());

    await t.tap(find.text('سبد هدف جدید'));
    await t.pumpAndSettle();
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();
    expect(find.text('برای کیف پول یک نام بنویس.'), findsOneWidget);

    await t.enterText(find.byType(TextField).at(0), 'x');
    await t.enterText(find.byType(TextField).at(1), '۰');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(find.text('مبلغ هدف درست نیست.'), findsOneWidget);
    expect(api.created, isEmpty);
  });

  testWidgets('baskets show progress and can be deleted', (t) async {
    final api = await _pump(t, worth: _worth());
    api.baskets_.add(
      const Basket(
        id: 'b1',
        name: 'خانه',
        targetMinor: 100000000,
        valueMinor: 25000000,
        percent: 25,
        items: [],
      ),
    );
    ProviderScope.containerOf(t.element(find.byType(SummaApp)))
        .invalidate(basketsProvider);
    await t.pumpAndSettle();

    expect(find.text('خانه'), findsOneWidget);
    expect(
      find.textContaining('۲۵٬۰۰۰٬۰۰۰ / ۱۰۰٬۰۰۰٬۰۰۰ تومان'),
      findsOneWidget,
    );
    expect(find.textContaining('۲۵٪ از هدف'), findsOneWidget);

    await t.tap(find.text('حذف سبد'));
    await t.pumpAndSettle();

    expect(api.baskets_, isEmpty);
    expect(find.text('خانه'), findsNothing);
  });
}
