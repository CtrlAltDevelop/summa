import 'package:summa/features/wallets/entry_models.dart';
import 'package:summa/features/wallets/ledger_api.dart';
import 'package:summa/features/wallets/wallet_models.dart';

import 'fake_wallet_api.dart';

/// In-memory [LedgerApi] that moves balances in the shared [FakeWalletApi].
class FakeLedgerApi implements LedgerApi {
  FakeLedgerApi(this.wallets);

  final FakeWalletApi wallets;
  final List<Entry> entries = [];
  final List<String> mutations = [];

  /// The rate strings sent with each transfer.
  final List<String> transferRates = [];

  @override
  Future<List<Entry>> list(String access) async => entries.reversed.toList();

  @override
  Future<Entry> record(
    String access, {
    required String walletId,
    required EntryKind kind,
    required int amountMinor,
    required String note,
    required String clientMutationId,
    String categoryId = '',
  }) async {
    if (mutations.contains(clientMutationId)) return entries.first;
    mutations.add(clientMutationId);
    final wallet = wallets.wallets.firstWhere((w) => w.id == walletId);
    final entry = Entry(
      id: 'e${entries.length + 1}',
      walletId: walletId,
      kind: kind,
      amountMinor: amountMinor,
      currency: wallet.currency,
      occurredAt: DateTime.utc(2026, 11, 1),
      note: note,
      categoryId: categoryId,
    );
    entries.add(entry);
    wallets.shift(
      walletId,
      kind == EntryKind.income ? amountMinor : -amountMinor,
    );
    return entry;
  }

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
  }) async {
    transferRates.add(rate);
    final from = wallets.wallets.firstWhere((w) => w.id == fromWalletId);
    final to = wallets.wallets.firstWhere((w) => w.id == toWalletId);
    final received = from.currency == to.currency
        ? amountMinor
        : (amountMinor *
                  double.parse(rate) *
                  _pow10(
                    currencyDecimals[to.currency]! -
                        currencyDecimals[from.currency]!,
                  ))
              .round();
    Entry leg(
      String id,
      String wallet,
      EntryKind kind,
      int amount,
      String cur,
    ) => Entry(
      id: id,
      walletId: wallet,
      kind: kind,
      amountMinor: amount,
      currency: cur,
      occurredAt: DateTime.utc(2026, 11, 1),
      note: note,
    );
    final n = entries.length;
    entries
      ..add(
        leg(
          'e${n + 1}',
          from.id,
          EntryKind.transferOut,
          amountMinor,
          from.currency,
        ),
      )
      ..add(
        leg('e${n + 2}', to.id, EntryKind.transferIn, received, to.currency),
      );
    wallets.shift(from.id, -amountMinor - feeMinor);
    wallets.shift(to.id, received);
  }

  static num _pow10(int n) => n >= 0
      ? List.filled(n, 10).fold(1, (a, b) => a * b)
      : 1 / List.filled(-n, 10).fold(1, (a, b) => a * b);

  @override
  Future<void> delete(String access, String entryId) async {
    final entry = entries.firstWhere((e) => e.id == entryId);
    entries.remove(entry);
    wallets.shift(
      entry.walletId,
      entry.kind == EntryKind.income ? -entry.amountMinor : entry.amountMinor,
    );
  }
}
