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
