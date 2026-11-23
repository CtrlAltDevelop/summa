import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../auth/auth_models.dart';
import '../wallets/choices.dart';
import '../wallets/wallet_models.dart';
import 'asset_controller.dart';
import 'asset_models.dart';

/// Add an asset with its first purchase: pick a listed symbol or a custom one.
class AssetFormScreen extends ConsumerStatefulWidget {
  const AssetFormScreen({super.key});

  @override
  ConsumerState<AssetFormScreen> createState() => _AssetFormScreenState();
}

class _AssetFormScreenState extends ConsumerState<AssetFormScreen> {
  final _name = TextEditingController();
  final _quantity = TextEditingController();
  final _price = TextEditingController();
  final _manual = TextEditingController();
  // One id per form so a retried save cannot create two.
  final _mutationId = _newMutationId();
  RateRow? _symbol; // null: a custom asset
  bool _custom = false;
  bool _saving = false;
  String? _error;

  static String _newMutationId() {
    final random = Random.secure();
    return List.generate(
      16,
      (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
  }

  @override
  void dispose() {
    _name.dispose();
    _quantity.dispose();
    _price.dispose();
    _manual.dispose();
    super.dispose();
  }

  Future<void> _save(List<RateRow> rates) async {
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    final unit = parseMinor(_price.text, baseCurrency);
    final manual = _custom ? parseMinor(_manual.text, baseCurrency) : 0;
    final chosen = _symbol ?? (rates.isEmpty ? null : rates.first);
    final quantity = quantityText(_quantity.text);
    if (!RegExp(r'^\d{1,16}(\.\d{1,8})?$').hasMatch(quantity) ||
        double.parse(quantity) <= 0) {
      setState(() => _error = l10n.assetQuantityInvalid);
      return;
    }
    if (unit == null || unit < 0) {
      setState(() => _error = l10n.assetPriceInvalid);
      return;
    }
    if (_custom &&
        (_name.text.trim().isEmpty || manual == null || manual <= 0)) {
      setState(() => _error = l10n.assetNameInvalid);
      return;
    }
    if (!_custom && chosen == null) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref
          .read(assetsControllerProvider.notifier)
          .create(
            symbol: _custom ? '' : chosen!.symbol,
            name: _custom ? _name.text.trim() : '',
            quantity: quantity,
            unitPriceMinor: unit,
            manualPriceMinor: manual ?? 0,
            clientMutationId: _mutationId,
          );
      if (mounted) navigator.pop();
    } on WalletException catch (e) {
      _fail(
        e.failure == WalletFailure.offline ? l10n.errOffline : l10n.assetFailed,
      );
    } on AuthException {
      _fail(l10n.errUnknown);
    }
  }

  void _fail(String message) {
    if (!mounted) return;
    setState(() {
      _saving = false;
      _error = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final rates = ref.watch(ratesProvider).value ?? const <RateRow>[];
    final chosen = _symbol ?? (rates.isEmpty ? null : rates.first);
    return SmBackground(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(SmSpace.screen),
          children: [
            Text(l10n.assetFormTitle, style: SmType.title),
            const SizedBox(height: SmSpace.lg),
            if (!_custom && chosen != null)
              Choices<RateRow>(
                values: rates,
                selected: chosen,
                label: (r) => r.name,
                onSelected: (r) => setState(() => _symbol = r),
              ),
            const SizedBox(height: SmSpace.sm),
            Choices<bool>(
              values: const [false, true],
              selected: _custom,
              label: (v) => v ? l10n.assetCustom : chosen?.name ?? '',
              onSelected: (v) => setState(() => _custom = v),
            ),
            if (_custom) ...[
              const SizedBox(height: SmSpace.lg),
              SmTextField(controller: _name, label: l10n.assetNameLabel),
              const SizedBox(height: SmSpace.lg),
              SmTextField(
                controller: _manual,
                label: l10n.assetManualPriceLabel,
                keyboardType: TextInputType.number,
                textDirection: TextDirection.ltr,
              ),
            ],
            const SizedBox(height: SmSpace.lg),
            SmTextField(
              controller: _quantity,
              label: l10n.assetQuantityLabel,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textDirection: TextDirection.ltr,
            ),
            const SizedBox(height: SmSpace.lg),
            SmTextField(
              controller: _price,
              label: l10n.assetBuyPriceLabel,
              keyboardType: TextInputType.number,
              textDirection: TextDirection.ltr,
            ),
            if (_error != null) ...[
              const SizedBox(height: SmSpace.md),
              Text(
                _error!,
                style: SmType.caption.copyWith(color: SmColors.danger),
              ),
            ],
            const SizedBox(height: SmSpace.xl),
            SmButton(
              label: l10n.walletSave,
              onPressed: _saving ? null : () => _save(rates),
            ),
          ],
        ),
      ),
    );
  }
}
