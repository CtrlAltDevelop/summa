import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summa/features/auth/setup_prompt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:summa/app.dart';
import 'package:summa/core/format/persian.dart';
import 'package:summa/features/assets/asset_controller.dart';
import 'package:summa/features/networth/networth_controller.dart';
import 'package:summa/features/billing/billing_controller.dart';
import 'package:summa/features/auth/auth_controller.dart';
import 'package:summa/features/auth/token_store.dart';
import 'package:summa/features/categories/category_controller.dart';
import 'package:summa/features/debts/debt_controller.dart';
import 'package:summa/features/debts/debt_models.dart';
import 'package:summa/features/wallets/ledger_controller.dart';
import 'package:summa/features/wallets/wallet_models.dart';
import 'package:summa/features/wallets/wallets_controller.dart';

import '../auth/fake_auth_api.dart';
import '../categories/fake_category_api.dart';
import '../wallets/fake_ledger_api.dart';
import '../wallets/fake_wallet_api.dart';
import '../billing/fake_billing_api.dart';
import '../networth/fake_networth_api.dart';
import '../assets/fake_asset_api.dart';
import 'fake_debt_api.dart';

Wallet _wallet(String id, String name) => Wallet(
  id: id,
  name: name,
  kind: WalletKind.bank,
  currency: 'IRT',
  bank: '',
  archived: false,
  balanceMinor: 10000000,
);

Debt _debt({String walletId = 'w1', bool overdue = false}) => Debt(
  id: 'd1',
  kind: DebtKind.bankLoan,
  title: 'وام مسکن',
  currency: 'IRT',
  installmentMinor: 1000000,
  count: 3,
  walletId: walletId,
  paidCount: 0,
  remainingMinor: 3000000,
  nextDue: DateTime(2026, 12, 6),
  closed: false,
  installments: [
    for (var n = 1; n <= 3; n++)
      Installment(
        id: 'i$n',
        number: n,
        dueDate: DateTime(2026, 11 + n, 6),
        amountMinor: 1000000,
        paid: false,
        overdue: overdue && n == 1,
      ),
  ],
);

Future<FakeDebtApi> _pump(
  WidgetTester t, {
  List<Debt> debts = const [],
  List<Wallet>? wallets,
}) async {
  t.view.physicalSize = const Size(800, 9000);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  final walletApi = FakeWalletApi()
    ..wallets.addAll(wallets ?? [_wallet('w1', 'ملی من')]);
  final ledger = FakeLedgerApi(walletApi);
  final debtApi = FakeDebtApi()..debts.addAll(debts);
  final auth = FakeAuthApi(profileName: 'سارا');
  await t.pumpWidget(
    ProviderScope(
      overrides: [
        setupPromptEnabledProvider.overrideWithValue(false),
        authApiProvider.overrideWithValue(auth),
        tokenStoreProvider.overrideWithValue(
          MemoryTokenStore(auth.currentTokens),
        ),
        assetApiProvider.overrideWithValue(FakeAssetApi()),
        networthApiProvider.overrideWithValue(FakeNetWorthApi()),
        billingApiProvider.overrideWithValue(FakeBillingApi()),
        walletApiProvider.overrideWithValue(walletApi),
        ledgerApiProvider.overrideWithValue(ledger),
        categoryApiProvider.overrideWithValue(FakeCategoryApi(ledger)),
        debtApiProvider.overrideWithValue(debtApi),
      ],
      child: const SummaApp(),
    ),
  );
  await t.pumpAndSettle();
  return debtApi;
}

void main() {
  group('Shamsi date input', () {
    test('parses Persian digits and either separator', () {
      expect(parseJalaliDate('۱۴۰۵/۰۹/۱۵'), Jalali(1405, 9, 15).toDateTime());
      expect(parseJalaliDate('1405-9-15'), Jalali(1405, 9, 15).toDateTime());
    });
    test('rejects impossible and malformed dates', () {
      for (final bad in [
        '1405/13/01',
        '1405/07/31',
        '1405/12/30',
        'x',
        '',
        '1405/09',
      ]) {
        expect(parseJalaliDate(bad), isNull, reason: bad);
      }
    });
    test('accepts the leap day only in a leap year', () {
      expect(parseJalaliDate('1403/12/30'), isNotNull);
    });
    test('isoDate pads the parts', () {
      expect(isoDate(DateTime(2026, 3, 5)), '2026-03-05');
    });
  });

  testWidgets('a loan is defined with its schedule inputs', (t) async {
    final api = await _pump(t);

    await t.tap(find.text('وام یا قسط جدید'));
    await t.pumpAndSettle();
    final f = find.byType(TextField);
    await t.enterText(f.at(0), 'وام مسکن');
    await t.enterText(f.at(1), '۱٬۰۰۰٬۰۰۰');
    await t.enterText(f.at(2), '۱۲');
    await t.enterText(f.at(3), '۱۴۰۵/۰۹/۱۵');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    final c = api.created.single;
    expect(
      (c['kind'], c['title'], c['currency'], c['installment'], c['count']),
      (DebtKind.bankLoan, 'وام مسکن', 'IRT', 1000000, 12),
    );
    expect(c['firstDue'], Jalali(1405, 9, 15).toDateTime());
    expect(c['wallet'], '');
    expect(find.textContaining('مانده'), findsOneWidget);
  });

  testWidgets('a bad count or date is refused before the server', (t) async {
    final api = await _pump(t);

    await t.tap(find.text('وام یا قسط جدید'));
    await t.pumpAndSettle();
    final f = find.byType(TextField);
    await t.enterText(f.at(0), 'وام');
    await t.enterText(f.at(1), '۱۰۰');
    await t.enterText(f.at(2), '۰');
    await t.enterText(f.at(3), '۱۴۰۵/۰۹/۱۵');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();
    expect(find.textContaining('بین ۱ تا ۱۲۰'), findsOneWidget);

    await t.enterText(f.at(2), '۳');
    await t.enterText(f.at(3), '۱۴۰۵/۱۳/۱۵');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(find.text('تاریخ اولین قسط درست نیست.'), findsOneWidget);
    expect(api.created, isEmpty);
  });

  testWidgets('the tile shows what is left and flags an overdue one', (
    t,
  ) async {
    await _pump(t, debts: [_debt(overdue: true)]);

    expect(find.text('وام مسکن'), findsOneWidget);
    expect(find.textContaining('مانده: ۳٬۰۰۰٬۰۰۰ تومان'), findsOneWidget);
    expect(find.textContaining('عقب‌افتاده'), findsOneWidget);
    expect(find.text('۰/۳'), findsOneWidget);
  });

  testWidgets('paying uses the debt wallet and can be undone', (t) async {
    final api = await _pump(t, debts: [_debt()]);

    await t.tap(find.text('وام مسکن'));
    await t.pumpAndSettle();
    await t.tap(find.text('پرداخت شد').first);
    await t.pumpAndSettle();

    expect(api.payments.single['wallet'], '');
    expect(find.text('لغو پرداخت'), findsOneWidget);
    expect(find.textContaining('مانده: ۲٬۰۰۰٬۰۰۰ تومان'), findsWidgets);

    await t.tap(find.text('لغو پرداخت'));
    await t.pumpAndSettle();
    expect(api.undone, ['i1']);
    expect(find.text('لغو پرداخت'), findsNothing);
  });

  testWidgets('without a debt wallet the person picks the paying wallet', (
    t,
  ) async {
    final api = await _pump(
      t,
      debts: [_debt(walletId: '')],
      wallets: [_wallet('w1', 'ملی من'), _wallet('w2', 'نقد من')],
    );

    await t.tap(find.text('وام مسکن'));
    await t.pumpAndSettle();
    await t.tap(find.text('پرداخت شد').first);
    await t.pumpAndSettle();
    expect(api.payments, isEmpty);
    expect(find.text('از کدام کیف پرداخت شود؟'), findsOneWidget);
    await t.tap(find.text('نقد من').last);
    await t.pumpAndSettle();

    expect(api.payments.single['wallet'], 'w2');
  });

  testWidgets('a refused payment explains itself', (t) async {
    final api = await _pump(t, debts: [_debt()]);
    api.failPay = true;

    await t.tap(find.text('وام مسکن'));
    await t.pumpAndSettle();
    await t.tap(find.text('پرداخت شد').first);
    await t.pumpAndSettle();

    expect(find.textContaining('پرداخت انجام نشد'), findsOneWidget);
  });

  testWidgets('a debt can be deleted from its screen', (t) async {
    final api = await _pump(t, debts: [_debt()]);

    await t.tap(find.text('وام مسکن'));
    await t.pumpAndSettle();
    await t.tap(find.text('حذف بدهی'));
    await t.pumpAndSettle();

    expect(api.debts, isEmpty);
    expect(find.text('وام مسکن'), findsNothing);
  });
}
