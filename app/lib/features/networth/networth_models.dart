class NetWorth {
  const NetWorth({
    required this.totalMinor,
    required this.walletsMinor,
    required this.assetsMinor,
    required this.debtsMinor,
    required this.usdMinor,
    required this.goldGrams,
    required this.stale,
    required this.unconverted,
    required this.unpricedAssets,
  });

  /// In toman.
  final int totalMinor;
  final int walletsMinor;
  final int assetsMinor;
  final int debtsMinor;

  /// In USD cents; null without a dollar rate.
  final int? usdMinor;

  /// Decimal text of grams of 18-carat gold; empty without a gold rate.
  final String goldGrams;
  final bool stale;

  /// Currencies with no rate; left out of the totals.
  final List<String> unconverted;
  final int unpricedAssets;
}

/// What a basket points at, by kind (`wallet` or `asset`) and id.
class BasketItemRef {
  const BasketItemRef(this.kind, this.refId);

  final String kind;
  final String refId;

  @override
  bool operator ==(Object other) =>
      other is BasketItemRef && other.kind == kind && other.refId == refId;

  @override
  int get hashCode => Object.hash(kind, refId);
}

class BasketItem {
  const BasketItem({
    required this.kind,
    required this.refId,
    required this.name,
    required this.valueMinor,
  });

  final String kind;
  final String refId;
  final String name;
  final int valueMinor;
}

class Basket {
  const Basket({
    required this.id,
    required this.name,
    required this.targetMinor,
    required this.valueMinor,
    required this.percent,
    required this.items,
  });

  final String id;
  final String name;
  final int targetMinor;
  final int valueMinor;

  /// May exceed 100 once the goal is passed.
  final int percent;
  final List<BasketItem> items;
}

/// One day's recorded net worth in toman.
class NetWorthPoint {
  const NetWorthPoint(this.day, this.totalMinor);

  final DateTime day;
  final int totalMinor;
}
