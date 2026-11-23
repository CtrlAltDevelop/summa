import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

/// Biometric (or device) authentication, behind an interface so the rest of
/// the app and its tests never depend on a plugin.
abstract interface class Authenticator {
  /// Whether this device has biometrics enrolled and usable.
  Future<bool> canUseBiometrics();

  /// Asks the person to prove who they are. `false` on cancel or failure.
  Future<bool> authenticate(String reason);
}

/// The default: no biometrics. `main` swaps in [LocalAuthAuthenticator].
class NoBiometrics implements Authenticator {
  const NoBiometrics();

  @override
  Future<bool> canUseBiometrics() async => false;

  @override
  Future<bool> authenticate(String reason) async => false;
}

class LocalAuthAuthenticator implements Authenticator {
  LocalAuthAuthenticator([LocalAuthentication? auth])
    : _auth = auth ?? LocalAuthentication();

  final LocalAuthentication _auth;

  @override
  Future<bool> canUseBiometrics() async {
    try {
      if (!await _auth.canCheckBiometrics) return false;
      return (await _auth.getAvailableBiometrics()).isNotEmpty;
    } on Exception {
      return false;
    }
  }

  @override
  Future<bool> authenticate(String reason) async {
    try {
      return await _auth.authenticate(
        localizedReason: reason,
        biometricOnly: true,
      );
    } on Exception {
      return false;
    }
  }
}

final authenticatorProvider = Provider<Authenticator>(
  (ref) => const NoBiometrics(),
);
