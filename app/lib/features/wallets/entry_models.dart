enum EntryKind {
  income('income'),
  expense('expense'),
  transferOut('transfer_out'),
  transferIn('transfer_in'),
  refund('refund');

  const EntryKind(this.wire);
  final String wire;

  /// Money arriving in the wallet (income, or the incoming leg of a transfer).
  bool get isCredit => this == income || this == transferIn || this == refund;

  /// The kinds a person can record by hand.
  static const recordable = [expense, income];

  static EntryKind fromWire(String wire) =>
      values.firstWhere((k) => k.wire == wire, orElse: () => expense);
}

/// One income or expense in the ledger.
class Entry {
  const Entry({
    required this.id,
    required this.walletId,
    required this.kind,
    required this.amountMinor,
    required this.currency,
    required this.occurredAt,
    required this.note,
    this.categoryId = '',
    this.outsideTotals = false,
    this.splitId = '',
    this.refundOf = '',
    this.refundedMinor = 0,
  });

  final String id;
  final String walletId;
  final EntryKind kind;
  final int amountMinor;
  final String currency;
  final DateTime occurredAt;
  final String note;

  /// Empty when the entry has no category (transfers, fees).
  final String categoryId;

  /// Money that left the wallet but is not the person's own expense.
  final bool outsideTotals;

  /// Shared by all parts of one split expense; empty otherwise.
  final String splitId;

  /// For a refund: the expense it gives money back for.
  final String refundOf;

  /// For an expense: how much has been refunded so far.
  final int refundedMinor;

  int get refundableMinor =>
      kind == EntryKind.expense ? amountMinor - refundedMinor : 0;
}

/// One share of a split expense.
class SplitPart {
  const SplitPart({
    required this.categoryId,
    required this.amountMinor,
    this.outsideTotals = false,
  });

  final String categoryId;
  final int amountMinor;
  final bool outsideTotals;
}
