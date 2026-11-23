import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../auth/auth_models.dart';
import 'choices.dart';
import 'ledger_controller.dart';
import 'wallet_models.dart';

/// Move money between two of the user's wallets, with an optional fee and,
/// across currencies, the rate the user types.
class TransferFormScreen extends ConsumerStatefulWidget {
  const TransferFormScreen({required this.wallets, super.key});

  final List<Wallet> wallets;

  @override
  ConsumerState<TransferFormScreen> createState() => _TransferFormScreenState();
}

class _TransferFormScreenState extends ConsumerState<TransferFormScreen> {
  final _amount = TextEditingController();
  final _rate = TextEditingController();
  final _fee = TextEditingController();
  final _note = TextEditingController();
  // One id per form so a retried save cannot transfer twice.
  final _mutationId = _newMutationId();
  late Wallet _from = widget.wallets.first;
  late Wallet _to = widget.wallets[1];
  bool _saving = false;
  String? _error;

  bool get _crossCurrency => _from.currency != _to.currency;

  static String _newMutationId() {
    final random = Random.secure();
    return List.generate(
      16,
      (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
  }

  @override
  void dispose() {
    _amount.dispose();
    _rate.dispose();
    _fee.dispose();
    _note.dispose();
    super.dispose();
  }

  /// The rate as the server wants it: Latin digits, `.` as the decimal mark.
  String get _rateText =>
      toLatinDigits(_rate.text.trim())
          .replaceAll('٫', '.')
          .replaceAll(',', '.');

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    final amount = parseMinor(_amount.text, _from.currency);
    final fee = _fee.text.trim().isEmpty
        ? 0
        : parseMinor(_fee.text, _from.currency);
    if (_from.id == _to.id) {
      return setState(() => _error = l10n.transferSameWallet);
    }
    if (amount == null || amount <= 0) {
      return setState(() => _error = l10n.entryAmountInvalid);
    }
    if (fee == null || fee < 0) {
      return setState(() => _error = l10n.transferFeeInvalid);
    }
    if (_crossCurrency && _rateText.isEmpty) {
      return setState(() => _error = l10n.transferRateInvalid);
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref
          .read(ledgerControllerProvider.notifier)
          .transfer(
            fromWalletId: _from.id,
            toWalletId: _to.id,
            amountMinor: amount,
            rate: _crossCurrency ? _rateText : '',
            feeMinor: fee,
            note: _note.text.trim(),
            clientMutationId: _mutationId,
          );
      if (mounted) navigator.pop();
    } on WalletException catch (e) {
      _fail(switch (e.failure) {
        WalletFailure.offline => l10n.errOffline,
        WalletFailure.invalid => l10n.transferRateInvalid,
        _ => l10n.errUnknown,
      });
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
            Text(l10n.transferFormTitle, style: SmType.title),
            const SizedBox(height: SmSpace.lg),
            Text(l10n.transferFrom, style: SmType.caption),
            const SizedBox(height: SmSpace.sm),
            Choices<Wallet>(
              values: widget.wallets,
              selected: _from,
              label: (w) => w.name,
              onSelected: (w) => setState(() => _from = w),
            ),
            const SizedBox(height: SmSpace.lg),
            Text(l10n.transferTo, style: SmType.caption),
            const SizedBox(height: SmSpace.sm),
            Choices<Wallet>(
              values: widget.wallets,
              selected: _to,
              label: (w) => w.name,
              onSelected: (w) => setState(() => _to = w),
            ),
            const SizedBox(height: SmSpace.lg),
            SmTextField(
              controller: _amount,
              label: l10n.entryAmountLabel,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textDirection: TextDirection.ltr,
            ),
            if (_crossCurrency) ...[
              const SizedBox(height: SmSpace.lg),
              SmTextField(
                controller: _rate,
                label: l10n.transferRateLabel,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textDirection: TextDirection.ltr,
              ),
            ],
            const SizedBox(height: SmSpace.lg),
            SmTextField(
              controller: _fee,
              label: l10n.transferFeeLabel,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textDirection: TextDirection.ltr,
            ),
            const SizedBox(height: SmSpace.lg),
            SmTextField(
              controller: _note,
              label: l10n.entryNoteLabel,
              maxLength: 200,
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
