import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'authenticator.dart';
import 'passcode.dart';
import 'secret_store.dart';

const lockStorageKey = 'applock';

/// How many wrong codes in a row before the waiting starts.
const freeAttempts = 5;
const firstWait = Duration(seconds: 30);
const longestWait = Duration(minutes: 15);

/// Lock after this long in the background (0 = every time).
const lockDelays = [0, 30, 60, 300];

final clockProvider = Provider<DateTime Function()>((ref) => DateTime.now);

final passcodeHasherProvider = Provider<PasscodeHasher>(
  (ref) => const PasscodeHasher(),
);

enum UnlockResult { ok, wrong, lockedOut }

class LockState {
  const LockState({
    this.loaded = false,
    this.enabled = false,
    this.locked = true,
    this.biometric = false,
    this.delaySeconds = 0,
    this.failedAttempts = 0,
    this.lockedOutUntil,
  });

  final bool loaded;
  final bool enabled;

  /// True while the lock screen should cover the app.
  final bool locked;

  /// Whether the person wants biometrics to unlock (when the device has them).
  final bool biometric;
  final int delaySeconds;
  final int failedAttempts;
  final DateTime? lockedOutUntil;

  LockState copyWith({
    bool? loaded,
    bool? enabled,
    bool? locked,
    bool? biometric,
    int? delaySeconds,
    int? failedAttempts,
    DateTime? lockedOutUntil,
    bool clearLockout = false,
  }) => LockState(
    loaded: loaded ?? this.loaded,
    enabled: enabled ?? this.enabled,
    locked: locked ?? this.locked,
    biometric: biometric ?? this.biometric,
    delaySeconds: delaySeconds ?? this.delaySeconds,
    failedAttempts: failedAttempts ?? this.failedAttempts,
    lockedOutUntil: clearLockout ? null : lockedOutUntil ?? this.lockedOutUntil,
  );
}

final lockProvider = NotifierProvider<LockController, LockState>(
  LockController.new,
);

/// The app lock: a passcode (hashed, salted, in secure storage), optional
/// biometrics, locking after time in the background, and waiting after wrong
/// codes. The passcode never leaves the device.
class LockController extends Notifier<LockState> {
  SecretStore get _store => ref.read(secretStoreProvider);
  PasscodeHasher get _hasher => ref.read(passcodeHasherProvider);
  DateTime _now() => ref.read(clockProvider)();

  List<int> _salt = const [];
  List<int> _hash = const [];
  DateTime? _pausedAt;

  @override
  LockState build() {
    _load();
    return const LockState();
  }

  Future<void> _load() async {
    final raw = await _store.read(lockStorageKey);
    if (raw == null) {
      state = state.copyWith(loaded: true, locked: false);
      return;
    }
    final j = jsonDecode(raw) as Map<String, Object?>;
    _salt = base64Decode(j['salt']! as String);
    _hash = base64Decode(j['hash']! as String);
    final until = j['until'] as int?;
    state = LockState(
      loaded: true,
      enabled: true,
      locked: true, // a restart always asks again
      biometric: j['biometric']! as bool,
      delaySeconds: j['delay']! as int,
      failedAttempts: j['failed']! as int,
      lockedOutUntil: until == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(until),
    );
  }

  Future<void> _save() async {
    if (!state.enabled) {
      await _store.delete(lockStorageKey);
      return;
    }
    await _store.write(
      lockStorageKey,
      jsonEncode({
        'salt': base64Encode(_salt),
        'hash': base64Encode(_hash),
        'biometric': state.biometric,
        'delay': state.delaySeconds,
        'failed': state.failedAttempts,
        'until': state.lockedOutUntil?.millisecondsSinceEpoch,
      }),
    );
  }

  /// Turns the lock on with a new passcode. The session stays unlocked.
  Future<void> enable(String passcode) async {
    if (!isValidPasscode(passcode)) {
      throw ArgumentError(
        'A passcode is $passcodeMinLength-$passcodeMaxLength digits.',
      );
    }
    _salt = PasscodeHasher.newSalt();
    _hash = _hasher.hash(passcode, _salt);
    state = state.copyWith(
      enabled: true,
      locked: false,
      failedAttempts: 0,
      clearLockout: true,
    );
    await _save();
  }

  /// Turns the lock off, if [passcode] is right.
  Future<UnlockResult> disable(String passcode) async {
    final result = _check(passcode);
    if (result != UnlockResult.ok) return result;
    _salt = const [];
    _hash = const [];
    state = const LockState(loaded: true, locked: false);
    await _save();
    return UnlockResult.ok;
  }

  /// Turns the lock off once the passcode has just been proven in this
  /// session (the prompt that proves it counted any wrong guesses already).
  Future<void> disableAfterProof() async {
    _salt = const [];
    _hash = const [];
    state = const LockState(loaded: true, locked: false);
    await _save();
  }

  Future<UnlockResult> changePasscode(String old, String next) async {
    if (!isValidPasscode(next)) throw ArgumentError('Invalid new passcode.');
    final result = _check(old);
    if (result != UnlockResult.ok) {
      await _save();
      return result;
    }
    _salt = PasscodeHasher.newSalt();
    _hash = _hasher.hash(next, _salt);
    await _save();
    return UnlockResult.ok;
  }

  /// Checks [passcode] against the stored hash, counting wrong guesses and
  /// refusing while waiting. Does not change `locked`.
  UnlockResult _check(String passcode) {
    final until = state.lockedOutUntil;
    if (until != null && _now().isBefore(until)) return UnlockResult.lockedOut;
    if (_hasher.verify(passcode, _salt, _hash)) {
      state = state.copyWith(failedAttempts: 0, clearLockout: true);
      return UnlockResult.ok;
    }
    final failed = state.failedAttempts + 1;
    state = state.copyWith(
      failedAttempts: failed,
      lockedOutUntil: failed >= freeAttempts
          ? _now().add(waitFor(failed))
          : null,
    );
    return UnlockResult.wrong;
  }

  /// 30 s after the fifth wrong code, doubling each time, at most 15 min.
  static Duration waitFor(int failedAttempts) {
    final steps = failedAttempts - freeAttempts;
    if (steps < 0) return Duration.zero;
    final seconds = firstWait.inSeconds * (1 << steps.clamp(0, 10));
    return Duration(seconds: seconds.clamp(0, longestWait.inSeconds));
  }

  Future<UnlockResult> unlockWithPasscode(String passcode) async {
    final result = _check(passcode);
    if (result == UnlockResult.ok) state = state.copyWith(locked: false);
    await _save();
    return result;
  }

  Future<bool> unlockWithBiometrics() async {
    final auth = ref.read(authenticatorProvider);
    if (!state.enabled || !state.biometric || !await auth.canUseBiometrics()) {
      return false;
    }
    final ok = await auth.authenticate('باز کردن Summa');
    if (ok) state = state.copyWith(locked: false);
    return ok;
  }

  Future<void> setBiometric({required bool on}) async {
    state = state.copyWith(biometric: on);
    await _save();
  }

  Future<void> setDelay(int seconds) async {
    state = state.copyWith(delaySeconds: seconds);
    await _save();
  }

  void lockNow() {
    if (state.enabled) state = state.copyWith(locked: true);
  }

  /// The app went to the background.
  void onPaused() => _pausedAt = _now();

  /// The app came back: lock if it was away at least the chosen delay.
  void onResumed() {
    final paused = _pausedAt;
    _pausedAt = null;
    if (!state.enabled || paused == null) return;
    if (_now().difference(paused).inSeconds >= state.delaySeconds) {
      state = state.copyWith(locked: true);
    }
  }
}
