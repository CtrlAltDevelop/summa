import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/features/lock/authenticator.dart';
import 'package:summa/features/lock/lock_controller.dart';
import 'package:summa/features/lock/lock_screen.dart';
import 'package:summa/features/lock/passcode.dart';
import 'package:summa/features/lock/secret_store.dart';
import 'package:summa/features/lock/strong_auth.dart';
import 'package:summa/l10n/gen/app_localizations.dart';

import 'fake_authenticator.dart';

Widget _app(Widget home, List<Override> overrides) => ProviderScope(
  overrides: [
    passcodeHasherProvider.overrideWithValue(
      const PasscodeHasher(iterations: 1),
    ),
    ...overrides,
  ],
  child: MaterialApp(
    locale: const Locale('fa'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  ),
);

class _Probe extends StatelessWidget {
  const _Probe();

  @override
  Widget build(BuildContext context) => const Text('محتوای محرمانه');
}

class _StrongAuthButton extends ConsumerWidget {
  const _StrongAuthButton(this.result);

  final ValueNotifier<bool?> result;

  @override
  Widget build(BuildContext context, WidgetRef ref) => GestureDetector(
    onTap: () async => result.value = await confirmStrongAuth(context, ref),
    child: const Text('کار حساس'),
  );
}

Future<ProviderContainer> _containerOf(WidgetTester t) async =>
    ProviderScope.containerOf(t.element(find.byType(MaterialApp)));

void main() {
  group('LockGate', () {
    testWidgets('without a lock the app is simply shown', (t) async {
      await t.pumpWidget(_app(const LockGate(child: _Probe()), []));
      await t.pumpAndSettle();

      expect(find.text('محتوای محرمانه'), findsOneWidget);
      expect(find.byType(LockScreen), findsNothing);
    });

    testWidgets('a locked app hides its content behind the lock screen', (
      t,
    ) async {
      await t.pumpWidget(_app(const LockGate(child: _Probe()), []));
      await t.pumpAndSettle();
      final c = await _containerOf(t);
      await c.read(lockProvider.notifier).enable('4821');
      c.read(lockProvider.notifier).lockNow();
      await t.pumpAndSettle();

      expect(find.byType(LockScreen), findsOneWidget);
      expect(find.text('محتوای محرمانه', skipOffstage: true), findsNothing);
      expect(find.text('Summa قفل است'), findsOneWidget);
    });

    testWidgets('the right passcode opens it, a wrong one says so', (t) async {
      await t.pumpWidget(_app(const LockGate(child: _Probe()), []));
      await t.pumpAndSettle();
      final c = await _containerOf(t);
      await c.read(lockProvider.notifier).enable('4821');
      c.read(lockProvider.notifier).lockNow();
      await t.pumpAndSettle();

      await t.enterText(find.byType(TextField), '0000');
      await t.tap(find.text('باز کردن'));
      await t.pumpAndSettle();
      expect(find.text('رمز درست نیست.'), findsOneWidget);

      await t.enterText(find.byType(TextField), '4821');
      await t.tap(find.text('باز کردن'));
      await t.pumpAndSettle();

      expect(find.byType(LockScreen), findsNothing);
      expect(find.text('محتوای محرمانه'), findsOneWidget);
    });

    testWidgets('the waiting after many wrong codes is announced', (t) async {
      await t.pumpWidget(_app(const LockGate(child: _Probe()), []));
      await t.pumpAndSettle();
      final c = await _containerOf(t);
      await c.read(lockProvider.notifier).enable('4821');
      c.read(lockProvider.notifier).lockNow();
      await t.pumpAndSettle();

      for (var i = 0; i < 6; i++) {
        await t.enterText(find.byType(TextField), '0000');
        await t.tap(find.text('باز کردن'));
        await t.pumpAndSettle();
      }

      expect(find.textContaining('کمی صبر کن'), findsOneWidget);
    });

    testWidgets('going to the background and back locks it again', (t) async {
      await t.pumpWidget(_app(const LockGate(child: _Probe()), []));
      await t.pumpAndSettle();
      final c = await _containerOf(t);
      await c.read(lockProvider.notifier).enable('4821');
      await t.pumpAndSettle();
      expect(find.byType(LockScreen), findsNothing);

      t.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      t.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await t.pumpAndSettle();

      expect(find.byType(LockScreen), findsOneWidget);
    });

    testWidgets('the biometric button appears only when it is chosen', (
      t,
    ) async {
      final auth = FakeAuthenticator();
      await t.pumpWidget(
        _app(const LockGate(child: _Probe()), [
          authenticatorProvider.overrideWithValue(auth),
        ]),
      );
      await t.pumpAndSettle();
      final c = await _containerOf(t);
      await c.read(lockProvider.notifier).enable('4821');
      c.read(lockProvider.notifier).lockNow();
      await t.pumpAndSettle();
      expect(find.text('باز کردن با بیومتریک'), findsNothing);

      await c.read(lockProvider.notifier).setBiometric(on: true);
      await t.pumpAndSettle();
      await t.tap(find.text('باز کردن با بیومتریک'));
      await t.pumpAndSettle();

      expect(auth.reasons, ['باز کردن Summa']);
      expect(find.byType(LockScreen), findsNothing);
    });
  });

  group('confirmStrongAuth', () {
    Future<ValueNotifier<bool?>> pump(
      WidgetTester t, {
      required FakeAuthenticator auth,
    }) async {
      final result = ValueNotifier<bool?>(null);
      await t.pumpWidget(
        _app(_StrongAuthButton(result), [
          authenticatorProvider.overrideWithValue(auth),
          secretStoreProvider.overrideWithValue(MemorySecretStore()),
        ]),
      );
      await t.pumpAndSettle();
      return result;
    }

    testWidgets('with biometrics on the device they are used', (t) async {
      final auth = FakeAuthenticator();
      final result = await pump(t, auth: auth);

      await t.tap(find.text('کار حساس'));
      await t.pumpAndSettle();

      expect(result.value, isTrue);
      expect(auth.reasons, ['برای ادامه هویتت را تأیید کن']);
    });

    testWidgets('a refused biometric prompt is a no', (t) async {
      final auth = FakeAuthenticator()..approves = false;
      final result = await pump(t, auth: auth);

      await t.tap(find.text('کار حساس'));
      await t.pumpAndSettle();

      expect(result.value, isFalse);
    });

    testWidgets(
      'no biometrics and no lock: set a passcode first, then confirm',
      (t) async {
        final result = await pump(
          t,
          auth: FakeAuthenticator()..available = false,
        );

        await t.tap(find.text('کار حساس'));
        await t.pumpAndSettle();
        expect(
          find.text('این کار حساس است. اول یک رمز برای اپ تعیین کن.'),
          findsOneWidget,
        );
        await t.enterText(find.byType(TextField).at(0), '4821');
        await t.enterText(find.byType(TextField).at(1), '4821');
        await t.tap(find.text('ذخیره'));
        await t.pumpAndSettle();
        expect(find.text('رمز اپ را وارد کن'), findsOneWidget);
        await t.enterText(find.byType(TextField), '4821');
        await t.tap(find.text('باز کردن'));
        await t.pumpAndSettle();

        expect(result.value, isTrue);
        final c = await _containerOf(t);
        expect(c.read(lockProvider).enabled, isTrue);
      },
    );

    testWidgets('a passcode that does not match is not saved', (t) async {
      final result = await pump(
        t,
        auth: FakeAuthenticator()..available = false,
      );

      await t.tap(find.text('کار حساس'));
      await t.pumpAndSettle();
      await t.enterText(find.byType(TextField).at(0), '4821');
      await t.enterText(find.byType(TextField).at(1), '4822');
      await t.tap(find.text('ذخیره'));
      await t.pumpAndSettle();

      expect(find.text('دو رمز یکی نیست.'), findsOneWidget);
      expect(result.value, isNull);
      final c = await _containerOf(t);
      expect(c.read(lockProvider).enabled, isFalse);
    });

    testWidgets('a short passcode is refused', (t) async {
      await pump(t, auth: FakeAuthenticator()..available = false);

      await t.tap(find.text('کار حساس'));
      await t.pumpAndSettle();
      await t.enterText(find.byType(TextField).at(0), '12');
      await t.enterText(find.byType(TextField).at(1), '12');
      await t.tap(find.text('ذخیره'));
      await t.pumpAndSettle();

      expect(find.text('رمز باید ۴ تا ۸ رقم باشد.'), findsOneWidget);
    });

    testWidgets('with a lock but no biometrics the passcode is asked', (
      t,
    ) async {
      final result = await pump(
        t,
        auth: FakeAuthenticator()..available = false,
      );
      final c = await _containerOf(t);
      await c.read(lockProvider.notifier).enable('4821');

      await t.tap(find.text('کار حساس'));
      await t.pumpAndSettle();
      await t.enterText(find.byType(TextField), '0000');
      await t.tap(find.text('باز کردن'));
      await t.pumpAndSettle();
      expect(find.text('رمز درست نیست.'), findsOneWidget);
      await t.enterText(find.byType(TextField), '4821');
      await t.tap(find.text('باز کردن'));
      await t.pumpAndSettle();

      expect(result.value, isTrue);
    });
  });
}
