import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/grpc/grpc_providers.dart';
import '../../core/storage/snapshot.dart';
import '../../core/storage/snapshot_codecs.dart';
import '../auth/auth_controller.dart';
import 'wallet_api.dart';
import 'wallet_models.dart';

final walletApiProvider = Provider<WalletApi>(
  (ref) => GrpcWalletApi(ref.watch(grpcChannelProvider)),
);

final walletsControllerProvider =
    AsyncNotifierProvider<WalletsController, WalletList>(
      WalletsController.new,
      retry: (_, _) => null,
    );

class WalletsController extends AsyncNotifier<WalletList> {
  WalletApi get _api => ref.read(walletApiProvider);
  AuthController get _auth => ref.read(authControllerProvider.notifier);

  @override
  Future<WalletList> build() => withSnapshot(
    ref,
    'wallets',
    load: () => _auth.withAccess(_api.list),
    encode: walletListToJson,
    decode: walletListFromJson,
  );

  /// Creates a wallet. [clientMutationId] must stay the same for a retry of
  /// the same form so the server does not make a second wallet.
  Future<void> create({
    required String name,
    required WalletKind kind,
    required String currency,
    required String bank,
    required int openingBalanceMinor,
    required String clientMutationId,
  }) async {
    await _auth.withAccess(
      (access) => _api.create(
        access,
        name: name,
        kind: kind,
        currency: currency,
        bank: bank,
        openingBalanceMinor: openingBalanceMinor,
        clientMutationId: clientMutationId,
      ),
    );
    await _reload();
  }

  Future<void> archive(String walletId) async {
    await _auth.withAccess((access) => _api.archive(access, walletId));
    await _reload();
  }

  Future<void> _reload() async {
    state = AsyncData(await _auth.withAccess(_api.list));
  }
}
