import 'package:summa/features/lock/authenticator.dart';

class FakeAuthenticator implements Authenticator {
  bool available = true;
  bool approves = true;
  final List<String> reasons = [];

  @override
  Future<bool> canUseBiometrics() async => available;

  @override
  Future<bool> authenticate(String reason) async {
    reasons.add(reason);
    return approves;
  }
}
