enum DebtKind {
  bankLoan('bank_loan'),
  installmentPurchase('installment_purchase'),
  personal('personal');

  const DebtKind(this.wire);
  final String wire;

  static DebtKind fromWire(String wire) =>
      values.firstWhere((k) => k.wire == wire, orElse: () => bankLoan);
}

class Installment {
  const Installment({
    required this.id,
    required this.number,
    required this.dueDate,
    required this.amountMinor,
    required this.paid,
    required this.overdue,
  });

  final String id;
  final int number;
  final DateTime dueDate;
  final int amountMinor;
  final bool paid;
  final bool overdue;
}

class Debt {
  const Debt({
    required this.id,
    required this.kind,
    required this.title,
    required this.currency,
    required this.installmentMinor,
    required this.count,
    required this.walletId,
    required this.paidCount,
    required this.remainingMinor,
    required this.nextDue,
    required this.closed,
    required this.installments,
  });

  final String id;
  final DebtKind kind;
  final String title;
  final String currency;
  final int installmentMinor;
  final int count;
  final String walletId;
  final int paidCount;
  final int remainingMinor;
  final DateTime? nextDue;
  final bool closed;
  final List<Installment> installments;

  bool get hasOverdue => installments.any((i) => i.overdue);
}
