import 'package:grpc/grpc.dart';

import '../../gen/apps/support/grpc/support.pbgrpc.dart' as pb;
import '../wallets/grpc_guard.dart';
import 'support_models.dart';

abstract interface class SupportApi {
  Future<List<SupportTicket>> tickets(String access);
  Future<SupportTicket> open(
    String access, {
    required String subject,
    required String body,
  });
  Future<List<SupportMessage>> messages(String access, String ticketId);
  Future<void> send(String access, String ticketId, String body);
}

class GrpcSupportApi implements SupportApi {
  GrpcSupportApi(ClientChannel channel)
    : _client = pb.SupportControllerClient(channel);

  final pb.SupportControllerClient _client;

  static CallOptions _bearer(String token) =>
      CallOptions(metadata: {'authorization': 'Bearer $token'});

  static SupportTicket _ticket({
    required String id,
    required String reference,
    required String subject,
    required String status,
    required String lastMessageAt,
    required int unread,
  }) => SupportTicket(
    id: id,
    reference: reference,
    subject: subject,
    status: status,
    lastMessageAt: DateTime.tryParse(lastMessageAt),
    unread: unread,
  );

  @override
  Future<List<SupportTicket>> tickets(String access) => guardGrpc(() async {
    final r = await _client.list(
      pb.ListRequest(mine: true, limit: 50),
      options: _bearer(access),
    );
    return r.tickets
        .map(
          (t) => _ticket(
            id: t.id,
            reference: t.reference,
            subject: t.subject,
            status: t.status,
            lastMessageAt: t.lastMessageAt,
            unread: t.unread,
          ),
        )
        .toList();
  });

  @override
  Future<SupportTicket> open(
    String access, {
    required String subject,
    required String body,
  }) => guardGrpc(() async {
    final t = await _client.open(
      pb.OpenRequest(subject: subject, body: body),
      options: _bearer(access),
    );
    return _ticket(
      id: t.id,
      reference: t.reference,
      subject: t.subject,
      status: t.status,
      lastMessageAt: t.lastMessageAt,
      unread: t.unread,
    );
  });

  @override
  Future<List<SupportMessage>> messages(String access, String ticketId) =>
      guardGrpc(() async {
        final r = await _client.messages(
          pb.MessagesRequest(ticketId: ticketId, limit: 200),
          options: _bearer(access),
        );
        return r.messages
            .map(
              (m) => SupportMessage(
                id: m.id,
                body: m.body,
                fromTeam: m.author.staff,
                createdAt: DateTime.tryParse(m.createdAt),
              ),
            )
            .toList();
      });

  @override
  Future<void> send(String access, String ticketId, String body) =>
      guardGrpc(() async {
        await _client.send(
          pb.SendRequest(ticketId: ticketId, body: body),
          options: _bearer(access),
        );
      });
}
