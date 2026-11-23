import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summa/features/auth/setup_prompt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/app.dart';
import 'package:summa/core/storage/key_value_store.dart';
import 'package:summa/features/assets/asset_controller.dart';
import 'package:summa/features/auth/auth_controller.dart';
import 'package:summa/features/auth/token_store.dart';
import 'package:summa/features/billing/billing_controller.dart';
import 'package:summa/features/categories/category_controller.dart';
import 'package:summa/features/lock/authenticator.dart';
import 'package:summa/features/lock/lock_controller.dart';
import 'package:summa/features/lock/passcode.dart';
import 'package:summa/features/lock/secret_store.dart';
import 'package:summa/features/networth/networth_controller.dart';
import 'package:summa/features/privacy/privacy_api.dart';
import 'package:summa/features/privacy/privacy_controller.dart';
import 'package:summa/features/wallets/ledger_controller.dart';
import 'package:summa/features/wallets/wallets_controller.dart';

import '../assets/fake_asset_api.dart';
import '../auth/fake_auth_api.dart';
import '../billing/fake_billing_api.dart';
import '../categories/fake_category_api.dart';
import '../lock/fake_authenticator.dart';
import '../networth/fake_networth_api.dart';
import '../wallets/fake_ledger_api.dart';
import '../wallets/fake_wallet_api.dart';

class _FakePrivacyApi implements PrivacyApi {
  int retention = 0;
  final List<int> saved = [];
  final List<String> deletions = [];

  @override
  Future<int> chatRetentionDays(String access) async => retention;

  @override
  Future<void> setChatRetention(String access, int days) async {
    saved.add(days);
    retention = days;
  }

  @override
  Future<void> deleteAccount(String access, String confirmation) async {
    deletions.add(confirmation);
    if (confirmation != 'DELETE') throw Exception('refused');
  }
}

typedef _Rig = ({
  _FakePrivacyApi privacy,
  FakeAuthenticator auth,
  MemoryKeyValueStore store,
  FakeAuthApi authApi,
});

Future<_Rig> _pump(WidgetTester t, {bool biometrics = true}) async {
  t.view.physicalSize = const Size(800, 14000);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  final wallets = FakeWalletApi();
  final ledger = FakeLedgerApi(wallets);
  final privacy = _FakePrivacyApi();
  final auth = FakeAuthenticator()..available = biometrics;
  final store = MemoryKeyValueStore();
  final authApi = FakeAuthApi(profileName: 'سارا');
  await t.pumpWidget(
    ProviderScope(
      overrides: [
        setupPromptEnabledProvider.overrideWithValue(false),
        authApiProvider.overrideWithValue(authApi),
        tokenStoreProvider.overrideWithValue(
          MemoryTokenStore(authApi.currentTokens),
        ),
        walletApiProvider.overrideWithValue(wallets),
        ledgerApiProvider.overrideWithValue(ledger),
        categoryApiProvider.overrideWithValue(FakeCategoryApi(ledger)),
        assetApiProvider.overrideWithValue(FakeAssetApi()),
        networthApiProvider.overrideWithValue(FakeNetWorthApi()),
        billingApiProvider.overrideWithValue(FakeBillingApi()),
        privacyApiProvider.overrideWithValue(privacy),
        authenticatorProvider.overrideWithValue(auth),
        secretStoreProvider.overrideWithValue(MemorySecretStore()),
        keyValueStoreProvider.overrideWithValue(store),
        passcodeHasherProvider.overrideWithValue(
          const PasscodeHasher(iterations: 1),
        ),
      ],
      child: const SummaApp(),
    ),
  );
  await t.pumpAndSettle();
  await t.tap(find.text('حریم و امنیت'));
  await t.pumpAndSettle();
  return (privacy: privacy, auth: auth, store: store, authApi: authApi);
}

ProviderContainer _container(WidgetTester t) =>
    ProviderScope.containerOf(t.element(find.byType(SummaApp)));

Future<void> _enableLock(WidgetTester t) async {
  await t.tap(find.text('فعال‌کردن قفل اپ'));
  await t.pumpAndSettle();
  await t.enterText(find.byType(TextField).at(0), '4821');
  await t.enterText(find.byType(TextField).at(1), '4821');
  await t.tap(find.text('ذخیره'));
  await t.pumpAndSettle();
}

void main() {
  testWidgets('the lock is enabled from the privacy screen', (t) async {
    await _pump(t);

    await _enableLock(t);

    expect(_container(t).read(lockProvider).enabled, isTrue);
    expect(find.text('خاموش‌کردن قفل'), findsOneWidget);
    expect(find.text('قفل خودکار بعد از'), findsOneWidget);
  });

  testWidgets('it is turned off again with the passcode', (t) async {
    await _pump(t);
    await _enableLock(t);

    await t.tap(find.text('خاموش‌کردن قفل'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField), '4821');
    await t.tap(find.text('باز کردن'));
    await t.pumpAndSettle();

    expect(_container(t).read(lockProvider).enabled, isFalse);
    expect(find.text('فعال‌کردن قفل اپ'), findsOneWidget);
  });

  testWidgets('a wrong passcode does not turn it off', (t) async {
    await _pump(t);
    await _enableLock(t);

    await t.tap(find.text('خاموش‌کردن قفل'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField), '0000');
    await t.tap(find.text('باز کردن'));
    await t.pumpAndSettle();

    expect(find.text('رمز درست نیست.'), findsOneWidget);
    expect(_container(t).read(lockProvider).enabled, isTrue);
  });

  testWidgets('the biometric choice shows only where the device has them', (
    t,
  ) async {
    await _pump(t, biometrics: false);
    await _enableLock(t);

    expect(find.text('بیومتریک'), findsNothing);
  });

  testWidgets('biometrics and the auto-lock delay can be chosen', (t) async {
    await _pump(t);
    await _enableLock(t);

    await t.tap(find.text('روشن'));
    await t.tap(find.text('۱ دقیقه'));
    await t.pumpAndSettle();

    final lock = _container(t).read(lockProvider);
    expect((lock.biometric, lock.delaySeconds), (true, 60));
  });

  testWidgets('chat retention is shown and saved', (t) async {
    final rig = await _pump(t);
    rig.privacy.retention = 7;
    _container(t).invalidate(chatRetentionProvider);
    await t.pumpAndSettle();

    await t.tap(find.text('۳۰ روز'));
    await t.pumpAndSettle();

    expect(rig.privacy.saved, [30]);
  });

  testWidgets('deleting needs proof of identity and then the word DELETE', (
    t,
  ) async {
    final rig = await _pump(t);

    await t.tap(find.text('حذف حساب'));
    await t.pumpAndSettle();
    expect(rig.auth.reasons, hasLength(1));
    expect(find.textContaining('برای همیشه پاک می‌شود'), findsOneWidget);
    await t.enterText(find.byType(TextField).last, 'delete');
    await t.tap(find.text('حذف همیشگی حساب'));
    await t.pumpAndSettle();
    expect(find.textContaining('حذف انجام نشد'), findsOneWidget);
    expect(find.text('ورود به سومّا'), findsNothing);

    await t.enterText(find.byType(TextField).last, 'DELETE');
    await t.tap(find.text('حذف همیشگی حساب'));
    await t.pumpAndSettle();

    expect(rig.privacy.deletions, ['delete', 'DELETE']);
    expect(find.text('ورود به سومّا'), findsOneWidget);
  });

  testWidgets('a failed identity check never reaches the confirmation', (
    t,
  ) async {
    final rig = await _pump(t);
    rig.auth.approves = false;

    await t.tap(find.text('حذف حساب'));
    await t.pumpAndSettle();

    expect(find.text('تأیید نشد.'), findsOneWidget);
    expect(find.text('حذف همیشگی حساب'), findsNothing);
    expect(rig.privacy.deletions, isEmpty);
  });

  testWidgets('deleting the account wipes what is kept on the device', (
    t,
  ) async {
    final rig = await _pump(t);
    for (final key in AuthController.localDataKeys) {
      await rig.store.write(key, 'x');
    }

    await t.tap(find.text('حذف حساب'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).last, 'DELETE');
    await t.tap(find.text('حذف همیشگی حساب'));
    await t.pumpAndSettle();

    for (final key in AuthController.localDataKeys) {
      expect(await rig.store.read(key), isNull, reason: key);
    }
  });
}
