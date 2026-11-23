class CategoryTotal {
  const CategoryTotal({
    required this.categoryId,
    required this.name,
    required this.kind,
    required this.totalMinor,
  });

  final String categoryId;
  final String name;

  /// `expense` or `income`.
  final String kind;
  final int totalMinor;
}

class DayTotal {
  const DayTotal({
    required this.day,
    required this.incomeMinor,
    required this.expenseMinor,
  });

  final DateTime day;
  final int incomeMinor;
  final int expenseMinor;
}

/// One month in one currency. Currencies are never added together.
class Report {
  const Report({
    required this.currency,
    required this.incomeMinor,
    required this.expenseMinor,
    required this.netMinor,
    required this.entries,
    required this.byCategory,
    required this.daily,
    required this.topExpenseCategory,
    required this.currencies,
  });

  final String currency;
  final int incomeMinor;
  final int expenseMinor;
  final int netMinor;
  final int entries;
  final List<CategoryTotal> byCategory;
  final List<DayTotal> daily;
  final String topExpenseCategory;

  /// Currencies with activity in this month.
  final List<String> currencies;
}

/// Which month (0 = this one) and currency to report on.
class ReportQuery {
  const ReportQuery({required this.monthOffset, required this.currency});

  final int monthOffset;
  final String currency;

  @override
  bool operator ==(Object other) =>
      other is ReportQuery &&
      other.monthOffset == monthOffset &&
      other.currency == currency;

  @override
  int get hashCode => Object.hash(monthOffset, currency);
}
