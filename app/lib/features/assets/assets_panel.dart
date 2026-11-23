import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../wallets/wallet_labels.dart';
import 'asset_controller.dart';
import 'asset_form_screen.dart';
import 'asset_models.dart';
import 'asset_screen.dart';
import 'prices_screen.dart';

/// Holdings with today's value and profit, and the way to add one or see prices.
class AssetsPanel extends ConsumerWidget {
  const AssetsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final list = ref.watch(assetsControllerProvider).value ?? AssetList.empty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (list.assets.isNotEmpty) ...[
          SmGlassCard(
            padding: const EdgeInsets.all(SmSpace.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.assetsValue, style: SmType.caption),
                Text(
                  '${formatNumber(list.valueMinor)} ${currencyLabel(l10n, 'IRT')}',
                  style: SmType.title,
                ),
                Text(
                  '${l10n.assetsProfit}: ${formatNumber(list.profitMinor)}',
                  style: SmType.caption.copyWith(
                    color: list.profitMinor < 0
                        ? SmColors.danger
                        : SmColors.success,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: SmSpace.md),
          for (final a in list.assets)
            Padding(
              padding: const EdgeInsets.only(bottom: SmSpace.sm),
              child: _AssetTile(asset: a),
            ),
        ],
        SmButton(
          label: l10n.assetAdd,
          secondary: true,
          onPressed: () => Navigator.of(context).push(
            PageRouteBuilder<void>(
              pageBuilder: (_, _, _) => const AssetFormScreen(),
            ),
          ),
        ),
        const SizedBox(height: SmSpace.sm),
        SmButton(
          label: l10n.pricesOpen,
          secondary: true,
          onPressed: () => Navigator.of(context).push(
            PageRouteBuilder<void>(
              pageBuilder: (_, _, _) => const PricesScreen(),
            ),
          ),
        ),
      ],
    );
  }
}

class _AssetTile extends StatelessWidget {
  const _AssetTile({required this.asset});

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final a = asset;
    final value = a.priceKnown
        ? '${formatNumber(a.valueMinor)} ${currencyLabel(l10n, 'IRT')}'
        : l10n.priceUnknown;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        PageRouteBuilder<void>(
          pageBuilder: (_, _, _) => AssetScreen(assetId: a.id),
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
                  Text(a.name, style: SmType.body),
                  Text(
                    [
                      '${formatQuantity(a.quantity)} ${a.unit}'.trim(),
                      if (a.stale) l10n.assetStale,
                    ].join(' · '),
                    style: SmType.caption,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(value, style: SmType.body),
                if (a.priceKnown)
                  Text(
                    formatNumber(a.profitMinor),
                    style: SmType.caption.copyWith(
                      color: a.profitMinor < 0
                          ? SmColors.danger
                          : SmColors.success,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
