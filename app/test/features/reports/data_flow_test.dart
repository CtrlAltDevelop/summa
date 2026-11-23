import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summa/features/auth/setup_prompt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/app.dart';
import 'package:summa/core/storage/file_saver.dart';
import 'package:summa/features/assets/asset_controller.dart';
import 'package:summa/features/auth/auth_controller.dart';
import 'package:summa/features/auth/token_store.dart';
import 'package:summa/features/billing/billing_controller.dart';
import 'package:summa/features/categories/category_controller.dart';
import 'package:summa/features/lock/authenticator.dart';
import 'package:summa/features/networth/networth_controller.dart';
import 'package:summa/features/reports/report_api.dart';
import 'package:summa/features/reports/report_controller.dart';
import 'package:summa/features/reports/report_models.dart';
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

class _FakeReportApi implements ReportApi {
  int exports = 0;
  final List<({String text, bool commit})> imports = [];
  ImportOutcome outcome = const ImportOutcome(
    rows: 2,
    importable: 2,
    imported: 0,
    skipped: 1,
    errors: [],
  );
  bool failExport = false;

  @override
  Future<ExportFile> exportCsv(String access) async {
    exports++;
    if (failExport) throw Exception('down');
    return const ExportFile(filename: 'summa-export.csv', bytes: [1, 2, 3]);
  }

  @override
  Future<ImportOutcome> importCsv(
    String access,
    String text, {
    required bool commit,
  }) async {
    imports.add((text: text, commit: commit));
    return commit && outcome.errors.isEmpty
        ? ImportOutcome(
            rows: outcome.rows,
            importable: outcome.importable,
            imported: outcome.importable,
            skipped: outcome.skipped,
            errors: const [],
          )
        : outcome;
  }

  @override
  Future<Report> monthly(
    String access, {
    required DateTime start,
    required DateTime end,
    required String currency,
  }) async => throw UnimplementedError();
}

class _FakeSaver implements FileSaver {
  final List<({String name, List<int> bytes})> saved = [];

  @override
  Future<String> save(String filename, List<int> bytes) async {
    saved.add((name: filename, bytes: bytes));
    return filename;
  }
}

typedef _Rig = ({_FakeReportApi api, _FakeSaver saver, FakeAuthenticator auth});

Future<_Rig> _pump(WidgetTester t) async {
  t.view.physicalSize = const Size(800, 14000);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  final wallets = FakeWalletApi();
  final ledger = FakeLedgerApi(wallets);
  final api = _FakeReportApi();
  final saver = _FakeSaver();
  final auth = FakeAuthenticator();
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
        reportApiProvider.overrideWithValue(api),
        fileSaverProvider.overrideWithValue(saver),
        authenticatorProvider.overrideWithValue(auth),
      ],
      child: const SummaApp(),
    ),
  );
  await t.pumpAndSettle();
  await t.tap(find.text('خروجی و ورود داده'));
  await t.pumpAndSettle();
  return (api: api, saver: saver, auth: auth);
}

Future<void> _paste(
  WidgetTester t, [
  String text = 'date,kind,amount,wallet',
]) async {
  await t.enterText(find.byType(TextField), text);
  await t.pumpAndSettle();
}

void main() {
  testWidgets('export proves identity, fetches and saves the file', (t) async {
    final rig = await _pump(t);

    await t.tap(find.text('گرفتن خروجی CSV'));
    await t.pumpAndSettle();

    expect(rig.auth.reasons, hasLength(1));
    expect(rig.api.exports, 1);
    expect(rig.saver.saved.single.name, 'summa-export.csv');
    expect(rig.saver.saved.single.bytes, [1, 2, 3]);
    expect(find.text('خروجی آماده شد: summa-export.csv'), findsOneWidget);
  });

  testWidgets('without identity nothing is exported', (t) async {
    final rig = await _pump(t);
    rig.auth.approves = false;

    await t.tap(find.text('گرفتن خروجی CSV'));
    await t.pumpAndSettle();

    expect(rig.api.exports, 0);
    expect(rig.saver.saved, isEmpty);
    expect(find.text('تأیید هویت نشد؛ کاری انجام نشد.'), findsOneWidget);
  });

  testWidgets('a failing export shows a message and saves nothing', (t) async {
    final rig = await _pump(t);
    rig.api.failExport = true;

    await t.tap(find.text('گرفتن خروجی CSV'));
    await t.pumpAndSettle();

    expect(find.text('خروجی گرفته نشد. دوباره امتحان کن.'), findsOneWidget);
    expect(rig.saver.saved, isEmpty);
  });

  testWidgets('a preview asks for identity and shows the counts', (t) async {
    final rig = await _pump(t);
    await _paste(t);

    await t.tap(find.text('پیش‌نمایش'));
    await t.pumpAndSettle();

    expect(rig.auth.reasons, hasLength(1));
    expect(rig.api.imports.single, (
      text: 'date,kind,amount,wallet',
      commit: false,
    ));
    expect(find.text('ردیف‌ها: ۲ · قابل ورود: ۲ · ردشده: ۱'), findsOneWidget);
    expect(find.text('ورود تراکنش‌ها'), findsOneWidget);
  });

  testWidgets('a clean preview can be imported after another identity check', (
    t,
  ) async {
    final rig = await _pump(t);
    await _paste(t);
    await t.tap(find.text('پیش‌نمایش'));
    await t.pumpAndSettle();

    await t.tap(find.text('ورود تراکنش‌ها'));
    await t.pumpAndSettle();

    expect(rig.auth.reasons, hasLength(2));
    expect(rig.api.imports.last.commit, isTrue);
    expect(find.text('۲ تراکنش وارد شد.'), findsOneWidget);
    expect(find.text('ورود تراکنش‌ها'), findsNothing);
  });

  testWidgets('errors are listed with their lines and block the import', (
    t,
  ) async {
    final rig = await _pump(t);
    rig.api.outcome = const ImportOutcome(
      rows: 3,
      importable: 1,
      imported: 0,
      skipped: 0,
      errors: [
        ImportLineError(line: 3, message: 'amount is not a positive number'),
        ImportLineError(
          line: 4,
          message: 'wallet is not one of your open wallets',
        ),
      ],
    );
    await _paste(t);

    await t.tap(find.text('پیش‌نمایش'));
    await t.pumpAndSettle();

    expect(find.text('خط ۳: amount is not a positive number'), findsOneWidget);
    expect(
      find.text('خط ۴: wallet is not one of your open wallets'),
      findsOneWidget,
    );
    expect(find.text('ورود تراکنش‌ها'), findsNothing);
  });

  testWidgets('without identity a preview is not even sent', (t) async {
    final rig = await _pump(t);
    rig.auth.approves = false;
    await _paste(t);

    await t.tap(find.text('پیش‌نمایش'));
    await t.pumpAndSettle();

    expect(rig.api.imports, isEmpty);
    expect(find.text('تأیید هویت نشد؛ کاری انجام نشد.'), findsOneWidget);
  });

  testWidgets('editing the text clears a stale preview', (t) async {
    await _pump(t);
    await _paste(t);
    await t.tap(find.text('پیش‌نمایش'));
    await t.pumpAndSettle();
    expect(find.text('ورود تراکنش‌ها'), findsOneWidget);

    await _paste(t, 'date,kind,amount,wallet\n2026-11-22,expense,1,ملی');

    expect(find.text('ورود تراکنش‌ها'), findsNothing);
  });
}
