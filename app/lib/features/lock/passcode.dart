import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

const passcodeMinLength = 4;
const passcodeMaxLength = 8;

bool isValidPasscode(String code) =>
    RegExp('^[0-9]{$passcodeMinLength,$passcodeMaxLength}\$').hasMatch(code);

/// PBKDF2-HMAC-SHA256. Slow on purpose: a stolen hash of a 4-8 digit code
/// still has to be ground through [iterations] rounds per guess.
class PasscodeHasher {
  const PasscodeHasher({this.iterations = 20000});

  final int iterations;

  static Uint8List newSalt([Random? random]) {
    final r = random ?? Random.secure();
    return Uint8List.fromList(List.generate(16, (_) => r.nextInt(256)));
  }

  Uint8List hash(String passcode, List<int> salt) {
    final hmac = Hmac(sha256, utf8.encode(passcode));
    // One 32-byte block is the whole key (block index 1).
    var u = hmac.convert([...salt, 0, 0, 0, 1]).bytes;
    final result = Uint8List.fromList(u);
    for (var i = 1; i < iterations; i++) {
      u = hmac.convert(u).bytes;
      for (var j = 0; j < result.length; j++) {
        result[j] ^= u[j];
      }
    }
    return result;
  }

  /// Compares in constant time so timing leaks nothing about the code.
  bool verify(String passcode, List<int> salt, List<int> expected) {
    final actual = hash(passcode, salt);
    if (actual.length != expected.length) return false;
    var diff = 0;
    for (var i = 0; i < actual.length; i++) {
      diff |= actual[i] ^ expected[i];
    }
    return diff == 0;
  }
}
