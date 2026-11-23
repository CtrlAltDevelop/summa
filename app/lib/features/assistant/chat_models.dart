/// A suggested entry from the assistant. Registering it is the app's own
/// ordinary record (or transfer) request; the assistant writes nothing.
class ChatCard {
  const ChatCard({
    required this.kind,
    required this.amountMinor,
    required this.currency,
    required this.walletId,
    required this.toWalletId,
    required this.categoryId,
    required this.note,
    required this.occurredAt,
  });

  /// `expense`, `income` or `transfer`.
  final String kind;
  final int amountMinor;
  final String currency;

  /// Empty when the person must choose the wallet.
  final String walletId;
  final String toWalletId;
  final String categoryId;
  final String note;
  final DateTime? occurredAt;

  bool get isTransfer => kind == 'transfer';
}

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.fromUser,
    required this.text,
    this.card,
  });

  final String id;
  final bool fromUser;
  final String text;
  final ChatCard? card;
}

/// The result of parsing one bank SMS. A suggestion: registering it is the
/// app's own ordinary record request.
class SmsCard {
  const SmsCard({
    required this.ignored,
    required this.kind,
    required this.amountMinor,
    required this.currency,
    required this.walletId,
    required this.confidence,
    required this.occurredAt,
    required this.balanceMinor,
    required this.last4,
    required this.categoryId,
    required this.suggestedCategoryIds,
    required this.duplicateEntryId,
  });

  /// `otp`, `failed`, `ad`, `no_amount`, or empty when there is a card.
  final String ignored;

  /// `expense`, `income`, or empty when the direction is unknown.
  final String kind;
  final int amountMinor;
  final String currency;
  final String walletId;
  final String confidence;
  final DateTime? occurredAt;
  final int? balanceMinor;
  final String last4;
  final String categoryId;
  final List<String> suggestedCategoryIds;
  final String duplicateEntryId;
}

/// What today looks like, and whether to remind. [accountingHour] is the
/// Tehran hour the person chose, or -1 when the reminder is off.
class Digest {
  const Digest({
    required this.accountingHour,
    required this.entriesToday,
    required this.uncategorizedToday,
    required this.dueQuestions,
    required this.lowBalanceWarnings,
    required this.shouldRemind,
  });

  final int accountingHour;
  final int entriesToday;
  final int uncategorizedToday;
  final int dueQuestions;
  final int lowBalanceWarnings;
  final bool shouldRemind;
}
