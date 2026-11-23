import 'package:summa/features/networth/networth_api.dart';
import 'package:summa/features/networth/networth_models.dart';

/// Scriptable [NetWorthApi]: returns [worth] and keeps created baskets.
class FakeNetWorthApi implements NetWorthApi {
  NetWorth worth = const NetWorth(
    totalMinor: 0,
    walletsMinor: 0,
    assetsMinor: 0,
    debtsMinor: 0,
    usdMinor: null,
    goldGrams: '',
    stale: false,
    unconverted: [],
    unpricedAssets: 0,
  );
  final List<Basket> baskets_ = [];
  final List<Map<String, Object?>> created = [];

  @override
  Future<NetWorth> get(String access) async => worth;

  @override
  Future<List<Basket>> baskets(String access) async => List.of(baskets_);

  @override
  Future<void> createBasket(
    String access, {
    required String name,
    required int targetMinor,
    required List<BasketItemRef> items,
    required String clientMutationId,
  }) async {
    created.add({'name': name, 'target': targetMinor, 'items': items});
    baskets_.add(
      Basket(
        id: 'b${baskets_.length + 1}',
        name: name,
        targetMinor: targetMinor,
        valueMinor: 0,
        percent: 0,
        items: const [],
      ),
    );
  }

  @override
  Future<void> deleteBasket(String access, String basketId) async =>
      baskets_.removeWhere((b) => b.id == basketId);
}
