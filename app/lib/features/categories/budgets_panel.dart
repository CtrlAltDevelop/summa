import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../wallets/wallet_labels.dart';
import '../wallets/wallet_models.dart';
import 'categories_screen.dart';
import 'category_controller.dart';
import 'category_models.dart';

/// This month's budget bars (warning from 80%, red at 100%) and the way to
/// the categories screen.
class BudgetsPanel extends ConsumerWidget {
  const BudgetsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final rows = ref.watch(budgetsProvider).value ?? const <BudgetRow>[];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (rows.isNotEmpty) ...[
          SmGlassCard(
            padding: const EdgeInsets.all(SmSpace.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.budgetsTitle, style: SmType.caption),
                for (final row in rows) _BudgetBar(row: row),
              ],
            ),
          ),
          const SizedBox(height: SmSpace.md),
        ],
        SmButton(
          label: l10n.categoriesOpen,
          secondary: true,
          onPressed: () => Navigator.of(context).push(
            PageRouteBuilder<void>(
              pageBuilder: (_, _, _) => const CategoriesScreen(),
            ),
          ),
        ),
      ],
    );
  }
}

class _BudgetBar extends StatelessWidget {
  const _BudgetBar({required this.row});

  final BudgetRow row;

  static const _barHeight = 8.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final color = switch (row.level) {
      BudgetLevel.ok => SmColors.accent,
      BudgetLevel.warning => SmColors.warning,
      BudgetLevel.over => SmColors.danger,
    };
    final unit = currencyLabel(l10n, row.currency);
    return Padding(
      padding: const EdgeInsets.only(top: SmSpace.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(row.categoryName, style: SmType.body),
          const SizedBox(height: SmSpace.xs),
          Semantics(
            label:
                '${formatMinor(row.spentMinor, row.currency)} / '
                '${formatMinor(row.limitMinor, row.currency)}',
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: SmColors.glassFill,
                borderRadius: SmRadius.pill,
              ),
              child: SizedBox(
                height: _barHeight,
                child: FractionallySizedBox(
                  alignment: AlignmentDirectional.centerStart,
                  widthFactor: row.ratio.clamp(0.0, 1.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: SmRadius.pill,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: SmSpace.xs),
          Text(
            '${formatMinor(row.spentMinor, row.currency)} / '
            '${formatMinor(row.limitMinor, row.currency)} $unit'
            '${row.level == BudgetLevel.over
                ? ' · ${l10n.budgetOver}'
                : row.level == BudgetLevel.warning
                ? ' · ${l10n.budgetWarning}'
                : ''}',
            style: SmType.caption,
          ),
        ],
      ),
    );
  }
}
