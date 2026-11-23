import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../auth/auth_models.dart';
import 'choices.dart';
import 'wallet_labels.dart';
import 'wallet_models.dart';
import 'wallets_controller.dart';

/// Create a wallet: name, kind, currency, optional bank, opening balance.
class WalletFormScreen extends ConsumerStatefulWidget {
  const WalletFormScreen({super.key});

  @override
  ConsumerState<WalletFormScreen> createState() => _WalletFormScreenState();
}

class _WalletFormScreenState extends ConsumerState<WalletFormScreen> {
  final _name = TextEditingController();
  final _bank = TextEditingController();
  final _balance = TextEditingController();
  // One id per form so a retried save cannot create a second wallet.
  final _mutationId = _newMutationId();
  WalletKind _kind = WalletKind.bank;
  String _currency = baseCurrency;
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
    _bank.dispose();
    _balance.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    final name = _name.text.trim();
    final balance = _balance.text.trim().isEmpty
        ? 0
        : parseMinor(_balance.text, _currency);
    if (name.isEmpty) {
      setState(() => _error = l10n.walletNameRequired);
      return;
    }
    if (balance == null || (balance < 0 && !_kind.allowsDebt)) {
      setState(() => _error = l10n.walletBalanceInvalid);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref
          .read(walletsControllerProvider.notifier)
          .create(
            name: name,
            kind: _kind,
            currency: _currency,
            bank: _bank.text.trim(),
            openingBalanceMinor: balance,
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
    return SmBackground(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(SmSpace.screen),
          children: [
            Text(l10n.walletFormTitle, style: SmType.title),
            const SizedBox(height: SmSpace.lg),
            SmTextField(
              controller: _name,
              label: l10n.walletNameLabel,
              autofocus: true,
            ),
            const SizedBox(height: SmSpace.lg),
            Text(l10n.walletKindLabel, style: SmType.caption),
            const SizedBox(height: SmSpace.sm),
            Choices<WalletKind>(
              values: WalletKind.values,
              selected: _kind,
              label: (k) => walletKindLabel(l10n, k),
              onSelected: (k) => setState(() => _kind = k),
            ),
            const SizedBox(height: SmSpace.lg),
            Text(l10n.walletCurrencyLabel, style: SmType.caption),
            const SizedBox(height: SmSpace.sm),
            Choices<String>(
              values: currencyDecimals.keys.toList(),
              selected: _currency,
              label: (c) => currencyLabel(l10n, c),
              onSelected: (c) => setState(() => _currency = c),
            ),
            const SizedBox(height: SmSpace.lg),
            SmTextField(controller: _bank, label: l10n.walletBankLabel),
            const SizedBox(height: SmSpace.lg),
            SmTextField(
              controller: _balance,
              label: l10n.walletOpeningLabel,
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
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
            SmButton(label: l10n.walletSave, onPressed: _saving ? null : _save),
          ],
        ),
      ),
    );
  }
}
