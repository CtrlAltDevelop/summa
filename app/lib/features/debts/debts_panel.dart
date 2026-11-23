import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../wallets/wallet_labels.dart';
import '../wallets/wallet_models.dart';
import '../wallets/wallets_controller.dart';
import 'debt_controller.dart';
import 'debt_form_screen.dart';
import 'debt_models.dart';
import 'debt_screen.dart';

/// The debts with what is left and the next installment, and the way to add one.
class DebtsPanel extends ConsumerWidget {
  const DebtsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final debts = ref.watch(debtsControllerProvider).value ?? const <Debt>[];
    final wallets = ref.watch(walletsControllerProvider).value?.active ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final d in debts)
          Padding(
            padding: const EdgeInsets.only(bottom: SmSpace.sm),
            child: _DebtTile(debt: d),
          ),
        SmButton(
          label: l10n.debtAdd,
          secondary: true,
          onPressed: () => Navigator.of(context).push(
            PageRouteBuilder<void>(
              pageBuilder: (_, _, _) => DebtFormScreen(wallets: wallets),
            ),
          ),
        ),
      ],
    );
  }
}

class _DebtTile extends StatelessWidget {
  const _DebtTile({required this.debt});

  final Debt debt;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final unit = currencyLabel(l10n, debt.currency);
    final subtitle = debt.closed
        ? l10n.debtClosed
        : [
            '${l10n.debtRemaining}: '
                '${formatMinor(debt.remainingMinor, debt.currency)} $unit',
            if (debt.nextDue != null)
              '${l10n.debtNextDue}: ${formatJalaliDate(debt.nextDue!)}',
            if (debt.hasOverdue) l10n.debtOverdue,
          ].join(' · ');
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        PageRouteBuilder<void>(
          pageBuilder: (_, _, _) => DebtScreen(debtId: debt.id),
        ),
      ),
      child: SmGlassCard(
        padding: const EdgeInsets.all(SmSpace.lg),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(debt.title, style: SmType.body),
                  Text(
                    subtitle,
                    style: SmType.caption.copyWith(
                      color: debt.hasOverdue ? SmColors.danger : null,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              toPersianDigits('${debt.paidCount}/${debt.count}'),
              style: SmType.body,
            ),
          ],
        ),
      ),
    );
  }
}

/// Used by tests and screens that need a wallet of the debt's currency.
List<Wallet> walletsOfCurrency(List<Wallet> wallets, String currency) =>
    wallets.where((w) => w.currency == currency).toList();
