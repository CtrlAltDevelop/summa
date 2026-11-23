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

  /// When set, every call fails as if there were no connection.
  bool offline = false;

  /// When set, `record` is refused for good (not a connection problem).
  WalletFailure? refuseRecord;

  /// The rate strings sent with each transfer.
  final List<String> transferRates = [];

  @override
  Future<List<Entry>> list(String access) async {
    if (offline) throw const WalletException(WalletFailure.offline);
    return entries.reversed.toList();
  }

  @override
  Future<Entry> record(
    String access, {
    required String walletId,
    required EntryKind kind,
    required int amountMinor,
    required String note,
    required String clientMutationId,
    String categoryId = '',
    DateTime? occurredAt,
    bool outsideTotals = false,
  }) async {
    if (offline) throw const WalletException(WalletFailure.offline);
    if (refuseRecord != null) throw WalletException(refuseRecord!);
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
      outsideTotals: outsideTotals,
    );
    entries.add(entry);
    wallets.shift(
      walletId,
      kind == EntryKind.income ? amountMinor : -amountMinor,
    );
    return entry;
  }

  @override
  Future<void> recordSplit(
    String access, {
    required String walletId,
    required List<SplitPart> parts,
    required String note,
    required String clientMutationId,
  }) async {
    final wallet = wallets.wallets.firstWhere((w) => w.id == walletId);
    final group = 'split${entries.length}';
    for (final p in parts) {
      entries.add(
        Entry(
          id: 'e${entries.length + 1}',
          walletId: walletId,
          kind: EntryKind.expense,
          amountMinor: p.amountMinor,
          currency: wallet.currency,
          occurredAt: DateTime.utc(2026, 11, 1),
          note: note,
          categoryId: p.categoryId,
          outsideTotals: p.outsideTotals,
          splitId: group,
        ),
      );
      wallets.shift(walletId, -p.amountMinor);
    }
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

  final List<String> refundErrors = [];

  @override
  Future<void> refund(
    String access, {
    required String entryId,
    required String walletId,
    required int amountMinor,
    required String note,
    required String clientMutationId,
  }) async {
    final i = entries.indexWhere((e) => e.id == entryId);
    final original = entries[i];
    final amount = amountMinor == 0 ? original.refundableMinor : amountMinor;
    if (amount <= 0 || amount > original.refundableMinor) {
      refundErrors.add('over');
      throw const WalletException(WalletFailure.invalid);
    }
    final wallet = wallets.wallets.firstWhere((w) => w.id == walletId);
    entries[i] = Entry(
      id: original.id,
      walletId: original.walletId,
      kind: original.kind,
      amountMinor: original.amountMinor,
      currency: original.currency,
      occurredAt: original.occurredAt,
      note: original.note,
      categoryId: original.categoryId,
      outsideTotals: original.outsideTotals,
      refundedMinor: original.refundedMinor + amount,
    );
    entries.add(
      Entry(
        id: 'e${entries.length + 1}',
        walletId: walletId,
        kind: EntryKind.refund,
        amountMinor: amount,
        currency: wallet.currency,
        occurredAt: DateTime.utc(2026, 11, 1),
        note: note,
        categoryId: original.categoryId,
        refundOf: entryId,
      ),
    );
    wallets.shift(walletId, amount);
  }

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
