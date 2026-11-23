import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../wallets/choices.dart';
import '../wallets/wallet_labels.dart';
import '../wallets/wallet_models.dart';
import '../wallets/wallets_controller.dart';
import 'debt_controller.dart';
import 'debt_models.dart';

/// One debt's installment table: pay, undo a payment, delete the debt.
class DebtScreen extends ConsumerStatefulWidget {
  const DebtScreen({required this.debtId, super.key});

  final String debtId;

  @override
  ConsumerState<DebtScreen> createState() => _DebtScreenState();
}

class _DebtScreenState extends ConsumerState<DebtScreen> {
  String? _error;
  // The installment whose wallet is being chosen, when the debt has none.
  String? _choosing;

  Future<void> _pay(Installment i, {String walletId = ''}) async {
    final l10n = AppLocalizations.of(context);
    try {
      await ref
          .read(debtsControllerProvider.notifier)
          .pay(i.id, walletId: walletId);
      if (mounted) {
        setState(() {
          _error = null;
          _choosing = null;
        });
      }
    } on Exception {
      if (mounted) setState(() => _error = l10n.debtPayFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final debt = ref
        .watch(debtsControllerProvider)
        .value
        ?.where((d) => d.id == widget.debtId)
        .firstOrNull;
    if (debt == null) return const SmBackground(child: SizedBox.shrink());
    final unit = currencyLabel(l10n, debt.currency);
    final wallets = (ref.watch(walletsControllerProvider).value?.active ?? [])
        .where((w) => w.currency == debt.currency)
        .toList();
    return SmBackground(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(SmSpace.screen),
          children: [
            Text(debt.title, style: SmType.title),
            const SizedBox(height: SmSpace.sm),
            Text(
              '${l10n.debtRemaining}: '
              '${formatMinor(debt.remainingMinor, debt.currency)} $unit',
              style: SmType.body,
            ),
            const SizedBox(height: SmSpace.lg),
            for (final i in debt.installments)
              Padding(
                padding: const EdgeInsets.only(bottom: SmSpace.sm),
                child: SmGlassCard(
                  padding: const EdgeInsets.all(SmSpace.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  toPersianDigits(
                                    '${i.number}) '
                                    '${formatMinor(i.amountMinor, debt.currency)} $unit',
                                  ),
                                  style: SmType.body,
                                ),
                                Text(
                                  [
                                    formatJalaliDate(i.dueDate),
                                    if (i.paid) l10n.installmentPaid,
                                    if (i.overdue) l10n.debtOverdue,
                                  ].join(' · '),
                                  style: SmType.caption.copyWith(
                                    color: i.overdue ? SmColors.danger : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _Action(
                            label: i.paid
                                ? l10n.installmentUndo
                                : l10n.installmentPay,
                            color: i.paid ? SmColors.danger : SmColors.accent,
                            onTap: () {
                              if (i.paid) {
                                ref
                                    .read(debtsControllerProvider.notifier)
                                    .unpay(i.id);
                              } else if (debt.walletId.isEmpty) {
                                setState(() => _choosing = i.id);
                              } else {
                                _pay(i);
                              }
                            },
                          ),
                        ],
                      ),
                      if (_choosing == i.id && wallets.isNotEmpty) ...[
                        const SizedBox(height: SmSpace.sm),
                        Text(l10n.debtPayWallet, style: SmType.caption),
                        const SizedBox(height: SmSpace.sm),
                        Choices<Wallet>(
                          values: wallets,
                          selected: wallets.first,
                          label: (w) => w.name,
                          onSelected: (w) => _pay(i, walletId: w.id),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            if (_error != null)
              Text(
                _error!,
                style: SmType.caption.copyWith(color: SmColors.danger),
              ),
            const SizedBox(height: SmSpace.lg),
            SmButton(
              label: l10n.debtDelete,
              onPressed: () async {
                final navigator = Navigator.of(context);
                await ref
                    .read(debtsControllerProvider.notifier)
                    .delete(debt.id);
                navigator.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        child: Text(label, style: SmType.caption.copyWith(color: color)),
      ),
    );
  }
}
