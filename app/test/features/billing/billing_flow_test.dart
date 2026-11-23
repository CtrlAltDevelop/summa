import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/app.dart';
import 'package:summa/features/assets/asset_controller.dart';
import 'package:summa/features/auth/auth_controller.dart';
import 'package:summa/features/auth/token_store.dart';
import 'package:summa/features/billing/billing_controller.dart';
import 'package:summa/features/billing/billing_models.dart';
import 'package:summa/features/categories/category_controller.dart';
import 'package:summa/features/networth/networth_controller.dart';
import 'package:summa/features/wallets/ledger_controller.dart';
import 'package:summa/features/wallets/wallets_controller.dart';

import '../assets/fake_asset_api.dart';
import '../auth/fake_auth_api.dart';
import '../categories/fake_category_api.dart';
import '../networth/fake_networth_api.dart';
import '../wallets/fake_ledger_api.dart';
import '../wallets/fake_wallet_api.dart';
import 'fake_billing_api.dart';

const _monthly = PlanInfo(
  code: 'monthly',
  name: 'ماهانه',
  description: 'همه امکانات',
  priceMinor: 150000,
  periodDays: 30,
);

Future<FakeBillingApi> _pump(
  WidgetTester t, {
  SubscriptionStatus? status,
  List<PlanInfo> plans = const [],
}) async {
  t.view.physicalSize = const Size(800, 12000);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  final wallets = FakeWalletApi();
  final ledger = FakeLedgerApi(wallets);
  final billing = FakeBillingApi()..planList.addAll(plans);
  if (status != null) billing.current = status;
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
        billingApiProvider.overrideWithValue(billing),
      ],
      child: const SummaApp(),
    ),
  );
  await t.pumpAndSettle();
  return billing;
}

SubscriptionStatus _status(
  String s, {
  int days = 0,
  bool write = true,
  bool trial = false,
}) => SubscriptionStatus(
  status: s,
  daysLeft: days,
  canWrite: write,
  trialAvailable: trial,
);

Future<void> _open(WidgetTester t) async {
  await t.tap(find.text('اشتراک'));
  await t.pumpAndSettle();
}

void main() {
  testWidgets('the status line says what the person has', (t) async {
    await _pump(t, status: _status('active', days: 12));
    await _open(t);

    expect(find.text('اشتراک فعال؛ ۱۲ روز مانده'), findsOneWidget);
  });

  for (final (status, text) in [
    (_status('trial', days: 5), 'دوره آزمایشی؛ ۵ روز مانده'),
    (_status('expired', write: false), 'اشتراکت تمام شده است.'),
    (_status('none', trial: true), 'هنوز اشتراکی نداری.'),
  ]) {
    testWidgets('status text: $text', (t) async {
      await _pump(t, status: status);
      await _open(t);

      expect(find.text(text), findsOneWidget);
    });
  }

  testWidgets('the trial can be started once it is on offer', (t) async {
    final api = await _pump(t, status: _status('none', trial: true));
    await _open(t);

    await t.tap(find.text('شروع دوره آزمایشی'));
    await t.pumpAndSettle();

    expect(api.trialsStarted, 1);
    expect(find.text('دوره آزمایشی؛ ۱۴ روز مانده'), findsOneWidget);
    expect(find.text('شروع دوره آزمایشی'), findsNothing);
  });

  testWidgets('no trial button when it is not available', (t) async {
    await _pump(t, status: _status('expired', write: false));
    await _open(t);

    expect(find.text('شروع دوره آزمایشی'), findsNothing);
  });

  testWidgets('with no plans the screen says so', (t) async {
    await _pump(t);
    await _open(t);

    expect(find.text('فعلاً پلنی برای خرید نیست.'), findsOneWidget);
  });

  testWidgets('a plan shows its price and can be bought and verified', (
    t,
  ) async {
    final api = await _pump(t, plans: [_monthly]);
    await _open(t);

    expect(find.text('۱۵۰٬۰۰۰ تومان · ۳۰ روز'), findsOneWidget);
    await t.tap(find.text('خرید'));
    await t.pumpAndSettle();
    expect(api.checkouts, ['monthly']);
    expect(find.text('summa://pay/ref-1'), findsOneWidget);

    await t.tap(find.text('بررسی پرداخت'));
    await t.pumpAndSettle();

    expect(api.verified, ['ref-1']);
    expect(find.text('اشتراک فعال؛ ۳۰ روز مانده'), findsOneWidget);
    expect(find.text('بررسی پرداخت'), findsNothing);
  });

  testWidgets('a payment the gateway did not confirm stays pending', (t) async {
    final api = await _pump(t, plans: [_monthly]);
    api.confirms = false;
    await _open(t);

    await t.tap(find.text('خرید'));
    await t.pumpAndSettle();
    await t.tap(find.text('بررسی پرداخت'));
    await t.pumpAndSettle();

    expect(find.text('پرداخت هنوز تأیید نشده.'), findsOneWidget);
    expect(find.text('بررسی پرداخت'), findsOneWidget);
  });

  testWidgets('a failing checkout shows a message', (t) async {
    final api = await _pump(t, plans: [_monthly]);
    api.failCheckout = true;
    await _open(t);

    await t.tap(find.text('خرید'));
    await t.pumpAndSettle();

    expect(find.text('انجام نشد. دوباره امتحان کن.'), findsOneWidget);
  });

  testWidgets('a read-only account sees the banner and can go renew', (
    t,
  ) async {
    await _pump(t, status: _status('expired', write: false), plans: [_monthly]);

    expect(
      find.text('اشتراکت تمام شده؛ فعلاً فقط می‌توانی داده‌ات را ببینی.'),
      findsOneWidget,
    );
    await t.tap(find.text('تمدید'));
    await t.pumpAndSettle();

    expect(find.text('ماهانه'), findsOneWidget);
  });

  testWidgets('a writable account has no banner', (t) async {
    await _pump(t, status: _status('active', days: 3));

    expect(find.text('تمدید'), findsNothing);
  });
}
