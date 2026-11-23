import 'package:summa/features/wallets/entry_models.dart';
import 'package:summa/features/wallets/ledger_api.dart';

import 'fake_wallet_api.dart';

/// In-memory [LedgerApi] that moves balances in the shared [FakeWalletApi].
class FakeLedgerApi implements LedgerApi {
  FakeLedgerApi(this.wallets);

  final FakeWalletApi wallets;
  final List<Entry> entries = [];
  final List<String> mutations = [];

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
    );
    entries.add(entry);
    wallets.shift(
      walletId,
      kind == EntryKind.income ? amountMinor : -amountMinor,
    );
    return entry;
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
