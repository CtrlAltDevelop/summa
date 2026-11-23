import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import '../../gen/apps/recurring/grpc/recurring.pbgrpc.dart' as pb;
import '../wallets/grpc_guard.dart';
import 'recurring_models.dart';

abstract interface class RecurringApi {
  Future<RecurringState> list(String access);
  Future<void> create(
    String access, {
    required String walletId,
    required String kind,
    required int amountMinor,
    required String note,
    required RecurringPeriod period,
    required int day,
    required bool autoConfirm,
    required String clientMutationId,
  });
  Future<void> setActive(String access, String id, {required bool active});
  Future<void> delete(String access, String id);

  /// [action] is `confirm`, `other_wallet` or `cancel`.
  Future<void> resolve(
    String access, {
    required String occurrenceId,
    required String action,
    String walletId = '',
    int amountMinor = 0,
  });
}

class GrpcRecurringApi implements RecurringApi {
  GrpcRecurringApi(ClientChannel channel)
    : _client = pb.RecurringControllerClient(channel);

  final pb.RecurringControllerClient _client;

  static CallOptions _bearer(String token) =>
      CallOptions(metadata: {'authorization': 'Bearer $token'});

  @override
  Future<RecurringState> list(String access) => guardGrpc(() async {
    final r = await _client.list(Empty(), options: _bearer(access));
    return RecurringState(
      recurrings: r.recurrings
          .map(
            (m) => Recurring(
              id: m.id,
              walletId: m.walletId,
              kind: m.kind,
              amountMinor: m.amountMinor.toInt(),
              currency: m.currency,
              note: m.note,
              period: RecurringPeriod.fromWire(m.period),
              day: m.day,
              autoConfirm: m.autoConfirm,
              active: m.active,
              nextDue: DateTime.parse(m.nextDue),
            ),
          )
          .toList(),
      occurrences: r.occurrences
          .map(
            (m) => Occurrence(
              id: m.id,
              recurringId: m.recurringId,
              walletId: m.walletId,
              kind: m.kind,
              amountMinor: m.amountMinor.toInt(),
              currency: m.currency,
              note: m.note,
              dueDate: DateTime.parse(m.dueDate),
              isDue: m.status == 'due',
              lowBalance: m.lowBalance,
            ),
          )
          .toList(),
    );
  });

  @override
  Future<void> create(
    String access, {
    required String walletId,
    required String kind,
    required int amountMinor,
    required String note,
    required RecurringPeriod period,
    required int day,
    required bool autoConfirm,
    required String clientMutationId,
  }) => guardGrpc(() async {
    await _client.create(
      pb.RecurringCreate(
        walletId: walletId,
        kind: kind,
        amountMinor: Int64(amountMinor),
        note: note,
        period: period.wire,
        day: day,
        autoConfirm: autoConfirm,
        clientMutationId: clientMutationId,
      ),
      options: _bearer(access),
    );
  });

  @override
  Future<void> setActive(String access, String id, {required bool active}) =>
      guardGrpc(() async {
        await _client.setActive(
          pb.RecurringActive(recurringId: id, active: active),
          options: _bearer(access),
        );
      });

  @override
  Future<void> delete(String access, String id) => guardGrpc(() async {
    await _client.delete(
      pb.RecurringRef(recurringId: id),
      options: _bearer(access),
    );
  });

  @override
  Future<void> resolve(
    String access, {
    required String occurrenceId,
    required String action,
    String walletId = '',
    int amountMinor = 0,
  }) => guardGrpc(() async {
    await _client.resolve(
      pb.OccurrenceAnswer(
        occurrenceId: occurrenceId,
        action: action,
        walletId: walletId,
        amountMinor: Int64(amountMinor),
      ),
      options: _bearer(access),
    );
  });
}
