import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/features/lock/authenticator.dart';
import 'package:summa/features/lock/lock_controller.dart';
import 'package:summa/features/lock/passcode.dart';
import 'package:summa/features/lock/secret_store.dart';

import 'fake_authenticator.dart';

class _Rig {
  _Rig({MemorySecretStore? store}) : store = store ?? MemorySecretStore() {
    container = ProviderContainer(
      overrides: [
        secretStoreProvider.overrideWithValue(this.store),
        passcodeHasherProvider.overrideWithValue(
          const PasscodeHasher(iterations: 2),
        ),
        clockProvider.overrideWithValue(() => now),
        authenticatorProvider.overrideWithValue(auth),
      ],
    );
  }

  final MemorySecretStore store;
  final auth = FakeAuthenticator();
  DateTime now = DateTime.utc(2026, 11, 22, 9);
  late final ProviderContainer container;

  LockController get lock => container.read(lockProvider.notifier);
  LockState get state => container.read(lockProvider);

  Future<void> loaded() async {
    container.read(lockProvider);
    await Future<void>.delayed(Duration.zero);
  }
}

void main() {
  group('PasscodeHasher', () {
    test('matches the PBKDF2-HMAC-SHA256 test vector (first 32 bytes)', () {
      const hasher = PasscodeHasher(iterations: 1);

      final hex = hasher
          .hash('passwd', utf8.encode('salt'))
          .map((b) => b.toRadixString(16).padLeft(2, '0'))
          .join();

      expect(
        hex,
        '55ac046e56e3089fec1691c22544b605f94185216dde0465e68b9d57c20dacbc',
      );
    });

    test('verify accepts the right code and refuses others', () {
      const hasher = PasscodeHasher(iterations: 3);
      final salt = PasscodeHasher.newSalt();
      final hash = hasher.hash('1234', salt);

      expect(hasher.verify('1234', salt, hash), isTrue);
      expect(hasher.verify('1235', salt, hash), isFalse);
      expect(hasher.verify('1234', PasscodeHasher.newSalt(), hash), isFalse);
      expect(hasher.verify('1234', salt, hash.sublist(1)), isFalse);
    });

    test('more iterations give a different hash', () {
      final salt = PasscodeHasher.newSalt();

      expect(
        const PasscodeHasher(iterations: 2).hash('1234', salt),
        isNot(const PasscodeHasher(iterations: 3).hash('1234', salt)),
      );
    });

    test('salts are random', () {
      expect(PasscodeHasher.newSalt(), isNot(PasscodeHasher.newSalt()));
    });
  });

  test('a passcode is four to eight digits', () {
    for (final ok in ['1234', '12345678', '0000']) {
      expect(isValidPasscode(ok), isTrue, reason: ok);
    }
    for (final bad in ['', '123', '123456789', '12a4', '12 34', '١٢٣٤']) {
      expect(isValidPasscode(bad), isFalse, reason: bad);
    }
  });

  test('the wait after wrong codes doubles up to a ceiling', () {
    expect(LockController.waitFor(4), Duration.zero);
    expect(LockController.waitFor(5), const Duration(seconds: 30));
    expect(LockController.waitFor(6), const Duration(seconds: 60));
    expect(LockController.waitFor(7), const Duration(seconds: 120));
    expect(LockController.waitFor(30), longestWait);
  });

  group('LockController', () {
    test(
      'with nothing saved the app is unlocked and the lock is off',
      () async {
        final rig = _Rig();
        await rig.loaded();

        expect(
          (rig.state.loaded, rig.state.enabled, rig.state.locked),
          (true, false, false),
        );
      },
    );

    test('enabling keeps this session open and stores only a hash', () async {
      final rig = _Rig();
      await rig.loaded();

      await rig.lock.enable('4821');

      expect((rig.state.enabled, rig.state.locked), (true, false));
      final saved = (await rig.store.read(lockStorageKey))!;
      expect(saved.contains('4821'), isFalse);
      expect(jsonDecode(saved), containsPair('failed', 0));
    });

    test('a restart asks for the passcode again', () async {
      final store = MemorySecretStore();
      final first = _Rig(store: store);
      await first.loaded();
      await first.lock.enable('4821');

      final second = _Rig(store: store);
      await second.loaded();

      expect((second.state.enabled, second.state.locked), (true, true));
      expect(await second.lock.unlockWithPasscode('4821'), UnlockResult.ok);
      expect(second.state.locked, isFalse);
    });

    test('an invalid passcode cannot be set', () async {
      final rig = _Rig();
      await rig.loaded();

      expect(() => rig.lock.enable('12'), throwsArgumentError);
      expect(rig.state.enabled, isFalse);
    });

    test(
      'five wrong codes start the waiting, even the right one is refused',
      () async {
        final rig = _Rig();
        await rig.loaded();
        await rig.lock.enable('4821');
        rig.lock.lockNow();

        for (var i = 0; i < 4; i++) {
          expect(await rig.lock.unlockWithPasscode('0000'), UnlockResult.wrong);
        }
        expect(await rig.lock.unlockWithPasscode('0000'), UnlockResult.wrong);
        expect(
          await rig.lock.unlockWithPasscode('4821'),
          UnlockResult.lockedOut,
        );
        expect(rig.state.locked, isTrue);

        rig.now = rig.now.add(const Duration(seconds: 31));
        expect(await rig.lock.unlockWithPasscode('4821'), UnlockResult.ok);
        expect(rig.state.failedAttempts, 0);
      },
    );

    test('the waiting grows with every further wrong code', () async {
      final rig = _Rig();
      await rig.loaded();
      await rig.lock.enable('4821');
      rig.lock.lockNow();
      for (var i = 0; i < 5; i++) {
        await rig.lock.unlockWithPasscode('0000');
      }
      rig.now = rig.now.add(const Duration(seconds: 31));
      await rig.lock.unlockWithPasscode('0000'); // 6th: 60 s

      rig.now = rig.now.add(const Duration(seconds: 59));
      expect(await rig.lock.unlockWithPasscode('4821'), UnlockResult.lockedOut);
      rig.now = rig.now.add(const Duration(seconds: 2));
      expect(await rig.lock.unlockWithPasscode('4821'), UnlockResult.ok);
    });

    test('the waiting survives closing the app', () async {
      final store = MemorySecretStore();
      final first = _Rig(store: store);
      await first.loaded();
      await first.lock.enable('4821');
      first.lock.lockNow();
      for (var i = 0; i < 5; i++) {
        await first.lock.unlockWithPasscode('0000');
      }

      final second = _Rig(store: store)..now = first.now;
      await second.loaded();

      expect(second.state.failedAttempts, 5);
      expect(
        await second.lock.unlockWithPasscode('4821'),
        UnlockResult.lockedOut,
      );
    });

    test('turning the lock off needs the passcode', () async {
      final rig = _Rig();
      await rig.loaded();
      await rig.lock.enable('4821');

      expect(await rig.lock.disable('0000'), UnlockResult.wrong);
      expect(rig.state.enabled, isTrue);
      expect(await rig.lock.disable('4821'), UnlockResult.ok);
      expect(rig.state.enabled, isFalse);
      expect(await rig.store.read(lockStorageKey), isNull);
    });

    test('changing the passcode needs the old one and replaces it', () async {
      final rig = _Rig();
      await rig.loaded();
      await rig.lock.enable('4821');

      expect(await rig.lock.changePasscode('0000', '9999'), UnlockResult.wrong);
      expect(await rig.lock.changePasscode('4821', '9999'), UnlockResult.ok);
      rig.lock.lockNow();

      expect(await rig.lock.unlockWithPasscode('4821'), UnlockResult.wrong);
      expect(await rig.lock.unlockWithPasscode('9999'), UnlockResult.ok);
    });

    test('going to the background locks after the chosen delay', () async {
      final rig = _Rig();
      await rig.loaded();
      await rig.lock.enable('4821');
      await rig.lock.setDelay(60);

      rig.lock.onPaused();
      rig.now = rig.now.add(const Duration(seconds: 59));
      rig.lock.onResumed();
      expect(rig.state.locked, isFalse);

      rig.lock.onPaused();
      rig.now = rig.now.add(const Duration(seconds: 60));
      rig.lock.onResumed();
      expect(rig.state.locked, isTrue);
    });

    test('a zero delay locks on every return; no lock means never', () async {
      final rig = _Rig();
      await rig.loaded();
      rig.lock
        ..onPaused()
        ..onResumed();
      expect(rig.state.locked, isFalse);

      await rig.lock.enable('4821');
      rig.lock
        ..onPaused()
        ..onResumed();
      expect(rig.state.locked, isTrue);
    });

    test('resuming without a pause does nothing', () async {
      final rig = _Rig();
      await rig.loaded();
      await rig.lock.enable('4821');

      rig.lock.onResumed();

      expect(rig.state.locked, isFalse);
    });

    test('biometrics unlock only when chosen, enrolled and approved', () async {
      final rig = _Rig();
      await rig.loaded();
      await rig.lock.enable('4821');
      rig.lock.lockNow();

      expect(await rig.lock.unlockWithBiometrics(), isFalse); // not chosen
      await rig.lock.setBiometric(on: true);
      rig.auth.available = false;
      expect(await rig.lock.unlockWithBiometrics(), isFalse); // none enrolled
      rig.auth.available = true;
      rig.auth.approves = false;
      expect(await rig.lock.unlockWithBiometrics(), isFalse); // cancelled
      expect(rig.state.locked, isTrue);
      rig.auth.approves = true;
      expect(await rig.lock.unlockWithBiometrics(), isTrue);
      expect(rig.state.locked, isFalse);
    });

    test('the delay and biometric choices are saved', () async {
      final store = MemorySecretStore();
      final first = _Rig(store: store);
      await first.loaded();
      await first.lock.enable('4821');
      await first.lock.setBiometric(on: true);
      await first.lock.setDelay(300);

      final second = _Rig(store: store);
      await second.loaded();

      expect((second.state.biometric, second.state.delaySeconds), (true, 300));
    });
  });
}
