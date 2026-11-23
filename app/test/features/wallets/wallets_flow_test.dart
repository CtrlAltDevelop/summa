import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/app.dart';
import 'package:summa/features/auth/auth_controller.dart';
import 'package:summa/features/auth/token_store.dart';
import 'package:summa/features/wallets/wallet_models.dart';
import 'package:summa/features/wallets/wallets_controller.dart';

import '../auth/fake_auth_api.dart';
import 'fake_wallet_api.dart';

Future<void> _pump(WidgetTester t, FakeWalletApi wallets) async {
  final auth = FakeAuthApi(profileName: 'سارا');
  await t.pumpWidget(
    ProviderScope(
      overrides: [
        authApiProvider.overrideWithValue(auth),
        tokenStoreProvider.overrideWithValue(
          MemoryTokenStore(auth.currentTokens),
        ),
        walletApiProvider.overrideWithValue(wallets),
      ],
      child: const SummaApp(),
    ),
  );
  await t.pumpAndSettle();
}

void main() {
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
