import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/grpc/grpc_providers.dart';
import '../assets/asset_controller.dart';
import '../auth/auth_controller.dart';
import '../debts/debt_controller.dart';
import '../wallets/wallets_controller.dart';
import 'networth_api.dart';
import 'networth_models.dart';

final networthApiProvider = Provider<NetWorthApi>(
  (ref) => GrpcNetWorthApi(ref.watch(grpcChannelProvider)),
);

/// Anything that moves money or value reloads these, so they watch the sources.
void _watchSources(Ref ref) {
  ref
    ..watch(walletsControllerProvider)
    ..watch(assetsControllerProvider)
    ..watch(debtsControllerProvider);
}

final netWorthProvider = FutureProvider<NetWorth>((ref) {
  _watchSources(ref);
  return ref
      .read(authControllerProvider.notifier)
      .withAccess((a) => ref.read(networthApiProvider).get(a));
});

final basketsProvider = FutureProvider<List<Basket>>((ref) {
  _watchSources(ref);
  return ref
      .read(authControllerProvider.notifier)
      .withAccess((a) => ref.read(networthApiProvider).baskets(a));
});

Future<void> createBasket(
  WidgetRef ref, {
  required String name,
  required int targetMinor,
  required List<BasketItemRef> items,
  required String clientMutationId,
}) async {
  await ref
      .read(authControllerProvider.notifier)
      .withAccess(
        (a) => ref
            .read(networthApiProvider)
            .createBasket(
              a,
              name: name,
              targetMinor: targetMinor,
              items: items,
              clientMutationId: clientMutationId,
            ),
      );
  ref.invalidate(basketsProvider);
}

Future<void> deleteBasket(WidgetRef ref, String id) async {
  await ref
      .read(authControllerProvider.notifier)
      .withAccess((a) => ref.read(networthApiProvider).deleteBasket(a, id));
  ref.invalidate(basketsProvider);
}
