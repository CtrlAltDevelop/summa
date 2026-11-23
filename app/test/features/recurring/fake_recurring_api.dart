import 'package:summa/features/recurring/recurring_api.dart';
import 'package:summa/features/recurring/recurring_models.dart';

/// In-memory [RecurringApi]. Tests put cycles in [occurrences] directly.
class FakeRecurringApi implements RecurringApi {
  final List<Recurring> recurrings = [];
  final List<Occurrence> occurrences = [];
  final List<Map<String, Object?>> created = [];
  final List<Map<String, Object?>> answers = [];

  @override
  Future<RecurringState> list(String access) async => RecurringState(
    recurrings: List.of(recurrings),
    occurrences: List.of(occurrences),
  );

  @override
  Future<void> create(
    String access, {
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
    created.add({
      'category': categoryId,
      'wallet': walletId,
      'kind': kind,
      'amount': amountMinor,
      'note': note,
      'period': period,
      'day': day,
      'auto': autoConfirm,
    });
    recurrings.add(
      Recurring(
        id: 'r${recurrings.length + 1}',
        walletId: walletId,
        kind: kind,
        amountMinor: amountMinor,
        currency: 'IRT',
        note: note,
        period: period,
        day: day,
        autoConfirm: autoConfirm,
        active: true,
        nextDue: DateTime.utc(2026, 12, 6),
      ),
    );
  }

  final List<(String, int)> settled = [];

  @override
  Future<void> settleNow(
    String access,
    String recurringId, {
    int amountMinor = 0,
  }) async => settled.add((recurringId, amountMinor));

  @override
  Future<void> setActive(
    String access,
    String id, {
    required bool active,
  }) async {
    final i = recurrings.indexWhere((r) => r.id == id);
    final r = recurrings[i];
    recurrings[i] = Recurring(
      id: r.id,
      walletId: r.walletId,
      kind: r.kind,
      amountMinor: r.amountMinor,
      currency: r.currency,
      note: r.note,
      period: r.period,
      day: r.day,
      autoConfirm: r.autoConfirm,
      active: active,
      nextDue: r.nextDue,
    );
  }

  @override
  Future<void> delete(String access, String id) async =>
      recurrings.removeWhere((r) => r.id == id);

  @override
  Future<void> resolve(
    String access, {
    required String occurrenceId,
    required String action,
    String walletId = '',
    int amountMinor = 0,
  }) async {
    answers.add({
      'id': occurrenceId,
      'action': action,
      'wallet': walletId,
      'amount': amountMinor,
    });
    occurrences.removeWhere((o) => o.id == occurrenceId);
  }
}
