import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/app.dart';
import 'package:summa/features/assets/asset_controller.dart';
import 'package:summa/features/auth/auth_controller.dart';
import 'package:summa/features/auth/token_store.dart';
import 'package:summa/features/billing/billing_controller.dart';
import 'package:summa/features/categories/category_controller.dart';
import 'package:summa/features/networth/networth_controller.dart';
import 'package:summa/features/support/support_api.dart';
import 'package:summa/features/support/support_controller.dart';
import 'package:summa/features/support/support_models.dart';
import 'package:summa/features/wallets/ledger_controller.dart';
import 'package:summa/features/wallets/wallets_controller.dart';

import '../assets/fake_asset_api.dart';
import '../auth/fake_auth_api.dart';
import '../billing/fake_billing_api.dart';
import '../categories/fake_category_api.dart';
import '../networth/fake_networth_api.dart';
import '../wallets/fake_ledger_api.dart';
import '../wallets/fake_wallet_api.dart';

class _FakeSupportApi implements SupportApi {
  final List<SupportTicket> list = [];
  final Map<String, List<SupportMessage>> threads = {};
  final List<({String subject, String body})> opened = [];
  final List<({String id, String body})> sent = [];
  bool fail = false;

  @override
  Future<List<SupportTicket>> tickets(String access) async => List.of(list);

  @override
  Future<SupportTicket> open(
    String access, {
    required String subject,
    required String body,
  }) async {
    if (fail) throw Exception('down');
    opened.add((subject: subject, body: body));
    final t = SupportTicket(
      id: 't${list.length + 1}',
      reference: 'SUP-${list.length + 1}',
      subject: subject,
      status: 'open',
      lastMessageAt: DateTime.utc(2026, 11, 22),
      unread: 0,
    );
    list.add(t);
    threads[t.id] = [
      SupportMessage(
        id: 'm1',
        body: body,
        fromTeam: false,
        createdAt: DateTime.utc(2026, 11, 22),
      ),
    ];
    return t;
  }

  @override
  Future<List<SupportMessage>> messages(String access, String ticketId) async =>
      List.of(threads[ticketId] ?? const []);

  @override
  Future<void> send(String access, String ticketId, String body) async {
    if (fail) throw Exception('down');
    sent.add((id: ticketId, body: body));
    threads[ticketId] = [
      ...?threads[ticketId],
      SupportMessage(
        id: 'm${(threads[ticketId]?.length ?? 0) + 1}',
        body: body,
        fromTeam: false,
        createdAt: DateTime.utc(2026, 11, 23),
      ),
    ];
  }
}

Future<_FakeSupportApi> _pump(WidgetTester t) async {
  t.view.physicalSize = const Size(800, 12000);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  final wallets = FakeWalletApi();
  final ledger = FakeLedgerApi(wallets);
  final support = _FakeSupportApi();
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
        billingApiProvider.overrideWithValue(FakeBillingApi()),
        supportApiProvider.overrideWithValue(support),
      ],
      child: const SummaApp(),
    ),
  );
  await t.pumpAndSettle();
  await t.tap(find.text('پشتیبانی'));
  await t.pumpAndSettle();
  return support;
}

void main() {
  testWidgets('with no tickets the screen says so', (t) async {
    await _pump(t);

    expect(find.text('هنوز تیکتی نداری.'), findsOneWidget);
  });

  testWidgets('a ticket is opened with a subject and a body', (t) async {
    final api = await _pump(t);

    await t.tap(find.text('تیکت جدید'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).at(0), 'مشکل در ثبت');
    await t.enterText(find.byType(TextField).at(1), 'خرج ثبت نمی‌شود');
    await t.tap(find.text('ارسال'));
    await t.pumpAndSettle();

    expect(api.opened.single, (
      subject: 'مشکل در ثبت',
      body: 'خرج ثبت نمی‌شود',
    ));
    expect(find.text('مشکل در ثبت'), findsOneWidget);
    expect(find.textContaining('باز'), findsOneWidget);
  });

  testWidgets('an empty subject or body is refused before the server', (
    t,
  ) async {
    final api = await _pump(t);

    await t.tap(find.text('تیکت جدید'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).at(0), 'فقط موضوع');
    await t.tap(find.text('ارسال'));
    await t.pumpAndSettle();

    expect(find.text('موضوع و متن را بنویس.'), findsOneWidget);
    expect(api.opened, isEmpty);
  });

  testWidgets('a failing server shows a message and keeps the form', (t) async {
    final api = await _pump(t);
    api.fail = true;

    await t.tap(find.text('تیکت جدید'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).at(0), 'x');
    await t.enterText(find.byType(TextField).at(1), 'y');
    await t.tap(find.text('ارسال'));
    await t.pumpAndSettle();

    expect(find.text('ارسال نشد. دوباره امتحان کن.'), findsOneWidget);
    expect(find.text('ارسال'), findsOneWidget);
  });

  testWidgets('opening a ticket shows its thread, and a reply is added', (
    t,
  ) async {
    final api = await _pump(t);
    await t.tap(find.text('تیکت جدید'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).at(0), 'موضوع');
    await t.enterText(find.byType(TextField).at(1), 'متن اول');
    await t.tap(find.text('ارسال'));
    await t.pumpAndSettle();

    await t.tap(find.text('موضوع'));
    await t.pumpAndSettle();
    expect(find.text('متن اول'), findsOneWidget);
    await t.enterText(find.byType(TextField), 'یک پیام دیگر');
    await t.tap(find.text('ارسال'));
    await t.pumpAndSettle();

    expect(api.sent.single, (id: 't1', body: 'یک پیام دیگر'));
    expect(find.text('یک پیام دیگر'), findsOneWidget);
  });

  testWidgets('the team\'s messages are marked as theirs', (t) async {
    final api = await _pump(t);
    api.list.add(
      const SupportTicket(
        id: 't9',
        reference: 'SUP-9',
        subject: 'سؤال',
        status: 'pending',
        lastMessageAt: null,
        unread: 2,
      ),
    );
    api.threads['t9'] = [
      const SupportMessage(
        id: 'a',
        body: 'سلام، چه کمکی از دستم برمی‌آید؟',
        fromTeam: true,
        createdAt: null,
      ),
    ];
    ProviderScope.containerOf(t.element(find.byType(SummaApp)))
        .invalidate(ticketsProvider);
    await t.pumpAndSettle();

    expect(find.text('پیام جدید'), findsOneWidget);
    expect(find.textContaining('در انتظار پاسخ'), findsOneWidget);
    await t.tap(find.text('سؤال'));
    await t.pumpAndSettle();

    expect(find.text('پشتیبان'), findsOneWidget);
    expect(find.text('سلام، چه کمکی از دستم برمی‌آید؟'), findsOneWidget);
  });
}
