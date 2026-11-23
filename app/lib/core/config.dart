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

  static const String _tlsOverride = String.fromEnvironment('GRPC_TLS');
  static const _localHosts = {'localhost', '127.0.0.1', '10.0.2.2'};

  /// Plain text only for a backend on this machine; anything else is TLS.
  /// `--dart-define=GRPC_TLS=true|false` overrides the guess.
  static bool useTlsFor(String host) {
    if (_tlsOverride.isNotEmpty) return _tlsOverride == 'true';
    return !_localHosts.contains(host);
  }

  static bool get useTls => useTlsFor(grpcHost);

  static String get grpcHost {
    if (_hostOverride.isNotEmpty) return _hostOverride;
    return Platform.isAndroid ? _androidEmulatorHost : _localHost;
  }
}
