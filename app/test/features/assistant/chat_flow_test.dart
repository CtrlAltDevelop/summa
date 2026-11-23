import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/app.dart';
import 'package:summa/features/assistant/assistant_controller.dart';
import 'package:summa/features/assistant/chat_models.dart';
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

Future<({FakeLedgerApi ledger, FakeAssistantApi assistant})> _pump(
  WidgetTester t, {
  List<Wallet>? wallets,
}) async {
  final walletApi = FakeWalletApi()
    ..wallets.addAll(wallets ?? [_wallet('w1', 'ملی من')]);
  final ledger = FakeLedgerApi(walletApi);
  final assistant = FakeAssistantApi();
  final auth = FakeAuthApi(profileName: 'سارا');
  await t.pumpWidget(
    ProviderScope(
      overrides: [
        authApiProvider.overrideWithValue(auth),
        tokenStoreProvider.overrideWithValue(
          MemoryTokenStore(auth.currentTokens),
        ),
        recurringApiProvider.overrideWithValue(FakeRecurringApi()),
        debtApiProvider.overrideWithValue(FakeDebtApi()),
        assetApiProvider.overrideWithValue(FakeAssetApi()),
        walletApiProvider.overrideWithValue(walletApi),
        ledgerApiProvider.overrideWithValue(ledger),
        categoryApiProvider.overrideWithValue(FakeCategoryApi(ledger)),
        assistantApiProvider.overrideWithValue(assistant),
      ],
      child: const SummaApp(),
    ),
  );
  await t.pumpAndSettle();
  await t.tap(find.text('دستیار'));
  await t.pumpAndSettle();
  return (ledger: ledger, assistant: assistant);
}

Future<void> _say(WidgetTester t, String text) async {
  await t.enterText(find.byType(TextField), text);
  await t.tap(find.text('ارسال'));
  await t.pumpAndSettle();
}

ChatCard _card({String walletId = 'w1', String kind = 'expense'}) => ChatCard(
  kind: kind,
  amountMinor: 250000,
  currency: 'IRT',
  walletId: walletId,
  toWalletId: '',
  categoryId: 'c-food',
  note: 'خرید نان',
  occurredAt: DateTime.utc(2026, 11, 19),
);

void main() {
  testWidgets('an empty chat invites a sentence', (t) async {
    await _pump(t);

    expect(find.textContaining('جمله‌ای بنویس'), findsOneWidget);
  });

  testWidgets('a sentence shows both bubbles and the register button', (
    t,
  ) async {
    final s = await _pump(t);
    s.assistant.nextCard = _card();

    await _say(t, '۲۵۰ هزار تومن خرید نان');

    expect(s.assistant.sent, ['۲۵۰ هزار تومن خرید نان']);
    expect(find.text('۲۵۰ هزار تومن خرید نان'), findsOneWidget);
    expect(find.text('این را ثبت کنم؟'), findsOneWidget);
    expect(find.text('ثبت'), findsOneWidget);
  });

  testWidgets('register sends the ordinary record request from the card', (
    t,
  ) async {
    final s = await _pump(t);
    s.assistant.nextCard = _card();
    await _say(t, 'نان');

    await t.tap(find.text('ثبت'));
    await t.pumpAndSettle();

    final entry = s.ledger.entries.single;
    expect(
      (entry.walletId, entry.kind, entry.amountMinor, entry.categoryId),
      ('w1', EntryKind.expense, 250000, 'c-food'),
    );
    expect(find.text('ثبت شد'), findsOneWidget);
    expect(find.text('ثبت'), findsNothing);
  });

  testWidgets('without a wallet on the card the person chooses one', (t) async {
    final s = await _pump(
      t,
      wallets: [_wallet('w1', 'ملی من'), _wallet('w2', 'نقد من')],
    );
    s.assistant.nextCard = _card(walletId: '');
    await _say(t, 'نان');

    expect(find.text('کیف را انتخاب کن'), findsOneWidget);
    await t.tap(find.text('نقد من').last);
    await t.pumpAndSettle();
    await t.tap(find.text('ثبت'));
    await t.pumpAndSettle();

    expect(s.ledger.entries.single.walletId, 'w2');
  });

  testWidgets('no card for a sentence the assistant did not understand', (
    t,
  ) async {
    final s = await _pump(t);

    await _say(t, 'سلام');

    expect(s.assistant.messages, hasLength(2));
    expect(find.text('ثبت'), findsNothing);
  });

  testWidgets('clear empties the chat', (t) async {
    final s = await _pump(t);
    await _say(t, 'سلام');

    await t.tap(find.text('پاک‌کردن گفتگو'));
    await t.pumpAndSettle();

    expect(s.assistant.messages, isEmpty);
    expect(find.textContaining('جمله‌ای بنویس'), findsOneWidget);
  });
}
