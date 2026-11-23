import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/app.dart';
import 'package:summa/core/reminders/reminder_scheduler.dart';
import 'package:summa/features/assistant/assistant_controller.dart';
import 'package:summa/features/assistant/chat_models.dart';
import 'package:summa/features/auth/auth_controller.dart';
import 'package:summa/features/auth/token_store.dart';
import 'package:summa/features/categories/category_controller.dart';
import 'package:summa/features/recurring/recurring_controller.dart';
import 'package:summa/features/debts/debt_controller.dart';
import 'package:summa/features/assets/asset_controller.dart';
import 'package:summa/features/wallets/ledger_controller.dart';
import 'package:summa/features/wallets/wallet_models.dart';
import 'package:summa/features/wallets/wallets_controller.dart';

import '../auth/fake_auth_api.dart';
import '../categories/fake_category_api.dart';
import '../recurring/fake_recurring_api.dart';
import '../assets/fake_asset_api.dart';
import '../debts/fake_debt_api.dart';
import '../wallets/fake_ledger_api.dart';
import '../wallets/fake_wallet_api.dart';
import 'fake_assistant_api.dart';

class _RecordingScheduler implements ReminderScheduler {
  final List<int> scheduled = [];
  int cancelled = 0;

  @override
  Future<void> scheduleDaily(int hour) async => scheduled.add(hour);

  @override
  Future<void> cancel() async => cancelled++;
}

Future<({FakeAssistantApi assistant, _RecordingScheduler scheduler})> _pump(
  WidgetTester t, {
  Digest? digest,
}) async {
  t.view.physicalSize = const Size(800, 8000);
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
  final assistant = FakeAssistantApi();
  if (digest != null) assistant.digestResult = digest;
  final scheduler = _RecordingScheduler();
  final auth = FakeAuthApi(profileName: 'سارا');
  await t.pumpWidget(
    ProviderScope(
      overrides: [
        authApiProvider.overrideWithValue(auth),
        tokenStoreProvider.overrideWithValue(
          MemoryTokenStore(auth.currentTokens),
        ),
        debtApiProvider.overrideWithValue(FakeDebtApi()),
        assetApiProvider.overrideWithValue(FakeAssetApi()),
        walletApiProvider.overrideWithValue(wallets),
        ledgerApiProvider.overrideWithValue(ledger),
        categoryApiProvider.overrideWithValue(FakeCategoryApi(ledger)),
        recurringApiProvider.overrideWithValue(FakeRecurringApi()),
        assistantApiProvider.overrideWithValue(assistant),
        reminderSchedulerProvider.overrideWithValue(scheduler),
      ],
      child: const SummaApp(),
    ),
  );
  await t.pumpAndSettle();
  return (assistant: assistant, scheduler: scheduler);
}

Digest _digest({
  int hour = 20,
  int entries = 0,
  int uncategorized = 0,
  int due = 0,
  bool remind = true,
}) => Digest(
  accountingHour: hour,
  entriesToday: entries,
  uncategorizedToday: uncategorized,
  dueQuestions: due,
  lowBalanceWarnings: 0,
  shouldRemind: remind,
);

void main() {
  testWidgets('the reminder card lists what needs attention', (t) async {
    await _pump(t, digest: _digest(entries: 3, uncategorized: 2, due: 1));

    expect(find.text('حساب‌وکتاب امروز'), findsOneWidget);
    expect(find.text('تراکنش ثبت‌شده امروز: ۳'), findsOneWidget);
    expect(find.text('بدون دسته: ۲'), findsOneWidget);
    expect(find.text('سررسید منتظر پاسخ: ۱'), findsOneWidget);
  });

  testWidgets('an empty day says nothing has been recorded yet', (t) async {
    await _pump(t, digest: _digest());

    expect(find.text('امروز هنوز چیزی ثبت نکرده‌ای.'), findsOneWidget);
  });

  testWidgets('no reminder card when the server says not to remind', (t) async {
    await _pump(t, digest: _digest(remind: false));

    expect(find.text('حساب‌وکتاب امروز'), findsNothing);
    expect(find.text('ساعت حساب‌وکتاب روزانه'), findsOneWidget);
  });

  testWidgets('choosing an hour saves it and schedules the reminder', (
    t,
  ) async {
    final s = await _pump(t, digest: _digest(hour: -1, remind: false));

    await t.tap(find.text('۲۱:۰۰'));
    await t.pumpAndSettle();

    expect(s.assistant.hours, [21]);
    expect(s.scheduler.scheduled, [21]);
  });

  testWidgets('turning it off cancels the scheduled reminder', (t) async {
    final s = await _pump(t, digest: _digest(remind: false));

    await t.tap(find.text('خاموش'));
    await t.pumpAndSettle();

    expect(s.assistant.hours, [-1]);
    expect(s.scheduler.cancelled, 1);
    expect(s.scheduler.scheduled, isEmpty);
  });
}
