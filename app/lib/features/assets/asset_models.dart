/// A listed symbol and its last known price (toman per unit).
class RateRow {
  const RateRow({
    required this.symbol,
    required this.name,
    required this.unit,
    required this.price,
    required this.known,
    required this.source,
    required this.stale,
  });

  final String symbol;
  final String name;
  final String unit;

  /// Toman per one unit, as text so no precision is lost; empty if unknown.
  final String price;
  final bool known;
  final String source;
  final bool stale;
}

class Asset {
  const Asset({
    required this.id,
    required this.symbol,
    required this.name,
    required this.unit,
    required this.quantity,
    required this.costMinor,
    required this.valueMinor,
    required this.profitMinor,
    required this.realizedMinor,
    required this.priceKnown,
    required this.stale,
  });

  final String id;

  /// Empty for a custom asset.
  final String symbol;
  final String name;
  final String unit;

  /// Decimal text (up to 8 decimals); never a float.
  final String quantity;
  final int costMinor;
  final int valueMinor;
  final int profitMinor;
  final int realizedMinor;
  final bool priceKnown;
  final bool stale;
}

class AssetList {
  const AssetList({
    required this.assets,
    required this.valueMinor,
    required this.costMinor,
    required this.profitMinor,
    required this.realizedMinor,
  });

  static const empty = AssetList(
    assets: [],
    valueMinor: 0,
    costMinor: 0,
    profitMinor: 0,
    realizedMinor: 0,
  );

  final List<Asset> assets;
  final int valueMinor;
  final int costMinor;
  final int profitMinor;
  final int realizedMinor;
}
