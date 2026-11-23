import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summa/features/auth/setup_prompt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/app.dart';
import 'package:summa/features/assistant/assistant_controller.dart';
import 'package:summa/features/assistant/chat_models.dart';
import 'package:summa/features/networth/networth_controller.dart';
import 'package:summa/features/billing/billing_controller.dart';
import 'package:summa/features/auth/auth_controller.dart';
import 'package:summa/features/auth/token_store.dart';
import 'package:summa/features/categories/category_controller.dart';
import 'package:summa/features/wallets/entry_models.dart';
import 'package:summa/features/recurring/recurring_controller.dart';
import 'package:summa/features/debts/debt_controller.dart';
import 'package:summa/features/assets/asset_controller.dart';
import 'package:summa/features/wallets/ledger_controller.dart';
import 'package:summa/features/wallets/wallet_models.dart';
import 'package:summa/features/wallets/wallets_controller.dart';

import '../auth/fake_auth_api.dart';
import '../recurring/fake_recurring_api.dart';
import '../assets/fake_asset_api.dart';
import '../debts/fake_debt_api.dart';
import '../categories/fake_category_api.dart';
import '../wallets/fake_ledger_api.dart';
import '../wallets/fake_wallet_api.dart';
import '../billing/fake_billing_api.dart';
import '../networth/fake_networth_api.dart';
import 'fake_assistant_api.dart';

Wallet _wallet(String id, String name) => Wallet(
  id: id,
  name: name,
  kind: WalletKind.bank,
  currency: 'IRT',
  bank: '',
  archived: false,
  balanceMinor: 1000000,
);

SmsCard _card({
  String ignored = '',
  String kind = 'expense',
  String walletId = 'w1',
  String confidence = 'high',
  String duplicate = '',
  String last4 = '1234',
}) => SmsCard(
  ignored: ignored,
  kind: kind,
  amountMinor: 50000,
  currency: 'IRT',
  walletId: walletId,
  confidence: confidence,
  occurredAt: DateTime.utc(2026, 11, 22, 11),
  balanceMinor: 250000,
  last4: last4,
  categoryId: 'c-food',
  suggestedCategoryIds: const ['c-food', 'c-other'],
  duplicateEntryId: duplicate,
);

Future<({FakeLedgerApi ledger, FakeAssistantApi assistant})> _pump(
  WidgetTester t, {
  List<Wallet>? wallets,
}) async {
  t.view.physicalSize = const Size(800, 4000);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  final walletApi = FakeWalletApi()
    ..wallets.addAll(wallets ?? [_wallet('w1', 'ملی من')]);
  final ledger = FakeLedgerApi(walletApi);
  final assistant = FakeAssistantApi();
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
        debtApiProvider.overrideWithValue(FakeDebtApi()),
        assetApiProvider.overrideWithValue(FakeAssetApi()),
        networthApiProvider.overrideWithValue(FakeNetWorthApi()),
        billingApiProvider.overrideWithValue(FakeBillingApi()),
        walletApiProvider.overrideWithValue(walletApi),
        ledgerApiProvider.overrideWithValue(ledger),
        categoryApiProvider.overrideWithValue(FakeCategoryApi(ledger)),
        assistantApiProvider.overrideWithValue(assistant),
      ],
      child: const SummaApp(),
    ),
  );
  await t.pumpAndSettle();
  await t.tap(find.text('پیامک بانک'));
  await t.pumpAndSettle();
  return (ledger: ledger, assistant: assistant);
}

Future<void> _paste(WidgetTester t) async {
  await t.enterText(find.byType(TextField), 'برداشت ۵۰۰٬۰۰۰ ریال');
  await t.tap(find.text('بررسی پیامک'));
  await t.pumpAndSettle();
}

void main() {
  testWidgets('a parsed SMS shows the card and registers on tap', (t) async {
    final s = await _pump(t);
    s.assistant.nextSms = _card();

    await _paste(t);

    expect(find.text('۵۰٬۰۰۰ تومان'), findsOneWidget);
    expect(find.textContaining('مانده پس از تراکنش'), findsOneWidget);
    expect(find.text('برای چه بود؟'), findsOneWidget);
    await t.tap(find.text('ثبت'));
    await t.pumpAndSettle();

    final e = s.ledger.entries.single;
    expect(
      (e.walletId, e.kind, e.amountMinor, e.categoryId),
      ('w1', EntryKind.expense, 50000, 'c-food'),
    );
    expect(find.text('ثبت شد'), findsOneWidget);
    expect(s.assistant.links, isEmpty); // already linked: nothing to remember
  });

  testWidgets('an unlinked card asks for a wallet and remembers the choice', (
    t,
  ) async {
    final s = await _pump(
      t,
      wallets: [_wallet('w1', 'ملی من'), _wallet('w2', 'نقد من')],
    );
    s.assistant.nextSms = _card(walletId: '', confidence: 'medium');

    await _paste(t);
    expect(
      find.textContaining('۴ رقم آخر ۱۲۳۴'),
      findsNothing,
    ); // digits are latin
    await t.tap(find.text('نقد من').last);
    await t.pumpAndSettle();
    await t.tap(find.text('ثبت'));
    await t.pumpAndSettle();

    expect(s.ledger.entries.single.walletId, 'w2');
    expect(s.assistant.links, [('1234', 'w2')]);
  });

  testWidgets('the person can pick another suggested category', (t) async {
    final s = await _pump(t);
    s.assistant.nextSms = _card();
    await _paste(t);

    await t.tap(find.text('سایر').first);
    await t.pumpAndSettle();
    await t.tap(find.text('ثبت'));
    await t.pumpAndSettle();

    expect(s.ledger.entries.single.categoryId, 'c-other');
  });

  testWidgets('an unknown direction must be chosen; income is recorded', (
    t,
  ) async {
    final s = await _pump(t);
    s.assistant.nextSms = _card(kind: '', confidence: 'low');
    await _paste(t);

    expect(find.textContaining('مطمئن نیستم'), findsOneWidget);
    expect(find.text('ثبت'), findsOneWidget);
    await t.tap(find.text('درآمد'));
    await t.pumpAndSettle();
    await t.tap(find.text('ثبت'));
    await t.pumpAndSettle();

    expect(s.ledger.entries.single.kind, EntryKind.income);
  });

  testWidgets('a likely duplicate is flagged', (t) async {
    final s = await _pump(t);
    s.assistant.nextSms = _card(duplicate: 'e9');

    await _paste(t);

    expect(find.textContaining('قبلاً ثبت شده'), findsOneWidget);
  });

  for (final (reason, text) in [
    ('otp', 'رمز یکبارمصرف'),
    ('failed', 'ناموفق'),
    ('ad', 'تبلیغاتی'),
    ('no_amount', 'مبلغی'),
  ]) {
    testWidgets('an ignored SMS ($reason) shows why and cannot be registered', (
      t,
    ) async {
      final s = await _pump(t);
      s.assistant.nextSms = _card(ignored: reason);

      await _paste(t);

      expect(find.textContaining(text), findsOneWidget);
      expect(find.text('ثبت'), findsNothing);
    });
  }
}
