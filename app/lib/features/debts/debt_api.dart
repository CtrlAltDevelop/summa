import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import '../../core/format/persian.dart';
import '../../gen/apps/debts/grpc/debts.pbgrpc.dart' as pb;
import '../wallets/grpc_guard.dart';
import 'debt_models.dart';

abstract interface class DebtApi {
  Future<List<Debt>> list(String access);
  Future<void> create(
    String access, {
    required DebtKind kind,
    required String title,
    required String currency,
    required int installmentMinor,
    required int count,
    required DateTime firstDue,
    required int principalMinor,
    required String walletId,
    required String clientMutationId,
  });

  /// An empty [walletId] pays from the debt's own wallet; an [amountMinor]
  /// of zero pays the planned amount.
  Future<void> pay(
    String access,
    String installmentId, {
    String walletId = '',
    int amountMinor = 0,
  });
  Future<void> unpay(String access, String installmentId);
  Future<void> delete(String access, String debtId);
}

class GrpcDebtApi implements DebtApi {
  GrpcDebtApi(ClientChannel channel)
    : _client = pb.DebtsControllerClient(channel);

  final pb.DebtsControllerClient _client;

  static CallOptions _bearer(String token) =>
      CallOptions(metadata: {'authorization': 'Bearer $token'});

  @override
  Future<List<Debt>> list(String access) => guardGrpc(() async {
    final r = await _client.list(Empty(), options: _bearer(access));
    return r.debts.map(_debt).toList();
  });

  @override
  Future<void> create(
    String access, {
    required DebtKind kind,
    required String title,
    required String currency,
    required int installmentMinor,
    required int count,
    required DateTime firstDue,
    required int principalMinor,
    required String walletId,
    required String clientMutationId,
  }) => guardGrpc(() async {
    await _client.create(
      pb.DebtCreate(
        kind: kind.wire,
        title: title,
        currency: currency,
        installmentMinor: Int64(installmentMinor),
        count: count,
        firstDue: isoDate(firstDue),
        principalMinor: Int64(principalMinor),
        walletId: walletId,
        clientMutationId: clientMutationId,
      ),
      options: _bearer(access),
    );
  });

  @override
  Future<void> pay(
    String access,
    String installmentId, {
    String walletId = '',
    int amountMinor = 0,
  }) => guardGrpc(() async {
    await _client.pay(
      pb.InstallmentPay(
        installmentId: installmentId,
        walletId: walletId,
        amountMinor: Int64(amountMinor),
      ),
      options: _bearer(access),
    );
  });

  @override
  Future<void> unpay(String access, String installmentId) =>
      guardGrpc(() async {
        await _client.unpay(
          pb.InstallmentRef(installmentId: installmentId),
          options: _bearer(access),
        );
      });

  @override
  Future<void> delete(String access, String debtId) => guardGrpc(() async {
    await _client.delete(pb.DebtRef(debtId: debtId), options: _bearer(access));
  });

  static Debt _debt(pb.DebtMsg d) => Debt(
    id: d.id,
    kind: DebtKind.fromWire(d.kind),
    title: d.title,
    currency: d.currency,
    installmentMinor: d.installmentMinor.toInt(),
    count: d.count,
    walletId: d.walletId,
    paidCount: d.paidCount,
    remainingMinor: d.remainingMinor.toInt(),
    nextDue: d.nextDue.isEmpty ? null : DateTime.parse(d.nextDue),
    closed: d.closed,
    installments: d.installments
        .map(
          (i) => Installment(
            id: i.id,
            number: i.number,
            dueDate: DateTime.parse(i.dueDate),
            amountMinor: i.amountMinor.toInt(),
            paid: i.paid,
            overdue: i.overdue,
          ),
        )
        .toList(),
  );
}
