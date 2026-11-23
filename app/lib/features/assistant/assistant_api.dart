import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';
import 'package:grpc/grpc.dart';

import '../../gen/apps/assistant/grpc/assistant.pbgrpc.dart' as pb;
import '../wallets/grpc_guard.dart';
import 'chat_models.dart';

abstract interface class AssistantApi {
  Future<List<ChatMessage>> history(String access);

  /// Returns the new messages: the person's own and the assistant's answer.
  Future<List<ChatMessage>> send(
    String access, {
    required String text,
    required String clientMutationId,
  });
  Future<void> clear(String access);
  Future<SmsCard> parseSms(String access, String text);
  Future<Digest> digest(String access);

  /// An [hour] of -1 turns the reminder off.
  Future<void> setAccountingHour(String access, int hour);
  Future<void> linkCard(
    String access, {
    required String last4,
    required String walletId,
  });
}

class GrpcAssistantApi implements AssistantApi {
  GrpcAssistantApi(ClientChannel channel)
    : _client = pb.AssistantControllerClient(channel);

  final pb.AssistantControllerClient _client;

  static CallOptions _bearer(String token) =>
      CallOptions(metadata: {'authorization': 'Bearer $token'});

  @override
  Future<List<ChatMessage>> history(String access) => guardGrpc(() async {
    final r = await _client.history(
      pb.HistoryQuery(limit: 100),
      options: _bearer(access),
    );
    return r.messages.map(_message).toList();
  });

  @override
  Future<List<ChatMessage>> send(
    String access, {
    required String text,
    required String clientMutationId,
  }) => guardGrpc(() async {
    final r = await _client.send(
      pb.MessageSend(text: text, clientMutationId: clientMutationId),
      options: _bearer(access),
    );
    return r.messages.map(_message).toList();
  });

  @override
  Future<void> clear(String access) => guardGrpc(() async {
    await _client.clear(Empty(), options: _bearer(access));
  });

  @override
  Future<SmsCard> parseSms(String access, String text) => guardGrpc(() async {
    final r = await _client.parseSms(
      pb.SmsText(text: text),
      options: _bearer(access),
    );
    return SmsCard(
      ignored: r.ignored,
      kind: r.kind,
      amountMinor: r.amountMinor.toInt(),
      currency: r.currency,
      walletId: r.walletId,
      confidence: r.confidence,
      occurredAt: DateTime.tryParse(r.occurredAt),
      balanceMinor: r.balancePresent ? r.balanceMinor.toInt() : null,
      last4: r.last4,
      categoryId: r.categoryId,
      suggestedCategoryIds: r.suggestedCategoryIds.toList(),
      duplicateEntryId: r.duplicateEntryId,
    );
  });

  @override
  Future<Digest> digest(String access) => guardGrpc(() async {
    final r = await _client.digest(Empty(), options: _bearer(access));
    return Digest(
      accountingHour: r.accountingHour,
      entriesToday: r.entriesToday,
      uncategorizedToday: r.uncategorizedToday,
      dueQuestions: r.dueQuestions,
      lowBalanceWarnings: r.lowBalanceWarnings,
      shouldRemind: r.shouldRemind,
    );
  });

  @override
  Future<void> setAccountingHour(String access, int hour) =>
      guardGrpc(() async {
        await _client.setAccountingHour(
          pb.AccountingHour(hour: hour),
          options: _bearer(access),
        );
      });

  @override
  Future<void> linkCard(
    String access, {
    required String last4,
    required String walletId,
  }) => guardGrpc(() async {
    await _client.linkCard(
      pb.CardLink(last4: last4, walletId: walletId),
      options: _bearer(access),
    );
  });

  static ChatMessage _message(pb.Message m) => ChatMessage(
    id: m.id,
    fromUser: m.role == 'user',
    text: m.text,
    card: m.cardPresent ? _card(m.card) : null,
  );

  static ChatCard _card(pb.Card c) => ChatCard(
    kind: c.kind,
    amountMinor: c.amountMinor.toInt(),
    currency: c.currency,
    walletId: c.walletId,
    toWalletId: c.toWalletId,
    categoryId: c.categoryId,
    note: c.note,
    occurredAt: DateTime.tryParse(c.occurredAt),
  );
}
