import 'package:summa/features/assistant/assistant_api.dart';
import 'package:summa/features/assistant/chat_models.dart';

/// Scriptable [AssistantApi]: answers every sentence with [nextCard] (or help).
class FakeAssistantApi implements AssistantApi {
  ChatCard? nextCard;
  final List<ChatMessage> messages = [];
  final List<String> sent = [];

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
}
