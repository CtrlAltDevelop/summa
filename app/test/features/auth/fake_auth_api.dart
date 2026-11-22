import 'package:summa/features/auth/auth_api.dart';
import 'package:summa/features/auth/auth_models.dart';

/// Scriptable [AuthApi] for tests: knows one valid code and one valid session.
class FakeAuthApi implements AuthApi {
  FakeAuthApi({this.profileName = ''});

  static const validCode = '123456';
  static const ticket = 'ticket-1';

  String profileName;
  String validAccess = 'access-1';
  String validRefresh = 'refresh-1';
  bool refreshRefused = false;
  AuthFailure? startFailure;
  AuthFailure? meFailure;

  final List<String> calls = [];
  int _generation = 1;

  Tokens get currentTokens =>
      Tokens(access: validAccess, refresh: validRefresh);

  @override
  Future<CodeChallenge> startLogin(String phone) async {
    calls.add('start:$phone');
    if (startFailure != null) throw AuthException(startFailure!);
    return const CodeChallenge(ticket: ticket, destination: '***6789');
  }

  @override
  Future<Tokens> verifyCode({
    required String ticket,
    required String code,
  }) async {
    calls.add('verify:$code');
    if (code != validCode) throw const AuthException(AuthFailure.wrongCode);
    return currentTokens;
  }

  @override
  Future<Tokens> refresh(String refreshToken) async {
    calls.add('refresh');
    if (refreshRefused || refreshToken != validRefresh) {
      throw const AuthException(AuthFailure.unauthorized);
    }
    _generation++;
    validAccess = 'access-$_generation';
    validRefresh = 'refresh-$_generation';
    return currentTokens;
  }

  @override
  Future<Profile> me(String accessToken) async {
    calls.add('me');
    if (meFailure != null) throw AuthException(meFailure!);
    if (accessToken != validAccess) {
      throw const AuthException(AuthFailure.unauthorized);
    }
    return Profile(displayName: profileName);
  }

  @override
  Future<Profile> updateName(String accessToken, String name) async {
    calls.add('name:$name');
    if (accessToken != validAccess) {
      throw const AuthException(AuthFailure.unauthorized);
    }
    profileName = name;
    return Profile(displayName: name);
  }

  @override
  Future<void> logout(String accessToken) async {
    calls.add('logout');
  }
}
