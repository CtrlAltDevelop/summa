import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/storage/key_value_store.dart';
import '../auth/auth_controller.dart';
import '../auth/auth_models.dart';
import '../categories/category_controller.dart';
import '../wallets/entry_models.dart';
import '../wallets/ledger_controller.dart';
import '../wallets/wallet_models.dart';
import '../wallets/wallets_controller.dart';

const outboxKey = 'outbox';

/// A recorded entry waiting for a connection. Its [mutationId] is the one the
/// server will see, so sending it twice can never record it twice.
class QueuedEntry {
  const QueuedEntry({
    required this.mutationId,
    required this.walletId,
    required this.kind,
    required this.amountMinor,
    required this.currency,
    required this.note,
    required this.categoryId,
    required this.outsideTotals,
    required this.createdAt,
  });

  final String mutationId;
  final String walletId;
  final EntryKind kind;
  final int amountMinor;
  final String currency;
  final String note;
  final String categoryId;
  final bool outsideTotals;
  final DateTime createdAt;

  Map<String, Object?> toJson() => {
    'id': mutationId,
    'wallet': walletId,
    'kind': kind.wire,
    'amount': amountMinor,
    'currency': currency,
    'note': note,
    'category': categoryId,
    'outside': outsideTotals,
    'at': createdAt.toUtc().toIso8601String(),
  };

  static QueuedEntry fromJson(Map<String, Object?> j) => QueuedEntry(
    mutationId: j['id']! as String,
    walletId: j['wallet']! as String,
    kind: EntryKind.fromWire(j['kind']! as String),
    amountMinor: j['amount']! as int,
    currency: j['currency']! as String,
    note: j['note']! as String,
    categoryId: j['category']! as String,
    outsideTotals: j['outside']! as bool,
    createdAt: DateTime.parse(j['at']! as String),
  );
}

/// An entry the server refused for good (not a connection problem).
class FailedEntry {
  const FailedEntry({required this.entry, required this.reason});

  final QueuedEntry entry;
  final WalletFailure reason;
}

class OutboxState {
  const OutboxState({this.pending = const [], this.failed = const []});

  final List<QueuedEntry> pending;
  final List<FailedEntry> failed;
}

final outboxProvider = NotifierProvider<OutboxController, OutboxState>(
  OutboxController.new,
);

/// Queue of entries recorded while offline. Kept on disk, sent in order, and
/// only ever removed once the server accepted (or refused) it.
class OutboxController extends Notifier<OutboxState> {
  bool _flushing = false;

  KeyValueStore get _store => ref.read(keyValueStoreProvider);

  @override
  OutboxState build() {
    _load();
    return const OutboxState();
  }

  Future<void> _load() async {
    final raw = await _store.read(outboxKey);
    if (raw == null) return;
    final j = jsonDecode(raw) as Map<String, Object?>;
    state = OutboxState(
      pending: [
        for (final p in j['pending']! as List<Object?>)
          QueuedEntry.fromJson(p! as Map<String, Object?>),
      ],
      failed: [
        for (final f in j['failed']! as List<Object?>)
          FailedEntry(
            entry: QueuedEntry.fromJson(
              (f! as Map<String, Object?>)['entry']! as Map<String, Object?>,
            ),
            reason: WalletFailure.values.byName(
              (f as Map<String, Object?>)['reason']! as String,
            ),
          ),
      ],
    );
  }

  Future<void> _save(OutboxState next) async {
    state = next;
    await _store.write(
      outboxKey,
      jsonEncode({
        'pending': next.pending.map((e) => e.toJson()).toList(),
        'failed': [
          for (final f in next.failed)
            {'entry': f.entry.toJson(), 'reason': f.reason.name},
        ],
      }),
    );
  }

  Future<void> enqueue(QueuedEntry entry) => _save(
    OutboxState(pending: [...state.pending, entry], failed: state.failed),
  );

  Future<void> dismissFailed(String mutationId) => _save(
    OutboxState(
      pending: state.pending,
      failed: state.failed
          .where((f) => f.entry.mutationId != mutationId)
          .toList(),
    ),
  );

  /// Sends what is queued, oldest first. Stops at the first connection
  /// problem (the rest would fail the same way) and keeps everything unsent.
  Future<void> flush() async {
    if (_flushing || state.pending.isEmpty) return;
    _flushing = true;
    var sent = false;
    try {
      for (final item in [...state.pending]) {
        try {
          await ref
              .read(authControllerProvider.notifier)
              .withAccess(
                (access) => ref
                    .read(ledgerApiProvider)
                    .record(
                      access,
                      walletId: item.walletId,
                      kind: item.kind,
                      amountMinor: item.amountMinor,
                      note: item.note,
                      clientMutationId: item.mutationId,
                      categoryId: item.categoryId,
                      occurredAt: item.createdAt,
                      outsideTotals: item.outsideTotals,
                    ),
              );
          sent = true;
          await _save(
            OutboxState(
              pending: state.pending
                  .where((p) => p.mutationId != item.mutationId)
                  .toList(),
              failed: state.failed,
            ),
          );
        } on WalletException catch (e) {
          if (e.failure == WalletFailure.offline) break;
          await _save(
            OutboxState(
              pending: state.pending
                  .where((p) => p.mutationId != item.mutationId)
                  .toList(),
              failed: [
                ...state.failed,
                FailedEntry(entry: item, reason: e.failure),
              ],
            ),
          );
        } on AuthException {
          break; // signed out or not allowed: keep it for the next session check
        }
      }
    } finally {
      _flushing = false;
    }
    if (sent) {
      ref
        ..invalidate(ledgerControllerProvider)
        ..invalidate(walletsControllerProvider)
        ..invalidate(categoriesControllerProvider);
    }
  }
}
