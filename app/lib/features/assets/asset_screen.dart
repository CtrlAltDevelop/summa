import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../wallets/wallet_models.dart';
import 'asset_controller.dart';

/// One asset: its value and profit, buy more, sell, delete.
class AssetScreen extends ConsumerStatefulWidget {
  const AssetScreen({required this.assetId, super.key});

  final String assetId;

  @override
  ConsumerState<AssetScreen> createState() => _AssetScreenState();
}

class _AssetScreenState extends ConsumerState<AssetScreen> {
  final _quantity = TextEditingController();
  final _price = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _quantity.dispose();
    _price.dispose();
    super.dispose();
  }

  /// Validates the two fields and runs [action] with them.
  Future<void> _submit(
    Future<void> Function(String quantity, int price) action,
  ) async {
    final l10n = AppLocalizations.of(context);
    final quantity = quantityText(_quantity.text);
    final price = parseMinor(_price.text, baseCurrency);
    if (!RegExp(r'^\d{1,16}(\.\d{1,8})?$').hasMatch(quantity) ||
        double.parse(quantity) <= 0) {
      setState(() => _error = l10n.assetQuantityInvalid);
      return;
    }
    if (price == null || price < 0) {
      setState(() => _error = l10n.assetPriceInvalid);
      return;
    }
    try {
      await action(quantity, price);
      if (mounted) {
        setState(() => _error = null);
        _quantity.clear();
        _price.clear();
      }
    } on Exception {
      if (mounted) setState(() => _error = l10n.assetFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.read(assetsControllerProvider.notifier);
    final asset = ref
        .watch(assetsControllerProvider)
        .value
        ?.assets
        .where((a) => a.id == widget.assetId)
        .firstOrNull;
    if (asset == null) return const SmBackground(child: SizedBox.shrink());
    return SmScreen(
      title: asset.name,
      children: [
        Text(
          '${l10n.assetHeld}: ${formatQuantity(asset.quantity)} ${asset.unit}',
          style: SmType.body,
        ),
        if (asset.priceKnown) ...[
          Text(
            '${l10n.assetsValue}: ${formatNumber(asset.valueMinor)}',
            style: SmType.body,
          ),
          Text(
            '${l10n.assetCost}: ${formatNumber(asset.costMinor)}',
            style: SmType.caption,
          ),
          Text(
            '${l10n.assetsProfit}: ${formatNumber(asset.profitMinor)}',
            style: SmType.caption.copyWith(
              color: asset.profitMinor < 0 ? SmColors.danger : SmColors.success,
            ),
          ),
        ] else
          Text(l10n.assetUnknownPrice, style: SmType.caption),
        Text(
          '${l10n.assetsRealized}: ${formatNumber(asset.realizedMinor)}',
          style: SmType.caption,
        ),
        const SizedBox(height: SmSpace.xl),
        SmTextField(
          controller: _quantity,
          label: l10n.assetQuantityLabel,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textDirection: TextDirection.ltr,
        ),
        const SizedBox(height: SmSpace.md),
        SmTextField(
          controller: _price,
          label: l10n.assetSellPriceLabel,
          keyboardType: TextInputType.number,
          textDirection: TextDirection.ltr,
        ),
        if (_error != null) ...[
          const SizedBox(height: SmSpace.md),
          Text(_error!, style: SmType.caption.copyWith(color: SmColors.danger)),
        ],
        const SizedBox(height: SmSpace.lg),
        SmButton(
          label: l10n.assetBuyMore,
          onPressed: () => _submit(
            (q, p) =>
                controller.addLot(asset.id, quantity: q, unitPriceMinor: p),
          ),
        ),
        const SizedBox(height: SmSpace.sm),
        SmButton(
          label: l10n.assetSell,
          onPressed: () => _submit(
            (q, p) => controller.sell(asset.id, quantity: q, unitPriceMinor: p),
          ),
        ),
        const SizedBox(height: SmSpace.sm),
        SmButton(
          label: l10n.assetDelete,
          onPressed: () async {
            final navigator = Navigator.of(context);
            await controller.delete(asset.id);
            navigator.pop();
          },
        ),
      ],
    );
  }
}
