import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import '../../gen/apps/networth/grpc/networth.pbgrpc.dart' as pb;
import '../wallets/grpc_guard.dart';
import 'networth_models.dart';

abstract interface class NetWorthApi {
  Future<NetWorth> get(String access);
  Future<List<Basket>> baskets(String access);
  Future<List<NetWorthPoint>> history(String access, int days);
  Future<void> createBasket(
    String access, {
    required String name,
    required int targetMinor,
    required List<BasketItemRef> items,
    required String clientMutationId,
  });
  Future<void> deleteBasket(String access, String basketId);
}

class GrpcNetWorthApi implements NetWorthApi {
  GrpcNetWorthApi(ClientChannel channel)
    : _client = pb.NetWorthControllerClient(channel);

  final pb.NetWorthControllerClient _client;

  static CallOptions _bearer(String token) =>
      CallOptions(metadata: {'authorization': 'Bearer $token'});

  @override
  Future<NetWorth> get(String access) => guardGrpc(() async {
    final r = await _client.get(Empty(), options: _bearer(access));
    return NetWorth(
      totalMinor: r.totalMinor.toInt(),
      walletsMinor: r.walletsMinor.toInt(),
      assetsMinor: r.assetsMinor.toInt(),
      debtsMinor: r.debtsMinor.toInt(),
      usdMinor: r.usdPresent ? r.usdMinor.toInt() : null,
      goldGrams: r.goldGrams,
      stale: r.stale,
      unconverted: r.unconverted.toList(),
      unpricedAssets: r.unpricedAssets,
    );
  });

  @override
  Future<List<NetWorthPoint>> history(String access, int days) =>
      guardGrpc(() async {
        final r = await _client.history(
          pb.HistoryRequest(days: days),
          options: _bearer(access),
        );
        return [
          for (final p in r.points)
            NetWorthPoint(DateTime.parse(p.date), p.totalMinor.toInt()),
        ];
      });

  @override
  Future<List<Basket>> baskets(String access) => guardGrpc(() async {
    final r = await _client.listBaskets(Empty(), options: _bearer(access));
    return r.baskets
        .map(
          (b) => Basket(
            id: b.id,
            name: b.name,
            targetMinor: b.targetMinor.toInt(),
            valueMinor: b.valueMinor.toInt(),
            percent: b.percent.toInt(),
            items: b.items
                .map(
                  (i) => BasketItem(
                    kind: i.kind,
                    refId: i.refId,
                    name: i.name,
                    valueMinor: i.valueMinor.toInt(),
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  });

  @override
  Future<void> createBasket(
    String access, {
    required String name,
    required int targetMinor,
    required List<BasketItemRef> items,
    required String clientMutationId,
  }) => guardGrpc(() async {
    await _client.createBasket(
      pb.BasketCreate(
        name: name,
        targetMinor: Int64(targetMinor),
        items: [
          for (final i in items)
            pb.BasketItemRefMsg(kind: i.kind, refId: i.refId),
        ],
        clientMutationId: clientMutationId,
      ),
      options: _bearer(access),
    );
  });

  @override
  Future<void> deleteBasket(String access, String basketId) =>
      guardGrpc(() async {
        await _client.deleteBasket(
          pb.BasketRef(basketId: basketId),
          options: _bearer(access),
        );
      });
}
