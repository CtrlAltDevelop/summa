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
import 'wallet_models.dart';

/// Record an expense or income on one of the active wallets.
class EntryFormScreen extends ConsumerStatefulWidget {
  const EntryFormScreen({required this.wallets, super.key});

  final List<Wallet> wallets;

  @override
  ConsumerState<EntryFormScreen> createState() => _EntryFormScreenState();
}

class _EntryFormScreenState extends ConsumerState<EntryFormScreen> {
  final _amount = TextEditingController();
  final _note = TextEditingController();
  // One id per form so a retried save cannot record twice.
  final _mutationId = _newMutationId();
  late Wallet _wallet = widget.wallets.first;
  EntryKind _kind = EntryKind.expense;
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
    final amount = parseMinor(_amount.text, _wallet.currency);
    if (amount == null || amount <= 0) {
      setState(() => _error = l10n.entryAmountInvalid);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref
          .read(ledgerControllerProvider.notifier)
          .record(
            walletId: _wallet.id,
            kind: _kind,
            amountMinor: amount,
            note: _note.text.trim(),
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
            Text(l10n.entryFormTitle, style: SmType.title),
            const SizedBox(height: SmSpace.lg),
            Choices<EntryKind>(
              values: EntryKind.values,
              selected: _kind,
              label: (k) =>
                  k == EntryKind.expense ? l10n.entryExpense : l10n.entryIncome,
              onSelected: (k) => setState(() => _kind = k),
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
              label: l10n.entryAmountLabel,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textDirection: TextDirection.ltr,
              autofocus: true,
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
