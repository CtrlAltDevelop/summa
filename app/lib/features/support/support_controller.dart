import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/grpc/grpc_providers.dart';
import '../auth/auth_controller.dart';
import 'support_api.dart';
import 'support_models.dart';

final supportApiProvider = Provider<SupportApi>(
  (ref) => GrpcSupportApi(ref.watch(grpcChannelProvider)),
);

final ticketsProvider = FutureProvider.autoDispose<List<SupportTicket>>(
  (ref) => ref
      .read(authControllerProvider.notifier)
      .withAccess((a) => ref.read(supportApiProvider).tickets(a)),
  retry: (_, _) => null,
);

final threadProvider = FutureProvider.autoDispose
    .family<List<SupportMessage>, String>(
      (ref, ticketId) => ref
          .read(authControllerProvider.notifier)
          .withAccess(
            (a) => ref.read(supportApiProvider).messages(a, ticketId),
          ),
      retry: (_, _) => null,
    );

Future<SupportTicket> openTicket(
  WidgetRef ref, {
  required String subject,
  required String body,
}) async {
  final ticket = await ref
      .read(authControllerProvider.notifier)
      .withAccess(
        (a) =>
            ref.read(supportApiProvider).open(a, subject: subject, body: body),
      );
  ref.invalidate(ticketsProvider);
  return ticket;
}

Future<void> sendMessage(WidgetRef ref, String ticketId, String body) async {
  await ref
      .read(authControllerProvider.notifier)
      .withAccess((a) => ref.read(supportApiProvider).send(a, ticketId, body));
  ref
    ..invalidate(threadProvider(ticketId))
    ..invalidate(ticketsProvider);
}
