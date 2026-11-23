import 'package:flutter_test/flutter_test.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:summa/core/format/persian.dart';
import 'package:summa/features/categories/category_models.dart';

void main() {
  group('budgetLevel', () {
    test('is ok below 80%', () {
      expect(budgetLevel(79, 100), BudgetLevel.ok);
    });
    test('warns from 80% up to the limit', () {
      expect(budgetLevel(80, 100), BudgetLevel.warning);
      expect(budgetLevel(99, 100), BudgetLevel.warning);
    });
    test('is over at and beyond the limit', () {
      expect(budgetLevel(100, 100), BudgetLevel.over);
      expect(budgetLevel(250, 100), BudgetLevel.over);
    });
    test('no limit never warns', () {
      expect(budgetLevel(10, 0), BudgetLevel.ok);
    });
  });

  group('shamsiMonthWindow', () {
    test('covers the whole Shamsi month', () {
      final w = shamsiMonthWindow(Jalali(1405, 9, 15).toDateTime());

      expect(w.start, Jalali(1405, 9, 1).toDateTime().toUtc());
      expect(w.end, Jalali(1405, 10, 1).toDateTime().toUtc());
    });
    test('rolls over the year in Esfand', () {
      final w = shamsiMonthWindow(Jalali(1405, 12, 20).toDateTime());

      expect(w.end, Jalali(1406, 1, 1).toDateTime().toUtc());
    });
  });

  test('ratio of an empty limit is zero', () {
    const row = BudgetRow(
      categoryId: 'c',
      categoryName: 'x',
      currency: 'IRT',
      limitMinor: 0,
      spentMinor: 5,
    );

    expect(row.ratio, 0);
  });
}
