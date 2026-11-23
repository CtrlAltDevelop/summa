import 'package:summa/features/categories/category_api.dart';
import 'package:summa/features/categories/category_models.dart';
import 'package:summa/features/wallets/entry_models.dart';

import '../wallets/fake_ledger_api.dart';

/// In-memory [CategoryApi]: a few defaults, and budgets whose spending is
/// summed from the shared [FakeLedgerApi] like the server does.
class FakeCategoryApi implements CategoryApi {
  FakeCategoryApi(this.ledger);

  final FakeLedgerApi ledger;
  final List<Category> categories = [
    const Category(
      id: 'c-food',
      name: 'خوراک',
      kind: CategoryKind.expense,
      isOther: false,
    ),
    const Category(
      id: 'c-other',
      name: 'سایر',
      kind: CategoryKind.expense,
      isOther: true,
    ),
    const Category(
      id: 'c-salary',
      name: 'حقوق',
      kind: CategoryKind.income,
      isOther: false,
    ),
    const Category(
      id: 'c-other-in',
      name: 'سایر درآمد',
      kind: CategoryKind.income,
      isOther: true,
    ),
  ];
  final Map<String, (String currency, int limit)> limits = {};

  @override
  Future<List<Category>> list(String access) async => List.of(categories);

  @override
  Future<Category> create(
    String access, {
    required String name,
    required CategoryKind kind,
  }) async {
    if (categories.any((c) => c.kind == kind && c.name == name)) {
      throw Exception('duplicate');
    }
    final c = Category(
      id: 'c${categories.length + 1}',
      name: name,
      kind: kind,
      isOther: false,
    );
    categories.add(c);
    return c;
  }

  @override
  Future<void> delete(String access, String categoryId) async {
    categories.removeWhere((c) => c.id == categoryId);
    limits.remove(categoryId);
  }

  @override
  Future<void> setBudget(
    String access, {
    required String categoryId,
    required String currency,
    required int limitMinor,
  }) async {
    if (limitMinor == 0) {
      limits.remove(categoryId);
    } else {
      limits[categoryId] = (currency, limitMinor);
    }
  }

  @override
  Future<List<BudgetRow>> budgets(
    String access, {
    required DateTime start,
    required DateTime end,
  }) async => [
    for (final e in limits.entries)
      BudgetRow(
        categoryId: e.key,
        categoryName: categories.firstWhere((c) => c.id == e.key).name,
        currency: e.value.$1,
        limitMinor: e.value.$2,
        spentMinor: ledger.entries
            .where(
              (x) =>
                  x.categoryId == e.key &&
                  x.kind == EntryKind.expense &&
                  x.currency == e.value.$1,
            )
            .fold(0, (a, x) => a + x.amountMinor),
      ),
  ];
}
