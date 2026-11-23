enum EntryKind {
  income('income'),
  expense('expense'),
  transferOut('transfer_out'),
  transferIn('transfer_in');

  const EntryKind(this.wire);
  final String wire;

  /// Money arriving in the wallet (income, or the incoming leg of a transfer).
  bool get isCredit => this == income || this == transferIn;

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
  });

  final String id;
  final String walletId;
  final EntryKind kind;
  final int amountMinor;
  final String currency;
  final DateTime occurredAt;
  final String note;
}
