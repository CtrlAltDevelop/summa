enum EntryKind {
  income('income'),
  expense('expense');

  const EntryKind(this.wire);
  final String wire;

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
