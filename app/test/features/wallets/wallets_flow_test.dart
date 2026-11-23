import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/app.dart';
import 'package:summa/features/auth/auth_controller.dart';
import 'package:summa/features/auth/token_store.dart';
import 'package:summa/features/wallets/wallet_models.dart';
import 'package:summa/features/categories/category_controller.dart';
import 'package:summa/features/wallets/ledger_controller.dart';
import 'package:summa/features/wallets/wallets_controller.dart';

import '../auth/fake_auth_api.dart';
import '../categories/fake_category_api.dart';
import 'fake_ledger_api.dart';
import 'fake_wallet_api.dart';

Future<FakeLedgerApi> _pump(WidgetTester t, FakeWalletApi wallets) async {
  final ledger = FakeLedgerApi(wallets);
  final categories = FakeCategoryApi(ledger);
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
        categoryApiProvider.overrideWithValue(categories),
      ],
      child: const SummaApp(),
    ),
  );
  await t.pumpAndSettle();
  return ledger;
}

void main() {
  ledgerTests();
  transferTests();
  testWidgets('no wallets: shows the empty hint and an add button', (t) async {
    await _pump(t, FakeWalletApi());

    expect(find.textContaining('هنوز کیف پولی نداری'), findsOneWidget);
    expect(find.text('کیف پول جدید'), findsOneWidget);
  });

  testWidgets(
    'creating a wallet with an opening balance lists it and the total',
    (t) async {
      final api = FakeWalletApi();
      await _pump(t, api);

      await t.tap(find.text('کیف پول جدید'));
      await t.pumpAndSettle();
      final fields = find.byType(TextField);
      await t.enterText(fields.at(0), 'ملی من');
      await t.enterText(fields.at(2), '۱٬۵۰۰٬۰۰۰');
      await t.tap(find.text('ذخیره'));
      await t.pumpAndSettle();

      expect(api.wallets.single.balanceMinor, 1500000);
      expect(find.text('ملی من'), findsOneWidget);
      expect(find.text('۱٬۵۰۰٬۰۰۰ تومان'), findsNWidgets(2)); // total + tile
    },
  );

  testWidgets('a blank name is refused without calling the server', (t) async {
    final api = FakeWalletApi();
    await _pump(t, api);

    await t.tap(find.text('کیف پول جدید'));
    await t.pumpAndSettle();
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(find.text('برای کیف پول یک نام بنویس.'), findsOneWidget);
    expect(api.wallets, isEmpty);
  });

  testWidgets('a negative opening balance is refused for a bank wallet', (
    t,
  ) async {
    final api = FakeWalletApi();
    await _pump(t, api);

    await t.tap(find.text('کیف پول جدید'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).at(0), 'x');
    await t.enterText(find.byType(TextField).at(2), '-5');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(find.textContaining('موجودی اولیه درست نیست'), findsOneWidget);
    expect(api.wallets, isEmpty);
  });

  testWidgets('a server failure shows the message and keeps the form', (
    t,
  ) async {
    final api = FakeWalletApi()..createFailure = WalletFailure.offline;
    await _pump(t, api);

    await t.tap(find.text('کیف پول جدید'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).at(0), 'x');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(find.textContaining('اتصال برقرار نشد'), findsOneWidget);
    expect(find.text('ذخیره'), findsOneWidget);
  });
}

void _seed(FakeWalletApi api) => api.wallets.add(
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

void _seedSecond(FakeWalletApi api, {String currency = 'IRT'}) =>
    api.wallets.add(
      Wallet(
        id: 'w2',
        name: 'نقد من',
        kind: WalletKind.cash,
        currency: currency,
        bank: '',
        archived: false,
        balanceMinor: 0,
      ),
    );

void transferTests() {
  testWidgets('same-currency transfer moves money and lists both legs', (
    t,
  ) async {
    final wallets = FakeWalletApi();
    _seed(wallets);
    _seedSecond(wallets);
    final ledger = await _pump(t, wallets);

    await t.tap(find.text('انتقال بین کیف‌ها'));
    await t.pumpAndSettle();
    expect(find.text('نرخ (هر یک واحد مبدأ چند واحد مقصد)'), findsNothing);
    await t.enterText(find.byType(TextField).at(0), '۲۰۰٬۰۰۰');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(ledger.transferRates, ['']);
    expect(find.text('-۲۰۰٬۰۰۰ تومان'), findsOneWidget);
    expect(find.text('+۲۰۰٬۰۰۰ تومان'), findsOneWidget);
    expect(wallets.wallets.map((w) => w.balanceMinor), [800000, 200000]);
  });

  testWidgets('cross-currency transfer asks for the rate and sends it', (
    t,
  ) async {
    final wallets = FakeWalletApi();
    _seed(wallets);
    _seedSecond(wallets, currency: 'USD');
    final ledger = await _pump(t, wallets);

    await t.tap(find.text('انتقال بین کیف‌ها'));
    await t.pumpAndSettle();
    expect(find.text('نرخ (هر یک واحد مبدأ چند واحد مقصد)'), findsOneWidget);
    await t.enterText(find.byType(TextField).at(0), '۱٬۰۰۰٬۰۰۰');
    await t.enterText(find.byType(TextField).at(1), '۰٫۰۰۰۰۱۶');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(ledger.transferRates, ['0.000016']);
  });

  testWidgets('a missing rate is refused without calling the server', (
    t,
  ) async {
    final wallets = FakeWalletApi();
    _seed(wallets);
    _seedSecond(wallets, currency: 'USD');
    final ledger = await _pump(t, wallets);

    await t.tap(find.text('انتقال بین کیف‌ها'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).at(0), '۱۰۰');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(find.textContaining('نرخ درست نیست'), findsOneWidget);
    expect(ledger.transferRates, isEmpty);
  });

  testWidgets('no transfer button with a single wallet', (t) async {
    final wallets = FakeWalletApi();
    _seed(wallets);
    await _pump(t, wallets);

    expect(find.text('انتقال بین کیف‌ها'), findsNothing);
  });
}

void ledgerTests() {
  testWidgets('recording an expense lists it and lowers the balance', (
    t,
  ) async {
    final wallets = FakeWalletApi();
    _seed(wallets);
    final ledger = await _pump(t, wallets);

    await t.tap(find.text('ثبت خرج یا درآمد'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).at(0), '۳۰۰٬۰۰۰');
    await t.enterText(find.byType(TextField).at(1), 'نان');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(ledger.entries.single.amountMinor, 300000);
    expect(find.text('نان'), findsOneWidget);
    expect(find.text('-۳۰۰٬۰۰۰ تومان'), findsOneWidget);
    expect(find.text('۷۰۰٬۰۰۰ تومان'), findsNWidgets(2)); // total + tile
  });

  testWidgets('an income shows with a plus and raises the balance', (t) async {
    final wallets = FakeWalletApi();
    _seed(wallets);
    await _pump(t, wallets);

    await t.tap(find.text('ثبت خرج یا درآمد'));
    await t.pumpAndSettle();
    await t.tap(find.text('درآمد'));
    await t.enterText(find.byType(TextField).at(0), '۵۰۰٬۰۰۰');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(find.text('+۵۰۰٬۰۰۰ تومان'), findsOneWidget);
    expect(find.text('۱٬۵۰۰٬۰۰۰ تومان'), findsNWidgets(2));
  });

  testWidgets('a zero amount is refused without calling the server', (t) async {
    final wallets = FakeWalletApi();
    _seed(wallets);
    final ledger = await _pump(t, wallets);

    await t.tap(find.text('ثبت خرج یا درآمد'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).at(0), '۰');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(find.textContaining('مبلغ درست نیست'), findsOneWidget);
    expect(ledger.entries, isEmpty);
  });

  testWidgets('deleting an entry restores the balance', (t) async {
    final wallets = FakeWalletApi();
    _seed(wallets);
    final ledger = await _pump(t, wallets);
    await t.tap(find.text('ثبت خرج یا درآمد'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).at(0), '۱۰۰');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    await t.tap(find.text('حذف'));
    await t.pumpAndSettle();

    expect(ledger.entries, isEmpty);
    expect(find.text('۱٬۰۰۰٬۰۰۰ تومان'), findsNWidgets(2));
  });

  testWidgets('no add-entry button until a wallet exists', (t) async {
    await _pump(t, FakeWalletApi());

    expect(find.text('ثبت خرج یا درآمد'), findsNothing);
  });
}
