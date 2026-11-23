import 'package:summa/features/wallets/wallet_api.dart';
import 'package:summa/features/wallets/wallet_models.dart';

/// In-memory [WalletApi] that derives totals like the server does.
class FakeWalletApi implements WalletApi {
  final List<Wallet> wallets = [];
  final List<String> mutations = [];
  WalletFailure? createFailure;
  bool offline = false;
  WalletFailure? listFailure;

  @override
  Future<WalletList> list(String access) async {
    if (offline) throw const WalletException(WalletFailure.offline);
    if (listFailure != null) throw WalletException(listFailure!);
    final totals = <String, int>{};
    for (final w in wallets.where((w) => !w.archived)) {
      totals[w.currency] = (totals[w.currency] ?? 0) + w.balanceMinor;
    }
    return WalletList(
      wallets: List.of(wallets),
      totals: [
        for (final e in totals.entries)
          CurrencyTotal(currency: e.key, balanceMinor: e.value),
      ],
    );
  }

  @override
  Future<Wallet> create(
    String access, {
    required String name,
    required WalletKind kind,
    required String currency,
    required String bank,
    required int openingBalanceMinor,
    required String clientMutationId,
  }) async {
    if (createFailure != null) throw WalletException(createFailure!);
    if (mutations.contains(clientMutationId)) return wallets.first;
    mutations.add(clientMutationId);
    final wallet = Wallet(
      id: 'w${wallets.length + 1}',
      name: name,
      kind: kind,
      currency: currency,
      bank: bank,
      archived: false,
      balanceMinor: openingBalanceMinor,
    );
    wallets.add(wallet);
    return wallet;
  }

  @override
  Future<Wallet> archive(String access, String walletId) async {
    final i = wallets.indexWhere((w) => w.id == walletId);
    if (i < 0) throw const WalletException(WalletFailure.notFound);
    final old = wallets[i];
    wallets[i] = Wallet(
      id: old.id,
      name: old.name,
      kind: old.kind,
      currency: old.currency,
      bank: old.bank,
      archived: true,
      balanceMinor: old.balanceMinor,
    );
    return wallets[i];
  }

  /// Moves a wallet's balance, as ledger entries do on the server.
  void shift(String walletId, int deltaMinor) {
    final i = wallets.indexWhere((w) => w.id == walletId);
    final old = wallets[i];
    wallets[i] = Wallet(
      id: old.id,
      name: old.name,
      kind: old.kind,
      currency: old.currency,
      bank: old.bank,
      archived: old.archived,
      balanceMinor: old.balanceMinor + deltaMinor,
    );
  }
}
