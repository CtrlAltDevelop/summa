import 'package:grpc/grpc.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import '../../gen/infrastructure/accounts/grpc/accounts.pbgrpc.dart'
    as accounts;
import '../../gen/infrastructure/auth/sms_code/grpc/auth_sms_code.pbgrpc.dart'
    as sms;
import '../../gen/infrastructure/oauth/rotation/grpc/oauth_rotation.pbgrpc.dart'
    as rotation;
import 'auth_models.dart';

/// Everything the app asks the server about who is signed in.
abstract interface class AuthApi {
  Future<CodeChallenge> startLogin(String phone);
  Future<Tokens> verifyCode({required String ticket, required String code});
  Future<Tokens> refresh(String refreshToken);
  Future<Profile> me(String accessToken);
  Future<Profile> updateName(String accessToken, String name);
  Future<void> logout(String accessToken);
}

/// [AuthApi] over gRPC. Every server refusal becomes an [AuthException].
class GrpcAuthApi implements AuthApi {
  GrpcAuthApi(ClientChannel channel)
    : _sms = sms.SmsCodeControllerClient(channel),
      _accounts = accounts.AccountControllerClient(channel),
      _rotation = rotation.RotationTokenRpcControllerClient(channel);

  final sms.SmsCodeControllerClient _sms;
  final accounts.AccountControllerClient _accounts;
  final rotation.RotationTokenRpcControllerClient _rotation;

  static CallOptions _bearer(String token) =>
      CallOptions(metadata: {'authorization': 'Bearer $token'});

  @override
  Future<CodeChallenge> startLogin(String phone) => _guard(() async {
    final r = await _sms.loginStart(sms.LoginStartRequest(phone: phone));
    return CodeChallenge(ticket: r.ticket, destination: r.destination);
  }, badInput: AuthFailure.invalidPhone);

  @override
  Future<Tokens> verifyCode({required String ticket, required String code}) =>
      _guard(() async {
        final r = await _sms.loginVerify(
          sms.LoginVerifyRequest(ticket: ticket, code: code),
        );
        final c = r.credentials;
        return Tokens(access: c.accessToken, refresh: c.refreshToken);
      }, badInput: AuthFailure.wrongCode);

  @override
  Future<Tokens> refresh(String refreshToken) => _guard(() async {
    final c = await _rotation.refresh(
      rotation.RefreshRequest(refreshToken: refreshToken),
    );
    return Tokens(access: c.accessToken, refresh: c.refreshToken);
  }, badInput: AuthFailure.unauthorized);

  @override
  Future<Profile> me(String accessToken) => _guard(() async {
    final a = await _accounts.me(Empty(), options: _bearer(accessToken));
    return Profile(displayName: a.profile.displayName);
  }, badInput: AuthFailure.unauthorized);

  @override
  Future<Profile> updateName(String accessToken, String name) =>
      _guard(() async {
        final a = await _accounts.updateProfile(
          accounts.ProfileUpdate(displayName: name),
          options: _bearer(accessToken),
        );
        return Profile(displayName: a.profile.displayName);
      }, badInput: AuthFailure.unknown);

  @override
  Future<void> logout(String accessToken) => _guard(() async {
    await _sms.logout(
      sms.LogoutRequest(token: accessToken),
      options: _bearer(accessToken),
    );
  }, badInput: AuthFailure.unauthorized);

  /// Runs [call], turning gRPC statuses into [AuthException]s. [badInput] is
  /// what a refused request means for this particular call.
  Future<T> _guard<T>(
    Future<T> Function() call, {
    required AuthFailure badInput,
  }) async {
    try {
      return await call();
    } on GrpcError catch (e) {
      throw AuthException(_failureOf(e.code, badInput));
    }
  }

  static AuthFailure _failureOf(int code, AuthFailure badInput) {
    return switch (code) {
      StatusCode.resourceExhausted => AuthFailure.tooMany,
      StatusCode.unavailable ||
      StatusCode.deadlineExceeded => AuthFailure.offline,
      StatusCode.unauthenticated => AuthFailure.unauthorized,
      StatusCode.invalidArgument ||
      StatusCode.notFound ||
      StatusCode.permissionDenied ||
      StatusCode.failedPrecondition => badInput,
      _ => AuthFailure.unknown,
    };
  }
}
