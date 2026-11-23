import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';

import '../../gen/infrastructure/common/grpc/common.pbgrpc.dart';
import '../config.dart';

/// The channel to the backend. Closed with the provider scope.
final grpcChannelProvider = Provider<ClientChannel>((ref) {
  final channel = ClientChannel(
    AppConfig.grpcHost,
    port: AppConfig.grpcPort,
    options: ChannelOptions(
      credentials: AppConfig.useTls
          ? const ChannelCredentials.secure()
          : const ChannelCredentials.insecure(),
    ),
  );
  ref.onDispose(channel.shutdown);
  return channel;
});

final healthClientProvider = Provider<HealthControllerClient>(
  (ref) => HealthControllerClient(ref.watch(grpcChannelProvider)),
);
