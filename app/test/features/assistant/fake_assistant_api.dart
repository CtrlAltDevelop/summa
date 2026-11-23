import 'package:summa/features/assistant/assistant_api.dart';
import 'package:summa/features/assistant/chat_models.dart';

/// Scriptable [AssistantApi]: answers every sentence with [nextCard] (or help).
class FakeAssistantApi implements AssistantApi {
  ChatCard? nextCard;
  final List<ChatMessage> messages = [];
  final List<String> sent = [];
  SmsCard? nextSms;
  Digest digestResult = const Digest(
    accountingHour: -1,
    entriesToday: 0,
    uncategorizedToday: 0,
    dueQuestions: 0,
    lowBalanceWarnings: 0,
    shouldRemind: false,
  );
  final List<int> hours = [];
  final List<(String, String)> links = [];

  @override
  Future<List<ChatMessage>> history(String access) async => List.of(messages);

  @override
  Future<List<ChatMessage>> send(
    String access, {
    required String text,
    required String clientMutationId,
  }) async {
    sent.add(text);
    final n = messages.length;
    final created = [
      ChatMessage(id: 'u$n', fromUser: true, text: text),
      ChatMessage(
        id: 'a$n',
        fromUser: false,
        text: nextCard == null ? 'مبلغی پیدا نکردم.' : 'این را ثبت کنم؟',
        card: nextCard,
      ),
    ];
    messages.addAll(created);
    return created;
  }

  @override
  Future<void> clear(String access) async => messages.clear();

  @override
  Future<SmsCard> parseSms(String access, String text) async {
    sent.add(text);
    return nextSms!;
  }

  @override
  Future<void> linkCard(
    String access, {
    required String last4,
    required String walletId,
  }) async => links.add((last4, walletId));

  @override
  Future<Digest> digest(String access) async => digestResult;

  @override
  Future<void> setAccountingHour(String access, int hour) async {
    hours.add(hour);
    digestResult = Digest(
      accountingHour: hour,
      entriesToday: digestResult.entriesToday,
      uncategorizedToday: digestResult.uncategorizedToday,
      dueQuestions: digestResult.dueQuestions,
      lowBalanceWarnings: digestResult.lowBalanceWarnings,
      shouldRemind: digestResult.shouldRemind,
    );
  }
}
