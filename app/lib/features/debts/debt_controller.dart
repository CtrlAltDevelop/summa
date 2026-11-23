import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/grpc/grpc_providers.dart';
import '../auth/auth_controller.dart';
import '../wallets/ledger_controller.dart';
import '../wallets/wallets_controller.dart';
import 'debt_api.dart';
import 'debt_models.dart';

final debtApiProvider = Provider<DebtApi>(
  (ref) => GrpcDebtApi(ref.watch(grpcChannelProvider)),
);

final debtsControllerProvider =
    AsyncNotifierProvider<DebtsController, List<Debt>>(
      DebtsController.new,
      retry: (_, _) => null,
    );

class DebtsController extends AsyncNotifier<List<Debt>> {
  DebtApi get _api => ref.read(debtApiProvider);
  AuthController get _auth => ref.read(authControllerProvider.notifier);

  @override
  Future<List<Debt>> build() => _auth.withAccess(_api.list);

  Future<void> create({
    required DebtKind kind,
    required String title,
    required String currency,
    required int installmentMinor,
    required int count,
    required DateTime firstDue,
    required int principalMinor,
    required String walletId,
    required String clientMutationId,
  }) async {
    await _auth.withAccess(
      (a) => _api.create(
        a,
        kind: kind,
        title: title,
        currency: currency,
        installmentMinor: installmentMinor,
        count: count,
        firstDue: firstDue,
        principalMinor: principalMinor,
        walletId: walletId,
        clientMutationId: clientMutationId,
      ),
    );
    await _reload();
  }

  /// Paying (and undoing a payment) records or deletes an ordinary expense,
  /// so the ledger and the balances reload too.
  Future<void> pay(
    String installmentId, {
    String walletId = '',
    int amountMinor = 0,
  }) async {
    await _auth.withAccess(
      (a) => _api.pay(
        a,
        installmentId,
        walletId: walletId,
        amountMinor: amountMinor,
      ),
    );
    await _afterMoneyMoved();
  }

  Future<void> unpay(String installmentId) async {
    await _auth.withAccess((a) => _api.unpay(a, installmentId));
    await _afterMoneyMoved();
  }

  Future<void> delete(String debtId) async {
    await _auth.withAccess((a) => _api.delete(a, debtId));
    await _reload();
  }

  Future<void> _afterMoneyMoved() async {
    await _reload();
    ref
      ..invalidate(ledgerControllerProvider)
      ..invalidate(walletsControllerProvider);
  }

  Future<void> _reload() async {
    state = AsyncData(await _auth.withAccess(_api.list));
  }
}
