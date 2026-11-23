import 'package:grpc/grpc.dart';

import '../auth/auth_models.dart';
import 'wallet_models.dart';

/// Runs [call], turning gRPC statuses into exceptions: a refused token becomes
/// [AuthException] (so the auth controller can refresh and retry), anything
/// else a [WalletException].
Future<T> guardGrpc<T>(Future<T> Function() call) async {
  try {
    return await call();
  } on GrpcError catch (e) {
    throw switch (e.code) {
      StatusCode.unauthenticated => const AuthException(
        AuthFailure.unauthorized,
      ),
      StatusCode.unavailable || StatusCode.deadlineExceeded =>
        const WalletException(WalletFailure.offline),
      StatusCode.invalidArgument => const WalletException(
        WalletFailure.invalid,
      ),
      StatusCode.notFound => const WalletException(WalletFailure.notFound),
      _ => const WalletException(WalletFailure.unknown),
    };
  }
}
