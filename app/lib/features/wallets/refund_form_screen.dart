import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../auth/auth_models.dart';
import 'choices.dart';
import 'entry_models.dart';
import 'ledger_controller.dart';
import 'wallet_labels.dart';
import 'wallet_models.dart';

/// Give money back for an expense: all of what is left (amount empty) or part,
/// to the expense's own wallet or another of the same currency.
class RefundFormScreen extends ConsumerStatefulWidget {
  const RefundFormScreen({
    required this.entry,
    required this.wallets,
    super.key,
  });

  final Entry entry;

  /// Active wallets of the expense's currency.
  final List<Wallet> wallets;

  @override
  ConsumerState<RefundFormScreen> createState() => _RefundFormScreenState();
}

class _RefundFormScreenState extends ConsumerState<RefundFormScreen> {
  final _amount = TextEditingController();
  final _note = TextEditingController();
  // One id per form so a retried save cannot refund twice.
  final _mutationId = _newMutationId();
  late Wallet _wallet = widget.wallets.firstWhere(
    (w) => w.id == widget.entry.walletId,
    orElse: () => widget.wallets.first,
  );
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
    _amount.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    final entry = widget.entry;
    final typed = _amount.text.trim();
    final amount = typed.isEmpty ? 0 : parseMinor(typed, entry.currency);
    if (amount == null || amount < 0 || amount > entry.refundableMinor) {
      setState(() => _error = l10n.refundInvalid);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref
          .read(ledgerControllerProvider.notifier)
          .refund(
            entryId: entry.id,
            walletId: _wallet.id,
            amountMinor: amount,
            note: _note.text.trim(),
            clientMutationId: _mutationId,
          );
      if (mounted) navigator.pop();
    } on WalletException catch (e) {
      _fail(
        e.failure == WalletFailure.offline
            ? l10n.errOffline
            : l10n.refundInvalid,
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
    final entry = widget.entry;
    return SmScreen(
      title: l10n.refundTitle,
      children: [
        Text(
          '${l10n.refundRemaining}: '
          '${formatMinor(entry.refundableMinor, entry.currency)} '
          '${currencyLabel(l10n, entry.currency)}',
          style: SmType.caption,
        ),
        const SizedBox(height: SmSpace.lg),
        Text(l10n.entryWalletLabel, style: SmType.caption),
        const SizedBox(height: SmSpace.sm),
        Choices<Wallet>(
          values: widget.wallets,
          selected: _wallet,
          label: (w) => w.name,
          onSelected: (w) => setState(() => _wallet = w),
        ),
        const SizedBox(height: SmSpace.lg),
        SmTextField(
          controller: _amount,
          label: l10n.refundAmountLabel,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
          Text(_error!, style: SmType.caption.copyWith(color: SmColors.danger)),
        ],
        const SizedBox(height: SmSpace.xl),
        SmButton(label: l10n.walletSave, onPressed: _saving ? null : _save),
      ],
    );
  }
}
