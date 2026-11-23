import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/grpc/grpc_providers.dart';
import '../auth/auth_controller.dart';
import '../wallets/ledger_controller.dart';
import '../wallets/wallets_controller.dart';
import 'recurring_api.dart';
import 'recurring_models.dart';

final recurringApiProvider = Provider<RecurringApi>(
  (ref) => GrpcRecurringApi(ref.watch(grpcChannelProvider)),
);

final recurringControllerProvider =
    AsyncNotifierProvider<RecurringController, RecurringState>(
      RecurringController.new,
      retry: (_, _) => null,
    );

class RecurringController extends AsyncNotifier<RecurringState> {
  RecurringApi get _api => ref.read(recurringApiProvider);
  AuthController get _auth => ref.read(authControllerProvider.notifier);

  @override
  Future<RecurringState> build() => _auth.withAccess(_api.list);

  Future<void> create({
    required String walletId,
    required String kind,
    required int amountMinor,
    required String note,
    required RecurringPeriod period,
    required int day,
    required bool autoConfirm,
    required String clientMutationId,
    String categoryId = '',
  }) async {
    await _auth.withAccess(
      (a) => _api.create(
        a,
        walletId: walletId,
        kind: kind,
        amountMinor: amountMinor,
        note: note,
        period: period,
        day: day,
        autoConfirm: autoConfirm,
        clientMutationId: clientMutationId,
        categoryId: categoryId,
      ),
    );
    await _reload();
  }

  Future<void> settleNow(String id, {int amountMinor = 0}) async {
    await _auth.withAccess(
      (a) => _api.settleNow(a, id, amountMinor: amountMinor),
    );
    await _reload();
    ref
      ..invalidate(ledgerControllerProvider)
      ..invalidate(walletsControllerProvider);
  }

  Future<void> setActive(String id, {required bool active}) async {
    await _auth.withAccess((a) => _api.setActive(a, id, active: active));
    await _reload();
  }

  Future<void> delete(String id) async {
    await _auth.withAccess((a) => _api.delete(a, id));
    await _reload();
  }

  /// Answers a cycle. A confirmation records an ordinary entry, so the
  /// ledger and the balances reload.
  Future<void> resolve({
    required String occurrenceId,
    required String action,
    String walletId = '',
    int amountMinor = 0,
  }) async {
    await _auth.withAccess(
      (a) => _api.resolve(
        a,
        occurrenceId: occurrenceId,
        action: action,
        walletId: walletId,
        amountMinor: amountMinor,
      ),
    );
    await _reload();
    ref
      ..invalidate(ledgerControllerProvider)
      ..invalidate(walletsControllerProvider);
  }

  Future<void> _reload() async {
    state = AsyncData(await _auth.withAccess(_api.list));
  }
}
