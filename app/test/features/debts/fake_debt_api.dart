import 'package:summa/features/debts/debt_api.dart';
import 'package:summa/features/debts/debt_models.dart';

/// In-memory [DebtApi]. Tests can add debts directly or create through it.
class FakeDebtApi implements DebtApi {
  final List<Debt> debts = [];
  final List<Map<String, Object?>> created = [];
  final List<Map<String, Object?>> payments = [];
  final List<String> undone = [];
  bool failPay = false;

  @override
  Future<List<Debt>> list(String access) async => List.of(debts);

  @override
  Future<void> create(
    String access, {
    required DebtKind kind,
    required String title,
    required String currency,
    required int installmentMinor,
    required int count,
    required DateTime firstDue,
    required int principalMinor,
    required String walletId,
    required String clientMutationId,
  }) async {
    created.add({
      'kind': kind,
      'title': title,
      'currency': currency,
      'installment': installmentMinor,
      'count': count,
      'firstDue': firstDue,
      'principal': principalMinor,
      'wallet': walletId,
    });
    debts.add(
      Debt(
        id: 'd${debts.length + 1}',
        kind: kind,
        title: title,
        currency: currency,
        installmentMinor: installmentMinor,
        count: count,
        walletId: walletId,
        paidCount: 0,
        remainingMinor: installmentMinor * count,
        nextDue: firstDue,
        closed: false,
        installments: [
          for (var n = 1; n <= count; n++)
            Installment(
              id: 'd${debts.length + 1}-i$n',
              number: n,
              dueDate: DateTime(
                firstDue.year,
                firstDue.month + n - 1,
                firstDue.day,
              ),
              amountMinor: installmentMinor,
              paid: false,
              overdue: false,
            ),
        ],
      ),
    );
  }

  Debt _replace(Debt d, {required String installmentId, required bool paid}) {
    final installments = [
      for (final i in d.installments)
        i.id == installmentId
            ? Installment(
                id: i.id,
                number: i.number,
                dueDate: i.dueDate,
                amountMinor: i.amountMinor,
                paid: paid,
                overdue: false,
              )
            : i,
    ];
    final pending = installments.where((i) => !i.paid).toList();
    return Debt(
      id: d.id,
      kind: d.kind,
      title: d.title,
      currency: d.currency,
      installmentMinor: d.installmentMinor,
      count: d.count,
      walletId: d.walletId,
      paidCount: installments.length - pending.length,
      remainingMinor: pending.fold(0, (s, i) => s + i.amountMinor),
      nextDue: pending.isEmpty ? null : pending.first.dueDate,
      closed: pending.isEmpty,
      installments: installments,
    );
  }

  @override
  Future<void> pay(
    String access,
    String installmentId, {
    String walletId = '',
    int amountMinor = 0,
  }) async {
    if (failPay) throw Exception('refused');
    payments.add({
      'id': installmentId,
      'wallet': walletId,
      'amount': amountMinor,
    });
    final i = debts.indexWhere(
      (d) => d.installments.any((x) => x.id == installmentId),
    );
    debts[i] = _replace(debts[i], installmentId: installmentId, paid: true);
  }

  @override
  Future<void> unpay(String access, String installmentId) async {
    undone.add(installmentId);
    final i = debts.indexWhere(
      (d) => d.installments.any((x) => x.id == installmentId),
    );
    debts[i] = _replace(debts[i], installmentId: installmentId, paid: false);
  }

  @override
  Future<void> delete(String access, String debtId) async =>
      debts.removeWhere((d) => d.id == debtId);
}
