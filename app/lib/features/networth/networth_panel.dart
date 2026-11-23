import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../wallets/wallet_labels.dart';
import '../wallets/wallet_models.dart';
import 'basket_form_screen.dart';
import 'networth_controller.dart';
import 'networth_models.dart';

/// The big number: net worth in toman, dollars and grams of gold.
class NetWorthCard extends ConsumerWidget {
  const NetWorthCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final worth = ref.watch(netWorthProvider).value;
    if (worth == null) return const SizedBox.shrink();
    final toman = currencyLabel(l10n, 'IRT');
    return SmGlassCard(
      padding: const EdgeInsets.all(SmSpace.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.netWorthTitle, style: SmType.caption),
          Text('${formatNumber(worth.totalMinor)} $toman', style: SmType.title),
          if (worth.usdMinor != null)
            Text(
              '${formatMinor(worth.usdMinor!, 'USD')} ${currencyLabel(l10n, 'USD')}',
              style: SmType.body,
            ),
          if (worth.goldGrams.isNotEmpty)
            Text(
              '${formatQuantity(worth.goldGrams)} ${l10n.netWorthGold}',
              style: SmType.body,
            ),
          const SizedBox(height: SmSpace.sm),
          Text(
            '${l10n.netWorthWallets}: ${formatNumber(worth.walletsMinor)}',
            style: SmType.caption,
          ),
          Text(
            '${l10n.netWorthAssets}: ${formatNumber(worth.assetsMinor)}',
            style: SmType.caption,
          ),
          Text(
            '${l10n.netWorthDebts}: ${formatNumber(worth.debtsMinor)}',
            style: SmType.caption,
          ),
          if (worth.stale)
            Text(
              l10n.netWorthStale,
              style: SmType.caption.copyWith(color: SmColors.warning),
            ),
          if (worth.unconverted.isNotEmpty)
            Text(
              l10n.netWorthUnconverted(worth.unconverted.join('، ')),
              style: SmType.caption.copyWith(color: SmColors.warning),
            ),
          if (worth.unpricedAssets > 0)
            Text(
              l10n.netWorthUnpriced(toPersianDigits('${worth.unpricedAssets}')),
              style: SmType.caption.copyWith(color: SmColors.warning),
            ),
        ],
      ),
    );
  }
}

/// Goal baskets with a progress bar, and the way to add one.
class BasketsPanel extends ConsumerWidget {
  const BasketsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final baskets = ref.watch(basketsProvider).value ?? const <Basket>[];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final b in baskets)
          Padding(
            padding: const EdgeInsets.only(bottom: SmSpace.sm),
            child: _BasketTile(basket: b),
          ),
        SmButton(
          label: l10n.basketAdd,
          onPressed: () => Navigator.of(context).push(
            PageRouteBuilder<void>(
              pageBuilder: (_, _, _) => const BasketFormScreen(),
            ),
          ),
        ),
      ],
    );
  }
}

class _BasketTile extends ConsumerWidget {
  const _BasketTile({required this.basket});

  final Basket basket;

  static const _barHeight = 8.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final b = basket;
    final done = b.percent >= 100;
    return SmGlassCard(
      padding: const EdgeInsets.all(SmSpace.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(b.name, style: SmType.body)),
              Semantics(
                button: true,
                label: l10n.basketDelete,
                child: GestureDetector(
                  onTap: () => deleteBasket(ref, b.id),
                  child: Text(
                    l10n.basketDelete,
                    style: SmType.caption.copyWith(color: SmColors.danger),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: SmSpace.sm),
          DecoratedBox(
            decoration: const BoxDecoration(
              color: SmColors.glassFill,
              borderRadius: SmRadius.pill,
            ),
            child: SizedBox(
              height: _barHeight,
              child: FractionallySizedBox(
                alignment: AlignmentDirectional.centerStart,
                widthFactor: (b.percent / 100).clamp(0.0, 1.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: done ? SmColors.success : SmColors.accent,
                    borderRadius: SmRadius.pill,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: SmSpace.xs),
          Text(
            '${formatNumber(b.valueMinor)} / ${formatNumber(b.targetMinor)} '
            '${currencyLabel(l10n, 'IRT')} · '
            '${l10n.basketProgress(toPersianDigits('${b.percent}'))}',
            style: SmType.caption,
          ),
        ],
      ),
    );
  }
}
