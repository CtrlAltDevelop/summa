import 'dart:io' show Platform;

/// Where the backend lives. Override with `--dart-define=GRPC_HOST=...`.
abstract final class AppConfig {
  static const int grpcPort = int.fromEnvironment(
    'GRPC_PORT',
    defaultValue: 50051,
  );
  static const String _hostOverride = String.fromEnvironment('GRPC_HOST');
  static const String _androidEmulatorHost = '10.0.2.2';
  static const String _localHost = 'localhost';

  static String get grpcHost {
    if (_hostOverride.isNotEmpty) return _hostOverride;
    return Platform.isAndroid ? _androidEmulatorHost : _localHost;
  }
}
