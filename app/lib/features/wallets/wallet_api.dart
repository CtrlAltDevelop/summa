import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import '../../gen/apps/wallets/grpc/wallets.pbgrpc.dart' as pb;
import 'grpc_guard.dart';
import 'wallet_models.dart';

abstract interface class WalletApi {
  Future<WalletList> list(String access);
  Future<Wallet> create(
    String access, {
    required String name,
    required WalletKind kind,
    required String currency,
    required String bank,
    required int openingBalanceMinor,
    required String clientMutationId,
  });
  Future<Wallet> archive(String access, String walletId);
}

/// [WalletApi] over gRPC. A refused token becomes [AuthException] so the
/// auth controller can refresh and retry; everything else is a [WalletException].
class GrpcWalletApi implements WalletApi {
  GrpcWalletApi(ClientChannel channel)
    : _client = pb.WalletsControllerClient(channel);

  final pb.WalletsControllerClient _client;

  static CallOptions _bearer(String token) =>
      CallOptions(metadata: {'authorization': 'Bearer $token'});

  @override
  Future<WalletList> list(String access) => guardGrpc(() async {
    final r = await _client.list(Empty(), options: _bearer(access));
    return WalletList(
      wallets: r.wallets.map(_wallet).toList(),
      totals: r.totals
          .map(
            (t) => CurrencyTotal(
              currency: t.currency,
              balanceMinor: t.balanceMinor.toInt(),
            ),
          )
          .toList(),
    );
  });

  @override
  Future<Wallet> create(
    String access, {
    required String name,
    required WalletKind kind,
    required String currency,
    required String bank,
    required int openingBalanceMinor,
    required String clientMutationId,
  }) => guardGrpc(() async {
    final r = await _client.create(
      pb.WalletCreate(
        name: name,
        kind: kind.wire,
        currency: currency,
        bank: bank,
        openingBalanceMinor: Int64(openingBalanceMinor),
        clientMutationId: clientMutationId,
      ),
      options: _bearer(access),
    );
    return _wallet(r.wallet);
  });

  @override
  Future<Wallet> archive(String access, String walletId) => guardGrpc(() async {
    final r = await _client.archive(
      pb.WalletRef(walletId: walletId),
      options: _bearer(access),
    );
    return _wallet(r.wallet);
  });

  static Wallet _wallet(pb.Wallet w) => Wallet(
    id: w.id,
    name: w.name,
    kind: WalletKind.fromWire(w.kind),
    currency: w.currency,
    bank: w.bank,
    archived: w.archived,
    balanceMinor: w.balanceMinor.toInt(),
  );
}
