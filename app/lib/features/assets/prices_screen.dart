import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import 'asset_controller.dart';

/// The server's prices (toman per unit). Approximate; never a trade quote.
class PricesScreen extends ConsumerWidget {
  const PricesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final rates = ref.watch(ratesProvider).value ?? const [];
    return SmBackground(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(SmSpace.screen),
          children: [
            Text(l10n.pricesTitle, style: SmType.title),
            const SizedBox(height: SmSpace.lg),
            for (final r in rates)
              Padding(
                padding: const EdgeInsets.only(bottom: SmSpace.sm),
                child: SmGlassCard(
                  padding: const EdgeInsets.all(SmSpace.lg),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(r.name, style: SmType.body),
                            Text(
                              [
                                r.unit,
                                if (r.source.isNotEmpty)
                                  '${l10n.priceSourcePrefix}: ${r.source}',
                                if (r.known && r.stale) l10n.priceStaleSuffix,
                              ].join(' · '),
                              style: SmType.caption,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        r.known
                            ? formatNumber(num.parse(r.price))
                            : l10n.priceUnknown,
                        style: SmType.body.copyWith(
                          color: r.known && r.stale ? SmColors.warning : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
