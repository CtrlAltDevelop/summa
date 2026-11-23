import 'package:summa/features/assets/asset_api.dart';
import 'package:summa/features/assets/asset_models.dart';

/// In-memory [AssetApi]. Prices are set on [rateTable]; values derive from them.
class FakeAssetApi implements AssetApi {
  final Map<String, int> rateTable = {};
  final List<Asset> assets = [];
  final List<Map<String, Object?>> created = [];
  final List<Map<String, Object?>> lots = [];
  final List<Map<String, Object?>> sales = [];
  bool failNext = false;

  static const symbols = {
    'GOLD18': ('طلای ۱۸ عیار', 'گرم'),
    'USD': ('دلار', 'دلار'),
    'BTC': ('بیت‌کوین', 'بیت‌کوین'),
  };

  @override
  Future<List<RateRow>> rates(String access) async => [
    for (final e in symbols.entries)
      RateRow(
        symbol: e.key,
        name: e.value.$1,
        unit: e.value.$2,
        price: rateTable[e.key]?.toString() ?? '',
        known: rateTable.containsKey(e.key),
        source: rateTable.containsKey(e.key) ? 'manual' : '',
        stale: !rateTable.containsKey(e.key),
      ),
  ];

  @override
  Future<AssetList> list(String access) async => AssetList(
    assets: List.of(assets),
    valueMinor: assets.fold(0, (s, a) => s + (a.priceKnown ? a.valueMinor : 0)),
    costMinor: assets.fold(0, (s, a) => s + (a.priceKnown ? a.costMinor : 0)),
    profitMinor: assets.fold(
      0,
      (s, a) => s + (a.priceKnown ? a.profitMinor : 0),
    ),
    realizedMinor: assets.fold(0, (s, a) => s + a.realizedMinor),
  );

  void _check() {
    if (failNext) {
      failNext = false;
      throw Exception('refused');
    }
  }

  Asset _make(
    String id,
    String symbol,
    String name,
    String unit,
    String quantity,
    int costMinor,
  ) {
    final price = rateTable[symbol];
    final value = price == null ? 0 : (double.parse(quantity) * price).round();
    return Asset(
      id: id,
      symbol: symbol,
      name: name,
      unit: unit,
      quantity: quantity,
      costMinor: costMinor,
      valueMinor: value,
      profitMinor: price == null ? 0 : value - costMinor,
      realizedMinor: 0,
      priceKnown: price != null,
      stale: false,
    );
  }

  @override
  Future<void> create(
    String access, {
    required String symbol,
    required String name,
    required String quantity,
    required int unitPriceMinor,
    required int manualPriceMinor,
    required String clientMutationId,
  }) async {
    _check();
    created.add({
      'symbol': symbol,
      'name': name,
      'quantity': quantity,
      'unit': unitPriceMinor,
      'manual': manualPriceMinor,
    });
    final listed = symbols[symbol];
    final cost = (double.parse(quantity) * unitPriceMinor).round();
    final asset = _make(
      'a${assets.length + 1}',
      symbol,
      listed?.$1 ?? name,
      listed?.$2 ?? '',
      quantity,
      cost,
    );
    assets.add(
      symbol.isEmpty
          ? Asset(
              id: asset.id,
              symbol: '',
              name: name,
              unit: '',
              quantity: quantity,
              costMinor: cost,
              valueMinor: (double.parse(quantity) * manualPriceMinor).round(),
              profitMinor:
                  (double.parse(quantity) * manualPriceMinor).round() - cost,
              realizedMinor: 0,
              priceKnown: true,
              stale: false,
            )
          : asset,
    );
  }

  @override
  Future<void> addLot(
    String access,
    String assetId, {
    required String quantity,
    required int unitPriceMinor,
  }) async {
    _check();
    lots.add({'id': assetId, 'quantity': quantity, 'price': unitPriceMinor});
  }

  @override
  Future<void> sell(
    String access,
    String assetId, {
    required String quantity,
    required int unitPriceMinor,
  }) async {
    _check();
    sales.add({'id': assetId, 'quantity': quantity, 'price': unitPriceMinor});
  }

  @override
  Future<void> delete(String access, String assetId) async =>
      assets.removeWhere((a) => a.id == assetId);
}
