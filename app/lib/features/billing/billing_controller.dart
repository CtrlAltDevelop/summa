import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/grpc/grpc_providers.dart';
import '../auth/auth_controller.dart';
import 'billing_api.dart';
import 'billing_models.dart';

final billingApiProvider = Provider<BillingApi>(
  (ref) => GrpcBillingApi(ref.watch(grpcChannelProvider)),
);

final subscriptionStatusProvider = FutureProvider<SubscriptionStatus>(
  (ref) => ref
      .read(authControllerProvider.notifier)
      .withAccess((a) => ref.read(billingApiProvider).status(a)),
  retry: (_, _) => null,
);

final plansProvider = FutureProvider<List<PlanInfo>>(
  (ref) => ref
      .read(authControllerProvider.notifier)
      .withAccess((a) => ref.read(billingApiProvider).plans(a)),
  retry: (_, _) => null,
);

Future<void> startTrial(WidgetRef ref) async {
  await ref
      .read(authControllerProvider.notifier)
      .withAccess((a) => ref.read(billingApiProvider).startTrial(a));
  ref.invalidate(subscriptionStatusProvider);
}

Future<Checkout> checkout(WidgetRef ref, String planCode) => ref
    .read(authControllerProvider.notifier)
    .withAccess((a) => ref.read(billingApiProvider).checkout(a, planCode));

/// Returns the status after the server checked the payment with the gateway.
Future<SubscriptionStatus> verify(WidgetRef ref, String reference) async {
  final status = await ref
      .read(authControllerProvider.notifier)
      .withAccess((a) => ref.read(billingApiProvider).verify(a, reference));
  ref.invalidate(subscriptionStatusProvider);
  return status;
}
