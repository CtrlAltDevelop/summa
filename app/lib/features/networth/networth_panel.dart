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

/// The hero: net worth as one big animated number, the dollar and gold
/// equivalents as chips, and a bar showing what it is made of.
class NetWorthCard extends ConsumerWidget {
  const NetWorthCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final worth = ref.watch(netWorthProvider).value;
    if (worth == null) return const SizedBox.shrink();
    final toman = currencyLabel(l10n, 'IRT');
    final warnings = [
      if (worth.stale) l10n.netWorthStale,
      if (worth.unconverted.isNotEmpty)
        l10n.netWorthUnconverted(worth.unconverted.join('، ')),
      if (worth.unpricedAssets > 0)
        l10n.netWorthUnpriced(toPersianDigits('${worth.unpricedAssets}')),
    ];
    return SmGlassCard(
      strong: true,
      padding: const EdgeInsets.all(SmSpace.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.netWorthTitle, style: SmType.caption),
          const SizedBox(height: SmSpace.xs),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            spacing: SmSpace.sm,
            children: [
              SmCountUp(
                value: worth.totalMinor,
                format: (v) => formatNumber(v.round()),
                style: SmType.hero,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: SmSpace.sm),
                child: Text(toman, style: SmType.title),
              ),
            ],
          ),
          const SizedBox(height: SmSpace.md),
          Wrap(
            spacing: SmSpace.sm,
            runSpacing: SmSpace.sm,
            children: [
              if (worth.usdMinor != null)
                SmChip(
                  '${formatMinor(worth.usdMinor!, 'USD')} '
                  '${currencyLabel(l10n, 'USD')}',
                ),
              if (worth.goldGrams.isNotEmpty)
                SmChip(
                  '${formatQuantity(worth.goldGrams)} ${l10n.netWorthGold}',
                ),
            ],
          ),
          const SizedBox(height: SmSpace.xl),
          const _HistoryChart(),
          const SizedBox(height: SmSpace.xl),
          _CompositionBar(
            parts: [
              _Part(l10n.netWorthWallets, worth.walletsMinor, SmColors.accent),
              _Part(l10n.netWorthAssets, worth.assetsMinor, SmColors.success),
              _Part(l10n.netWorthDebts, worth.debtsMinor, SmColors.danger),
            ],
          ),
          for (final w in warnings) ...[
            const SizedBox(height: SmSpace.sm),
            Text(w, style: SmType.caption.copyWith(color: SmColors.warning)),
          ],
        ],
      ),
    );
  }
}

class _Part {
  const _Part(this.label, this.minor, this.color);

  final String label;
  final int minor;
  final Color color;
}

/// A segmented bar (grows in on first show) with a legend under it.
class _CompositionBar extends StatelessWidget {
  const _CompositionBar({required this.parts});

  final List<_Part> parts;

  static const double _height = 10;
  static const int _minFlex = 1;

  @override
  Widget build(BuildContext context) {
    final shown = parts.where((p) => p.minor > 0).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (shown.isNotEmpty)
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: SmMotion.of(context, SmMotion.slow),
            curve: SmMotion.emphasis,
            builder: (context, t, _) => ClipRRect(
              borderRadius: SmRadius.pill,
              child: FractionallySizedBox(
                alignment: AlignmentDirectional.centerStart,
                widthFactor: t,
                child: Row(
                  children: [
                    for (final p in shown)
                      Expanded(
                        flex: p.minor < _minFlex ? _minFlex : p.minor,
                        child: SizedBox(
                          height: _height,
                          child: ColoredBox(color: p.color),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        const SizedBox(height: SmSpace.md),
        Wrap(
          spacing: SmSpace.xl,
          runSpacing: SmSpace.sm,
          children: [for (final p in parts) _Legend(part: p)],
        ),
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.part});

  final _Part part;

  static const double _dot = 8;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(color: part.color, shape: BoxShape.circle),
          child: const SizedBox(width: _dot, height: _dot),
        ),
        const SizedBox(width: SmSpace.sm),
        Text(
          '${part.label}: ${formatNumber(part.minor)}',
          style: SmType.caption,
        ),
      ],
    );
  }
}

const _rangeDays = [7, 30, 90];

/// The net-worth line with a 7 / 30 / 90 day switch.
class _HistoryChart extends ConsumerStatefulWidget {
  const _HistoryChart();

  @override
  ConsumerState<_HistoryChart> createState() => _HistoryChartState();
}

class _HistoryChartState extends ConsumerState<_HistoryChart> {
  int _days = _rangeDays[1];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final points = ref.watch(netWorthHistoryProvider(_days)).value ?? const [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: SmSpace.sm,
          children: [
            for (final d in _rangeDays)
              GestureDetector(
                onTap: () => setState(() => _days = d),
                child: SmChip(
                  l10n.netWorthRange(toPersianDigits('$d')),
                  selected: d == _days,
                ),
              ),
          ],
        ),
        const SizedBox(height: SmSpace.md),
        if (points.length < 2)
          Text(l10n.netWorthHistoryEmpty, style: SmType.caption)
        else
          SmLineChart(
            values: [for (final p in points) p.totalMinor.toDouble()],
            label: (i) =>
                '${formatNumber(points[i].totalMinor)} · '
                '${formatJalaliDate(points[i].day)}',
          ),
      ],
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
