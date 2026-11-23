import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/app.dart';
import 'package:summa/features/assets/asset_controller.dart';
import 'package:summa/features/networth/networth_controller.dart';
import 'package:summa/features/auth/auth_controller.dart';
import 'package:summa/features/auth/token_store.dart';
import 'package:summa/features/categories/category_controller.dart';
import 'package:summa/features/recurring/recurring_controller.dart';
import 'package:summa/features/recurring/recurring_models.dart';
import 'package:summa/features/assistant/assistant_controller.dart';
import 'package:summa/features/debts/debt_controller.dart';
import 'package:summa/features/wallets/ledger_controller.dart';
import 'package:summa/features/wallets/wallet_models.dart';
import 'package:summa/features/wallets/wallets_controller.dart';

import '../auth/fake_auth_api.dart';
import '../categories/fake_category_api.dart';
import '../wallets/fake_ledger_api.dart';
import '../wallets/fake_wallet_api.dart';
import '../networth/fake_networth_api.dart';
import '../assets/fake_asset_api.dart';
import 'fake_recurring_api.dart';
import '../debts/fake_debt_api.dart';
import '../assistant/fake_assistant_api.dart';

Wallet _wallet(String id, String name) => Wallet(
  id: id,
  name: name,
  kind: WalletKind.bank,
  currency: 'IRT',
  bank: '',
  archived: false,
  balanceMinor: 1000000,
);

Occurrence _occurrence({
  String id = 'o1',
  int amount = 100000,
  bool isDue = true,
  bool low = false,
}) => Occurrence(
  id: id,
  recurringId: 'r1',
  walletId: 'w1',
  kind: 'expense',
  amountMinor: amount,
  currency: 'IRT',
  note: 'اجاره',
  dueDate: DateTime.utc(2026, 12, 6),
  isDue: isDue,
  lowBalance: low,
);

Future<FakeRecurringApi> _pump(
  WidgetTester t, {
  List<Occurrence> occurrences = const [],
  bool twoWallets = false,
}) async {
  t.view.physicalSize = const Size(800, 8000);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  final wallets = FakeWalletApi()
    ..wallets.addAll([
      _wallet('w1', 'ملی من'),
      if (twoWallets) _wallet('w2', 'نقد من'),
    ]);
  final ledger = FakeLedgerApi(wallets);
  final recurring = FakeRecurringApi()..occurrences.addAll(occurrences);
  final auth = FakeAuthApi(profileName: 'سارا');
  await t.pumpWidget(
    ProviderScope(
      overrides: [
        authApiProvider.overrideWithValue(auth),
        tokenStoreProvider.overrideWithValue(
          MemoryTokenStore(auth.currentTokens),
        ),
        assistantApiProvider.overrideWithValue(FakeAssistantApi()),
        debtApiProvider.overrideWithValue(FakeDebtApi()),
        assetApiProvider.overrideWithValue(FakeAssetApi()),
        networthApiProvider.overrideWithValue(FakeNetWorthApi()),
        walletApiProvider.overrideWithValue(wallets),
        ledgerApiProvider.overrideWithValue(ledger),
        categoryApiProvider.overrideWithValue(FakeCategoryApi(ledger)),
        recurringApiProvider.overrideWithValue(recurring),
      ],
      child: const SummaApp(),
    ),
  );
  await t.pumpAndSettle();
  return recurring;
}

void main() {
  testWidgets('a monthly rent is defined with a Shamsi day', (t) async {
    final api = await _pump(t);

    await t.tap(find.text('تکراری جدید'));
    await t.pumpAndSettle();
    final fields = find.byType(TextField);
    await t.enterText(fields.at(0), 'اجاره');
    await t.enterText(fields.at(1), '۱٬۰۰۰٬۰۰۰');
    await t.enterText(fields.at(2), '۱۵');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(api.created.single, {
      'category': 'c-other',
      'wallet': 'w1',
      'kind': 'expense',
      'amount': 1000000,
      'note': 'اجاره',
      'period': RecurringPeriod.monthly,
      'day': 15,
      'auto': false,
    });
    expect(find.textContaining('سررسید بعدی'), findsOneWidget);
  });

  testWidgets('weekly uses the chosen weekday; empty amount is variable', (
    t,
  ) async {
    final api = await _pump(t);

    await t.tap(find.text('تکراری جدید'));
    await t.pumpAndSettle();
    await t.tap(find.text('هفتگی'));
    await t.pumpAndSettle();
    await t.tap(find.text('دوشنبه'));
    await t.tap(find.text('ثبت خودکار روز سررسید'));
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    final c = api.created.single;
    expect(
      (c['period'], c['day'], c['amount']),
      (RecurringPeriod.weekly, 0, 0),
    );
    expect(c['auto'], isFalse); // a variable amount can never auto-confirm
  });

  testWidgets('an impossible day is refused before the server', (t) async {
    final api = await _pump(t);

    await t.tap(find.text('تکراری جدید'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).at(2), '۴۰');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    expect(find.text('روز درست نیست.'), findsOneWidget);
    expect(api.created, isEmpty);
  });

  testWidgets('a due cycle asks three ways; confirm answers it', (t) async {
    final api = await _pump(t, occurrences: [_occurrence()]);

    expect(find.textContaining('سررسید: اجاره'), findsOneWidget);
    await t.tap(find.text('از همین حساب کسر شد'));
    await t.pumpAndSettle();

    expect(api.answers.single['action'], 'confirm');
    expect(find.textContaining('سررسید: اجاره'), findsNothing);
  });

  testWidgets('another wallet pays', (t) async {
    final api = await _pump(t, occurrences: [_occurrence()], twoWallets: true);

    await t.tap(find.text('از حساب دیگر'));
    await t.pumpAndSettle();
    await t.tap(find.text('نقد من').last);
    await t.pumpAndSettle();

    expect(api.answers.single['action'], 'other_wallet');
    expect(api.answers.single['wallet'], 'w2');
  });

  testWidgets('cancel skips only this cycle', (t) async {
    final api = await _pump(t, occurrences: [_occurrence()]);

    await t.tap(find.text('لغو شد'));
    await t.pumpAndSettle();

    expect(api.answers.single['action'], 'cancel');
  });

  testWidgets('a variable amount must be typed to confirm', (t) async {
    final api = await _pump(t, occurrences: [_occurrence(amount: 0)]);

    await t.tap(find.text('از همین حساب کسر شد'));
    await t.pumpAndSettle();
    expect(find.text('مبلغ این بار را بنویس.'), findsOneWidget);
    expect(api.answers, isEmpty);
    await t.enterText(find.byType(TextField).first, '۷۰٬۰۰۰');
    await t.tap(find.text('از همین حساب کسر شد'));
    await t.pumpAndSettle();

    expect(api.answers.single['amount'], 70000);
  });

  testWidgets('an upcoming cycle only informs; low balance warns', (t) async {
    final api = await _pump(
      t,
      occurrences: [_occurrence(isDue: false, low: true)],
    );

    expect(find.textContaining('به‌زودی: اجاره'), findsOneWidget);
    expect(find.text('موجودی کیف برای این مبلغ کم است.'), findsOneWidget);
    expect(find.text('از همین حساب کسر شد'), findsNothing);
    expect(api.answers, isEmpty);
  });

  testWidgets('a definition can be paused and deleted', (t) async {
    final api = await _pump(t);
    api.recurrings.add(
      Recurring(
        id: 'r1',
        walletId: 'w1',
        kind: 'expense',
        amountMinor: 100000,
        currency: 'IRT',
        note: 'اجاره',
        period: RecurringPeriod.monthly,
        day: 15,
        autoConfirm: false,
        active: true,
        nextDue: DateTime.utc(2026, 12, 6),
      ),
    );
    t.state<NavigatorState>(find.byType(Navigator)); // keep the tree alive
    final container = ProviderScope.containerOf(
      t.element(find.byType(SummaApp)),
    );
    await container
        .read(recurringControllerProvider.notifier)
        .setActive('r1', active: true);
    await t.pumpAndSettle();

    await t.tap(find.text('توقف'));
    await t.pumpAndSettle();
    expect(api.recurrings.single.active, isFalse);
    expect(find.text('ادامه'), findsOneWidget);

    await t.tap(find.text('حذف').first);
    await t.pumpAndSettle();
    expect(api.recurrings, isEmpty);
  });

  testWidgets('"not yet" postpones instead of answering', (t) async {
    final api = await _pump(t, occurrences: [_occurrence()]);

    await t.tap(find.text('هنوز نه'));
    await t.pumpAndSettle();

    expect(api.answers.single['action'], 'postpone');
    expect(api.answers.single['amount'], 0); // no amount needed to postpone
  });

  testWidgets('an income cycle asks "got it?" and has a "got it" button', (
    t,
  ) async {
    await _pump(
      t,
      occurrences: [
        Occurrence(
          id: 'o2',
          recurringId: 'r1',
          walletId: 'w1',
          kind: 'income',
          amountMinor: 5000000,
          currency: 'IRT',
          note: 'حقوق',
          dueDate: DateTime.utc(2026, 12, 6),
          isDue: true,
          lowBalance: false,
        ),
      ],
    );

    expect(find.textContaining('گرفتی؟'), findsOneWidget);
    expect(find.text('گرفتم'), findsOneWidget);
    expect(find.text('از همین حساب کسر شد'), findsNothing);
  });

  testWidgets('a salary is defined with its income category', (t) async {
    final api = await _pump(t);

    await t.tap(find.text('تکراری جدید'));
    await t.pumpAndSettle();
    await t.tap(find.text('درآمد'));
    await t.pumpAndSettle();
    await t.tap(find.text('حقوق'));
    await t.enterText(find.byType(TextField).at(0), 'حقوق');
    await t.enterText(find.byType(TextField).at(1), '۲۰٬۰۰۰٬۰۰۰');
    await t.enterText(find.byType(TextField).at(2), '۱۶');
    await t.tap(find.text('ذخیره'));
    await t.pumpAndSettle();

    final c = api.created.single;
    expect(
      (c['kind'], c['category'], c['day'], c['amount']),
      ('income', 'c-salary', 16, 20000000),
    );
  });

  testWidgets('"I got this month\'s salary" settles now', (t) async {
    final api = await _pump(t);
    api.recurrings.add(_salary(amount: 20000000));
    await t.runAsync(() async {});
    ProviderScope.containerOf(t.element(find.byType(SummaApp)))
        .invalidate(recurringControllerProvider);
    await t.pumpAndSettle();

    await t.tap(find.text('حقوق این ماه را گرفتم'));
    await t.pumpAndSettle();

    expect(api.settled.single, ('r1', 0));
  });

  testWidgets('a variable salary asks for the amount first', (t) async {
    final api = await _pump(t);
    api.recurrings.add(_salary(amount: 0));
    ProviderScope.containerOf(t.element(find.byType(SummaApp)))
        .invalidate(recurringControllerProvider);
    await t.pumpAndSettle();

    await t.tap(find.text('حقوق این ماه را گرفتم'));
    await t.pumpAndSettle();
    expect(api.settled, isEmpty);
    await t.tap(find.text('حقوق این ماه را گرفتم'));
    await t.pumpAndSettle();
    expect(find.text('مبلغ این بار را بنویس.'), findsOneWidget);
    await t.enterText(find.byType(TextField).first, '۱۸٬۰۰۰٬۰۰۰');
    await t.tap(find.text('حقوق این ماه را گرفتم'));
    await t.pumpAndSettle();

    expect(api.settled.single, ('r1', 18000000));
  });
}

Recurring _salary({required int amount}) => Recurring(
  id: 'r1',
  walletId: 'w1',
  kind: 'income',
  amountMinor: amount,
  currency: 'IRT',
  note: 'حقوق',
  period: RecurringPeriod.monthly,
  day: 16,
  autoConfirm: false,
  active: true,
  nextDue: DateTime.utc(2026, 12, 7),
);
