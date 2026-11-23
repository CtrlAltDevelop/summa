import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/grpc/grpc_providers.dart';
import '../auth/auth_controller.dart';
import 'privacy_api.dart';

/// Chat retention choices, in days; 0 is "forever".
const retentionChoices = [0, 7, 30, 90, 365];

final privacyApiProvider = Provider<PrivacyApi>(
  (ref) => GrpcPrivacyApi(ref.watch(grpcChannelProvider)),
);

final chatRetentionProvider = FutureProvider.autoDispose<int>(
  (ref) => ref
      .read(authControllerProvider.notifier)
      .withAccess((a) => ref.read(privacyApiProvider).chatRetentionDays(a)),
  retry: (_, _) => null,
);

Future<void> setChatRetention(WidgetRef ref, int days) async {
  await ref
      .read(authControllerProvider.notifier)
      .withAccess(
        (a) => ref.read(privacyApiProvider).setChatRetention(a, days),
      );
  ref.invalidate(chatRetentionProvider);
}

/// Deletes the account on the server, then ends the session here (which also
/// wipes everything kept on the device).
Future<void> deleteAccount(WidgetRef ref, String confirmation) async {
  final auth = ref.read(authControllerProvider.notifier);
  await auth.withAccess(
    (a) => ref.read(privacyApiProvider).deleteAccount(a, confirmation),
  );
  await auth.signOut();
}
