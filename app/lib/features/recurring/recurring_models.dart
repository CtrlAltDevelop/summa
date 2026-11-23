enum RecurringPeriod {
  monthly('monthly'),
  weekly('weekly');

  const RecurringPeriod(this.wire);
  final String wire;

  static RecurringPeriod fromWire(String wire) =>
      values.firstWhere((p) => p.wire == wire, orElse: () => monthly);
}

/// A repeating expense or income. [amountMinor] of zero means a variable
/// amount that is asked for each time.
class Recurring {
  const Recurring({
    required this.id,
    required this.walletId,
    required this.kind,
    required this.amountMinor,
    required this.currency,
    required this.note,
    required this.period,
    required this.day,
    required this.autoConfirm,
    required this.active,
    required this.nextDue,
  });

  final String id;
  final String walletId;
  final String kind;
  final int amountMinor;
  final String currency;
  final String note;
  final RecurringPeriod period;
  final int day;
  final bool autoConfirm;
  final bool active;
  final DateTime nextDue;
}

/// One cycle waiting for an answer.
class Occurrence {
  const Occurrence({
    required this.id,
    required this.recurringId,
    required this.walletId,
    required this.kind,
    required this.amountMinor,
    required this.currency,
    required this.note,
    required this.dueDate,
    required this.isDue,
    required this.lowBalance,
  });

  final String id;
  final String recurringId;
  final String walletId;
  final String kind;
  final int amountMinor;
  final String currency;
  final String note;
  final DateTime dueDate;

  /// Due today or earlier; otherwise it is only coming up.
  final bool isDue;
  final bool lowBalance;
  bool get isVariable => amountMinor == 0;
}

class RecurringState {
  const RecurringState({required this.recurrings, required this.occurrences});

  static const empty = RecurringState(recurrings: [], occurrences: []);

  final List<Recurring> recurrings;
  final List<Occurrence> occurrences;
}

/// Python weekday numbers (0 = Monday) in the order the week is shown:
/// Saturday first.
const weekdayOrder = [5, 6, 0, 1, 2, 3, 4];
