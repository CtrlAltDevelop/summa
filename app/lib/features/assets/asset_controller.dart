import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/grpc/grpc_providers.dart';
import '../auth/auth_controller.dart';
import 'asset_api.dart';
import 'asset_models.dart';

final assetApiProvider = Provider<AssetApi>(
  (ref) => GrpcAssetApi(ref.watch(grpcChannelProvider)),
);

/// Every listed symbol with its last known price.
final ratesProvider = FutureProvider<List<RateRow>>(
  (ref) => ref
      .read(authControllerProvider.notifier)
      .withAccess((a) => ref.read(assetApiProvider).rates(a)),
);

final assetsControllerProvider =
    AsyncNotifierProvider<AssetsController, AssetList>(
      AssetsController.new,
      retry: (_, _) => null,
    );

class AssetsController extends AsyncNotifier<AssetList> {
  AssetApi get _api => ref.read(assetApiProvider);
  AuthController get _auth => ref.read(authControllerProvider.notifier);

  @override
  Future<AssetList> build() => _auth.withAccess(_api.list);

  Future<void> create({
    required String symbol,
    required String name,
    required String quantity,
    required int unitPriceMinor,
    required int manualPriceMinor,
    required String clientMutationId,
  }) async {
    await _auth.withAccess(
      (a) => _api.create(
        a,
        symbol: symbol,
        name: name,
        quantity: quantity,
        unitPriceMinor: unitPriceMinor,
        manualPriceMinor: manualPriceMinor,
        clientMutationId: clientMutationId,
      ),
    );
    await _reload();
  }

  Future<void> addLot(
    String id, {
    required String quantity,
    required int unitPriceMinor,
  }) async {
    await _auth.withAccess(
      (a) => _api.addLot(
        a,
        id,
        quantity: quantity,
        unitPriceMinor: unitPriceMinor,
      ),
    );
    await _reload();
  }

  Future<void> sell(
    String id, {
    required String quantity,
    required int unitPriceMinor,
  }) async {
    await _auth.withAccess(
      (a) =>
          _api.sell(a, id, quantity: quantity, unitPriceMinor: unitPriceMinor),
    );
    await _reload();
  }

  Future<void> delete(String id) async {
    await _auth.withAccess((a) => _api.delete(a, id));
    await _reload();
  }

  Future<void> _reload() async {
    state = AsyncData(await _auth.withAccess(_api.list));
  }
}
