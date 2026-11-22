import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';

import '../../core/grpc/grpc_providers.dart';

import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

/// Outcome of one liveness probe.
class HealthResult {
  const HealthResult({required this.ok, required this.latency});

  final bool ok;
  final Duration latency;
}

/// Asks the backend whether it is alive. Never throws: a failed call is a
/// result with `ok == false`, so the screen shows a state instead of crashing.
class HealthService {
  const HealthService(this._read);

  final Future<String> Function() _read;

  Future<HealthResult> check() async {
    final stopwatch = Stopwatch()..start();
    try {
      final status = await _read();
      return HealthResult(ok: status == 'ok', latency: stopwatch.elapsed);
    } on GrpcError {
      return HealthResult(ok: false, latency: stopwatch.elapsed);
    }
  }
}

final healthServiceProvider = Provider<HealthService>((ref) {
  final client = ref.watch(healthClientProvider);
  return HealthService(() async => (await client.liveness(Empty())).status);
});

final healthCheckProvider = FutureProvider.autoDispose<HealthResult>(
  (ref) => ref.watch(healthServiceProvider).check(),
);
