enum CategoryKind {
  expense('expense'),
  income('income');

  const CategoryKind(this.wire);
  final String wire;

  static CategoryKind fromWire(String wire) =>
      values.firstWhere((k) => k.wire == wire, orElse: () => expense);
}

class Category {
  const Category({
    required this.id,
    required this.name,
    required this.kind,
    required this.isOther,
  });

  final String id;
  final String name;
  final CategoryKind kind;

  /// The undeletable catch-all of its kind.
  final bool isOther;
}

/// A monthly limit with what has been spent so far this month.
class BudgetRow {
  const BudgetRow({
    required this.categoryId,
    required this.categoryName,
    required this.currency,
    required this.limitMinor,
    required this.spentMinor,
  });

  final String categoryId;
  final String categoryName;
  final String currency;
  final int limitMinor;
  final int spentMinor;

  double get ratio => limitMinor <= 0 ? 0 : spentMinor / limitMinor;

  BudgetLevel get level => budgetLevel(spentMinor, limitMinor);
}

enum BudgetLevel { ok, warning, over }

/// Share of the limit at which the bar turns to a warning.
const budgetWarnRatio = 0.8;

BudgetLevel budgetLevel(int spentMinor, int limitMinor) {
  if (limitMinor <= 0) return BudgetLevel.ok;
  if (spentMinor >= limitMinor) return BudgetLevel.over;
  if (spentMinor >= limitMinor * budgetWarnRatio) return BudgetLevel.warning;
  return BudgetLevel.ok;
}
