import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:summa/app.dart';
import 'package:summa/core/format/persian.dart';
import 'package:summa/features/assets/asset_controller.dart';
import 'package:summa/features/auth/auth_controller.dart';
import 'package:summa/features/auth/token_store.dart';
import 'package:summa/features/categories/category_controller.dart';
import 'package:summa/features/networth/networth_controller.dart';
import 'package:summa/features/reports/report_api.dart';
import 'package:summa/features/reports/report_controller.dart';
import 'package:summa/features/reports/report_models.dart';
import 'package:summa/features/wallets/ledger_controller.dart';
import 'package:summa/features/wallets/wallets_controller.dart';

import '../assets/fake_asset_api.dart';
import '../auth/fake_auth_api.dart';
import '../categories/fake_category_api.dart';
import '../networth/fake_networth_api.dart';
import '../wallets/fake_ledger_api.dart';
import '../wallets/fake_wallet_api.dart';

class _FakeReportApi implements ReportApi {
  final Map<String, Report> byCurrency = {};
  final List<({DateTime start, DateTime end, String currency})> asked = [];
  bool fail = false;

  @override
  Future<Report> monthly(
    String access, {
    required DateTime start,
    required DateTime end,
    required String currency,
  }) async {
    asked.add((start: start, end: end, currency: currency));
    if (fail) throw Exception('down');
    return byCurrency[currency] ?? _report(currency: currency, entries: 0);
  }
}

Report _report({
  String currency = 'IRT',
  int entries = 3,
  List<String> currencies = const ['IRT'],
}) => Report(
  currency: currency,
  incomeMinor: entries == 0 ? 0 : 5000000,
  expenseMinor: entries == 0 ? 0 : 1500000,
  netMinor: entries == 0 ? 0 : 3500000,
  entries: entries,
  byCategory: entries == 0
      ? const []
      : const [
          CategoryTotal(
            categoryId: 'c1',
            name: 'خوراک',
            kind: 'expense',
            totalMinor: 1000000,
          ),
          CategoryTotal(
            categoryId: 'c2',
            name: 'سلامت',
            kind: 'expense',
            totalMinor: 500000,
          ),
          CategoryTotal(
            categoryId: 'c3',
            name: 'حقوق',
            kind: 'income',
            totalMinor: 5000000,
          ),
        ],
  daily: [
    for (var d = 0; d < 30; d++)
      DayTotal(
        day: DateTime(2026, 11, 22 + d),
        incomeMinor: 0,
        expenseMinor: d == 3 && entries > 0 ? 700000 : 0,
      ),
  ],
  topExpenseCategory: entries == 0 ? '' : 'خوراک',
  currencies: currencies,
);

Future<_FakeReportApi> _pump(WidgetTester t) async {
  t.view.physicalSize = const Size(800, 12000);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  final wallets = FakeWalletApi();
  final ledger = FakeLedgerApi(wallets);
  final report = _FakeReportApi();
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
        reportApiProvider.overrideWithValue(report),
      ],
      child: const SummaApp(),
    ),
  );
  await t.pumpAndSettle();
  return report;
}

void main() {
  group('Shamsi month windows', () {
    final azar = Jalali(1405, 9, 15).toDateTime();

    test('offset zero is the month itself', () {
      final w = shamsiMonthWindowAt(azar, 0);

      expect(w.start, Jalali(1405, 9, 1).toDateTime().toUtc());
      expect(w.end, Jalali(1405, 10, 1).toDateTime().toUtc());
    });
    test('negative and positive offsets move by whole months', () {
      expect(
        shamsiMonthWindowAt(azar, -1).start,
        Jalali(1405, 8, 1).toDateTime().toUtc(),
      );
      expect(
        shamsiMonthWindowAt(azar, 2).start,
        Jalali(1405, 11, 1).toDateTime().toUtc(),
      );
    });
    test('they cross the year boundary both ways', () {
      expect(
        shamsiMonthWindowAt(azar, 4).start,
        Jalali(1406, 1, 1).toDateTime().toUtc(),
      );
      expect(
        shamsiMonthWindowAt(Jalali(1405, 1, 10).toDateTime(), -1).start,
        Jalali(1404, 12, 1).toDateTime().toUtc(),
      );
      expect(
        shamsiMonthWindowAt(Jalali(1405, 12, 10).toDateTime(), 0).end,
        Jalali(1406, 1, 1).toDateTime().toUtc(),
      );
    });
    test('the month name is in Persian', () {
      expect(formatJalaliMonth(azar), 'آذر ۱۴۰۵');
    });
  });

  testWidgets('the report shows the totals, categories and the chart', (
    t,
  ) async {
    final api = await _pump(t);
    api.byCurrency['IRT'] = _report();

    await t.tap(find.text('گزارش ماه'));
    await t.pumpAndSettle();

    expect(find.text('درآمد: ۵٬۰۰۰٬۰۰۰ تومان'), findsOneWidget);
    expect(find.text('خرج: ۱٬۵۰۰٬۰۰۰ تومان'), findsOneWidget);
    expect(find.text('خالص: ۳٬۵۰۰٬۰۰۰ تومان'), findsOneWidget);
    expect(find.text('تعداد تراکنش: ۳'), findsOneWidget);
    expect(find.text('پرخرج‌ترین دسته: خوراک'), findsOneWidget);
    expect(find.text('خرج به تفکیک دسته'), findsOneWidget);
    expect(find.text('درآمد به تفکیک دسته'), findsOneWidget);
    expect(find.text('خرج روزانه'), findsOneWidget);
    expect(find.text('سلامت'), findsOneWidget);
  });

  testWidgets('the window sent to the server is this Shamsi month', (t) async {
    final api = await _pump(t);

    await t.tap(find.text('گزارش ماه'));
    await t.pumpAndSettle();

    final w = shamsiMonthWindowAt(DateTime.now(), 0);
    expect(api.asked.last.start, w.start);
    expect(api.asked.last.end, w.end);
    expect(api.asked.last.currency, 'IRT');
  });

  testWidgets('previous and next move the month', (t) async {
    final api = await _pump(t);

    await t.tap(find.text('گزارش ماه'));
    await t.pumpAndSettle();
    await t.tap(find.text('ماه قبل'));
    await t.pumpAndSettle();
    expect(api.asked.last.start, shamsiMonthWindowAt(DateTime.now(), -1).start);
    await t.tap(find.text('ماه بعد'));
    await t.tap(find.text('ماه بعد'));
    await t.pumpAndSettle();

    expect(api.asked.last.start, shamsiMonthWindowAt(DateTime.now(), 1).start);
  });

  testWidgets('an empty month says so and draws no charts', (t) async {
    await _pump(t);

    await t.tap(find.text('گزارش ماه'));
    await t.pumpAndSettle();

    expect(find.text('در این ماه تراکنشی نیست.'), findsOneWidget);
    expect(find.text('خرج به تفکیک دسته'), findsNothing);
    expect(find.text('خرج روزانه'), findsNothing);
  });

  testWidgets('another currency can be chosen when there is activity', (
    t,
  ) async {
    final api = await _pump(t);
    api.byCurrency['IRT'] = _report(currencies: ['IRT', 'USD']);
    api.byCurrency['USD'] = _report(
      currency: 'USD',
      currencies: ['IRT', 'USD'],
    );

    await t.tap(find.text('گزارش ماه'));
    await t.pumpAndSettle();
    await t.tap(find.text('دلار'));
    await t.pumpAndSettle();

    expect(api.asked.last.currency, 'USD');
    expect(find.textContaining('دلار'), findsWidgets);
  });

  testWidgets('a failing server shows a message', (t) async {
    final api = await _pump(t);
    api.fail = true;

    await t.tap(find.text('گزارش ماه'));
    await t.pumpAndSettle();

    expect(find.text('گزارش گرفته نشد. دوباره امتحان کن.'), findsOneWidget);
  });
}
