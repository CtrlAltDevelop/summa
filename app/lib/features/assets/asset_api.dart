import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import '../../gen/apps/assets/grpc/assets.pbgrpc.dart' as pb;
import '../wallets/grpc_guard.dart';
import 'asset_models.dart';

abstract interface class AssetApi {
  Future<List<RateRow>> rates(String access);
  Future<AssetList> list(String access);
  Future<void> create(
    String access, {
    required String symbol,
    required String name,
    required String quantity,
    required int unitPriceMinor,
    required int manualPriceMinor,
    required String clientMutationId,
  });
  Future<void> addLot(
    String access,
    String assetId, {
    required String quantity,
    required int unitPriceMinor,
  });
  Future<void> sell(
    String access,
    String assetId, {
    required String quantity,
    required int unitPriceMinor,
  });
  Future<void> delete(String access, String assetId);
}

class GrpcAssetApi implements AssetApi {
  GrpcAssetApi(ClientChannel channel)
    : _rates = pb.RatesControllerClient(channel),
      _assets = pb.AssetsControllerClient(channel);

  final pb.RatesControllerClient _rates;
  final pb.AssetsControllerClient _assets;

  static CallOptions _bearer(String token) =>
      CallOptions(metadata: {'authorization': 'Bearer $token'});

  @override
  Future<List<RateRow>> rates(String access) => guardGrpc(() async {
    final r = await _rates.list(Empty(), options: _bearer(access));
    return r.rates
        .map(
          (m) => RateRow(
            symbol: m.symbol,
            name: m.name,
            unit: m.unit,
            price: m.price,
            known: m.known,
            source: m.source,
            stale: m.stale,
          ),
        )
        .toList();
  });

  @override
  Future<AssetList> list(String access) => guardGrpc(() async {
    final r = await _assets.list(Empty(), options: _bearer(access));
    return AssetList(
      assets: r.assets
          .map(
            (a) => Asset(
              id: a.id,
              symbol: a.symbol,
              name: a.name,
              unit: a.unit,
              quantity: a.quantity,
              costMinor: a.costMinor.toInt(),
              valueMinor: a.valueMinor.toInt(),
              profitMinor: a.profitMinor.toInt(),
              realizedMinor: a.realizedMinor.toInt(),
              priceKnown: a.priceKnown,
              stale: a.stale,
            ),
          )
          .toList(),
      valueMinor: r.valueMinor.toInt(),
      costMinor: r.costMinor.toInt(),
      profitMinor: r.profitMinor.toInt(),
      realizedMinor: r.realizedMinor.toInt(),
    );
  });

  @override
  Future<void> create(
    String access, {
    required String symbol,
    required String name,
    required String quantity,
    required int unitPriceMinor,
    required int manualPriceMinor,
    required String clientMutationId,
  }) => guardGrpc(() async {
    await _assets.create(
      pb.AssetCreate(
        symbol: symbol,
        name: name,
        quantity: quantity,
        unitPriceMinor: Int64(unitPriceMinor),
        manualPriceMinor: Int64(manualPriceMinor),
        clientMutationId: clientMutationId,
      ),
      options: _bearer(access),
    );
  });

  @override
  Future<void> addLot(
    String access,
    String assetId, {
    required String quantity,
    required int unitPriceMinor,
  }) => guardGrpc(() async {
    await _assets.addLot(
      pb.LotAdd(
        assetId: assetId,
        quantity: quantity,
        unitPriceMinor: Int64(unitPriceMinor),
      ),
      options: _bearer(access),
    );
  });

  @override
  Future<void> sell(
    String access,
    String assetId, {
    required String quantity,
    required int unitPriceMinor,
  }) => guardGrpc(() async {
    await _assets.sell(
      pb.AssetSell(
        assetId: assetId,
        quantity: quantity,
        unitPriceMinor: Int64(unitPriceMinor),
      ),
      options: _bearer(access),
    );
  });

  @override
  Future<void> delete(String access, String assetId) => guardGrpc(() async {
    await _assets.delete(
      pb.AssetRef(assetId: assetId),
      options: _bearer(access),
    );
  });
}
