import 'package:grpc/grpc.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import '../../gen/apps/privacy/grpc/privacy.pbgrpc.dart' as pb;
import '../wallets/grpc_guard.dart';

abstract interface class PrivacyApi {
  /// Days chat is kept; 0 keeps it forever.
  Future<int> chatRetentionDays(String access);
  Future<void> setChatRetention(String access, int days);

  /// Deletes the account and all its data for good. [confirmation] must be
  /// `DELETE`.
  Future<void> deleteAccount(String access, String confirmation);
}

class GrpcPrivacyApi implements PrivacyApi {
  GrpcPrivacyApi(ClientChannel channel)
    : _client = pb.PrivacyControllerClient(channel);

  final pb.PrivacyControllerClient _client;

  static CallOptions _bearer(String token) =>
      CallOptions(metadata: {'authorization': 'Bearer $token'});

  @override
  Future<int> chatRetentionDays(String access) => guardGrpc(() async {
    final r = await _client.getSettings(Empty(), options: _bearer(access));
    return r.chatRetentionDays;
  });

  @override
  Future<void> setChatRetention(String access, int days) => guardGrpc(() async {
    await _client.setChatRetention(
      pb.ChatRetention(days: days),
      options: _bearer(access),
    );
  });

  @override
  Future<void> deleteAccount(String access, String confirmation) =>
      guardGrpc(() async {
        await _client.deleteAccount(
          pb.DeleteConfirmation(confirmation: confirmation),
          options: _bearer(access),
        );
      });
}
