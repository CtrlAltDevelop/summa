import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/grpc/grpc_providers.dart';
import '../auth/auth_controller.dart';
import '../categories/category_controller.dart';
import 'entry_models.dart';
import 'ledger_api.dart';
import 'wallets_controller.dart';

final ledgerApiProvider = Provider<LedgerApi>(
  (ref) => GrpcLedgerApi(ref.watch(grpcChannelProvider)),
);

final ledgerControllerProvider =
    AsyncNotifierProvider<LedgerController, List<Entry>>(
      LedgerController.new,
      retry: (_, _) => null,
    );

class LedgerController extends AsyncNotifier<List<Entry>> {
  LedgerApi get _api => ref.read(ledgerApiProvider);
  AuthController get _auth => ref.read(authControllerProvider.notifier);

  @override
  Future<List<Entry>> build() => _auth.withAccess(_api.list);

  /// [clientMutationId] stays the same for a retry of the same form.
  Future<void> record({
    required String walletId,
    required EntryKind kind,
    required int amountMinor,
    required String note,
    required String clientMutationId,
    String categoryId = '',
    DateTime? occurredAt,
  }) async {
    await _auth.withAccess(
      (access) => _api.record(
        access,
        walletId: walletId,
        kind: kind,
        amountMinor: amountMinor,
        note: note,
        clientMutationId: clientMutationId,
        categoryId: categoryId,
        occurredAt: occurredAt,
      ),
    );
    await _refresh();
  }

  Future<void> transfer({
    required String fromWalletId,
    required String toWalletId,
    required int amountMinor,
    required String rate,
    required int feeMinor,
    required String note,
    required String clientMutationId,
  }) async {
    await _auth.withAccess(
      (access) => _api.transfer(
        access,
        fromWalletId: fromWalletId,
        toWalletId: toWalletId,
        amountMinor: amountMinor,
        rate: rate,
        feeMinor: feeMinor,
        note: note,
        clientMutationId: clientMutationId,
      ),
    );
    await _refresh();
  }

  Future<void> delete(String entryId) async {
    await _auth.withAccess((access) => _api.delete(access, entryId));
    await _refresh();
  }

  /// Balances change with every entry, so the wallets reload too.
  Future<void> _refresh() async {
    state = AsyncData(await _auth.withAccess(_api.list));
    ref
      ..invalidate(walletsControllerProvider)
      ..invalidate(budgetsProvider);
  }
}
