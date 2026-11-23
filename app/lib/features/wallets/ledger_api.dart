import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';

import '../../gen/apps/wallets/grpc/wallets.pbgrpc.dart' as pb;
import 'entry_models.dart';
import 'grpc_guard.dart';

abstract interface class LedgerApi {
  Future<List<Entry>> list(String access);
  Future<Entry> record(
    String access, {
    required String walletId,
    required EntryKind kind,
    required int amountMinor,
    required String note,
    required String clientMutationId,
    String categoryId = '',
  });
  Future<void> transfer(
    String access, {
    required String fromWalletId,
    required String toWalletId,
    required int amountMinor,
    required String rate,
    required int feeMinor,
    required String note,
    required String clientMutationId,
  });
  Future<void> delete(String access, String entryId);
}

class GrpcLedgerApi implements LedgerApi {
  GrpcLedgerApi(ClientChannel channel)
    : _client = pb.LedgerControllerClient(channel);

  final pb.LedgerControllerClient _client;

  static CallOptions _bearer(String token) =>
      CallOptions(metadata: {'authorization': 'Bearer $token'});

  @override
  Future<List<Entry>> list(String access) => guardGrpc(() async {
    final r = await _client.list(pb.EntryQuery(), options: _bearer(access));
    return r.entries.map(_entry).toList();
  });

  @override
  Future<Entry> record(
    String access, {
    required String walletId,
    required EntryKind kind,
    required int amountMinor,
    required String note,
    required String clientMutationId,
    String categoryId = '',
  }) => guardGrpc(() async {
    final r = await _client.record(
      pb.EntryRecord(
        walletId: walletId,
        kind: kind.wire,
        amountMinor: Int64(amountMinor),
        note: note,
        clientMutationId: clientMutationId,
        categoryId: categoryId,
      ),
      options: _bearer(access),
    );
    return _entry(r.entry);
  });

  @override
  Future<void> transfer(
    String access, {
    required String fromWalletId,
    required String toWalletId,
    required int amountMinor,
    required String rate,
    required int feeMinor,
    required String note,
    required String clientMutationId,
  }) => guardGrpc(() async {
    await _client.transfer(
      pb.TransferRequest(
        fromWalletId: fromWalletId,
        toWalletId: toWalletId,
        amountMinor: Int64(amountMinor),
        rate: rate,
        feeMinor: Int64(feeMinor),
        note: note,
        clientMutationId: clientMutationId,
      ),
      options: _bearer(access),
    );
  });

  @override
  Future<void> delete(String access, String entryId) => guardGrpc(() async {
    await _client.delete(
      pb.EntryRef(entryId: entryId),
      options: _bearer(access),
    );
  });

  static Entry _entry(pb.Entry e) => Entry(
    id: e.id,
    walletId: e.walletId,
    kind: EntryKind.fromWire(e.kind),
    amountMinor: e.amountMinor.toInt(),
    currency: e.currency,
    occurredAt: DateTime.parse(e.occurredAt),
    note: e.note,
    categoryId: e.categoryId,
  );
}
