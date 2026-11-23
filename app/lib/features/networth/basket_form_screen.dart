import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../assets/asset_controller.dart';
import '../auth/auth_models.dart';
import '../wallets/choices.dart';
import '../wallets/wallet_models.dart';
import '../wallets/wallets_controller.dart';
import 'networth_controller.dart';
import 'networth_models.dart';

/// Create a goal: a name, a target in toman, and what counts toward it.
class BasketFormScreen extends ConsumerStatefulWidget {
  const BasketFormScreen({super.key});

  @override
  ConsumerState<BasketFormScreen> createState() => _BasketFormScreenState();
}

class _BasketFormScreenState extends ConsumerState<BasketFormScreen> {
  final _name = TextEditingController();
  final _target = TextEditingController();
  // One id per form so a retried save cannot create two.
  final _mutationId = _newMutationId();
  final Set<BasketItemRef> _picked = {};
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
    _target.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    final target = parseMinor(_target.text, baseCurrency);
    if (_name.text.trim().isEmpty) {
      setState(() => _error = l10n.walletNameRequired);
      return;
    }
    if (target == null || target <= 0) {
      setState(() => _error = l10n.basketTargetInvalid);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await createBasket(
        ref,
        name: _name.text.trim(),
        targetMinor: target,
        items: _picked.toList(),
        clientMutationId: _mutationId,
      );
      if (mounted) navigator.pop();
    } on WalletException catch (e) {
      _fail(
        e.failure == WalletFailure.offline ? l10n.errOffline : l10n.errUnknown,
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
    final wallets = ref.watch(walletsControllerProvider).value?.active ?? [];
    final assets = ref.watch(assetsControllerProvider).value?.assets ?? [];
    final names = {
      for (final w in wallets) BasketItemRef('wallet', w.id): w.name,
      for (final a in assets) BasketItemRef('asset', a.id): a.name,
    };
    return SmBackground(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(SmSpace.screen),
          children: [
            Text(l10n.basketFormTitle, style: SmType.title),
            const SizedBox(height: SmSpace.lg),
            SmTextField(controller: _name, label: l10n.basketNameLabel),
            const SizedBox(height: SmSpace.lg),
            SmTextField(
              controller: _target,
              label: l10n.basketTargetLabel,
              keyboardType: TextInputType.number,
              textDirection: TextDirection.ltr,
            ),
            if (names.isNotEmpty) ...[
              const SizedBox(height: SmSpace.lg),
              Text(l10n.basketItemsLabel, style: SmType.caption),
              const SizedBox(height: SmSpace.sm),
              MultiChoices<BasketItemRef>(
                values: names.keys.toList(),
                selected: _picked,
                label: (r) => names[r]!,
                onToggle: (r) => setState(() {
                  if (!_picked.remove(r)) _picked.add(r);
                }),
              ),
            ],
            if (_error != null) ...[
              const SizedBox(height: SmSpace.md),
              Text(
                _error!,
                style: SmType.caption.copyWith(color: SmColors.danger),
              ),
            ],
            const SizedBox(height: SmSpace.xl),
            SmButton(label: l10n.walletSave, onPressed: _saving ? null : _save),
          ],
        ),
      ),
    );
  }
}
