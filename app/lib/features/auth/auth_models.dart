/// Access and refresh tokens of one signed-in session.
class Tokens {
  const Tokens({required this.access, required this.refresh});

  final String access;
  final String refresh;
}

/// What the server returns after it sent a code.
class CodeChallenge {
  const CodeChallenge({required this.ticket, required this.destination});

  final String ticket;

  /// The masked number the code went to, such as `***6789`.
  final String destination;
}

/// The signed-in person.
class Profile {
  const Profile({required this.displayName});

  final String displayName;

  bool get hasName => displayName.trim().isNotEmpty;
}

/// Why an authentication call failed, in terms the UI can word.
enum AuthFailure {
  invalidPhone,
  wrongCode,
  tooMany,
  unauthorized,
  offline,
  unknown,
}

class AuthException implements Exception {
  const AuthException(this.failure);

  final AuthFailure failure;

  @override
  String toString() => 'AuthException($failure)';
}
