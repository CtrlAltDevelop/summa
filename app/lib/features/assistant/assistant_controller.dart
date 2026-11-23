import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/grpc/grpc_providers.dart';
import '../auth/auth_controller.dart';
import 'assistant_api.dart';
import 'chat_models.dart';

final assistantApiProvider = Provider<AssistantApi>(
  (ref) => GrpcAssistantApi(ref.watch(grpcChannelProvider)),
);

final assistantControllerProvider =
    AsyncNotifierProvider<AssistantController, List<ChatMessage>>(
      AssistantController.new,
      retry: (_, _) => null,
    );

/// Card ids (the assistant message ids) already registered in this session.
final registeredCardsProvider = NotifierProvider<RegisteredCards, Set<String>>(
  RegisteredCards.new,
);

class RegisteredCards extends Notifier<Set<String>> {
  @override
  Set<String> build() => {};

  void add(String id) => state = {...state, id};
}

class AssistantController extends AsyncNotifier<List<ChatMessage>> {
  AssistantApi get _api => ref.read(assistantApiProvider);
  AuthController get _auth => ref.read(authControllerProvider.notifier);

  @override
  Future<List<ChatMessage>> build() => _auth.withAccess(_api.history);

  Future<void> send(String text) async {
    final created = await _auth.withAccess(
      (access) =>
          _api.send(access, text: text, clientMutationId: _newMutationId()),
    );
    state = AsyncData([...?state.value, ...created]);
  }

  Future<SmsCard> parseSms(String text) =>
      _auth.withAccess((access) => _api.parseSms(access, text));

  Future<void> linkCard(String last4, String walletId) => _auth.withAccess(
    (access) => _api.linkCard(access, last4: last4, walletId: walletId),
  );

  Future<void> clear() async {
    await _auth.withAccess(_api.clear);
    state = const AsyncData([]);
    ref.invalidate(registeredCardsProvider);
  }

  static String _newMutationId() {
    final random = Random.secure();
    return List.generate(
      16,
      (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
  }
}
