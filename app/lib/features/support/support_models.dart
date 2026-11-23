class SupportTicket {
  const SupportTicket({
    required this.id,
    required this.reference,
    required this.subject,
    required this.status,
    required this.lastMessageAt,
    required this.unread,
  });

  final String id;
  final String reference;
  final String subject;

  /// As the desk names it: `open`, `pending`, `resolved`, `closed`...
  final String status;
  final DateTime? lastMessageAt;
  final int unread;
}

class SupportMessage {
  const SupportMessage({
    required this.id,
    required this.body,
    required this.fromTeam,
    required this.createdAt,
  });

  final String id;
  final String body;

  /// Written by the desk (staff) rather than by the person.
  final bool fromTeam;
  final DateTime? createdAt;
}
