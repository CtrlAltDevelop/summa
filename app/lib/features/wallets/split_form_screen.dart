import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../auth/auth_models.dart';
import '../categories/category_controller.dart';
import '../categories/category_models.dart';
import 'choices.dart';
import 'entry_models.dart';
import 'ledger_controller.dart';
import 'wallet_labels.dart';
import 'wallet_models.dart';

const _minParts = 2;
const _maxParts = 10;

/// One expense shared between categories; a part can sit outside the totals
/// (someone else's share). The wallet is charged the sum of the parts.
class SplitFormScreen extends ConsumerStatefulWidget {
  const SplitFormScreen({required this.wallets, super.key});

  final List<Wallet> wallets;

  @override
  ConsumerState<SplitFormScreen> createState() => _SplitFormScreenState();
}

class _Part {
  final amount = TextEditingController();
  Category? category;
  bool outside = false;
}

class _SplitFormScreenState extends ConsumerState<SplitFormScreen> {
  final _note = TextEditingController();
  final _parts = [_Part(), _Part()];
  // One id per form so a retried save cannot record twice.
  final _mutationId = _newMutationId();
  late Wallet _wallet = widget.wallets.first;
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
    _note.dispose();
    for (final p in _parts) {
      p.amount.dispose();
    }
    super.dispose();
  }

  int? _amountOf(_Part p) => parseMinor(p.amount.text, _wallet.currency);

  int get _total => _parts.fold(0, (sum, p) {
    final a = _amountOf(p);
    return sum + (a != null && a > 0 ? a : 0);
  });

  Future<void> _save(List<Category> categories) async {
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    final amounts = [for (final p in _parts) _amountOf(p)];
    if (amounts.any((a) => a == null || a <= 0)) {
      setState(() => _error = l10n.splitNeedsTwo);
      return;
    }
    final other = categories.where((c) => c.isOther).firstOrNull;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref
          .read(ledgerControllerProvider.notifier)
          .recordSplit(
            walletId: _wallet.id,
            parts: [
              for (var i = 0; i < _parts.length; i++)
                SplitPart(
                  categoryId: (_parts[i].category ?? other)?.id ?? '',
                  amountMinor: amounts[i]!,
                  outsideTotals: _parts[i].outside,
                ),
            ],
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
    final categories = (ref.watch(categoriesControllerProvider).value ?? [])
        .where((c) => c.kind == CategoryKind.expense)
        .toList();
    return SmBackground(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(SmSpace.screen),
          children: [
            Text(l10n.splitTitle, style: SmType.title),
            const SizedBox(height: SmSpace.lg),
            Text(l10n.entryWalletLabel, style: SmType.caption),
            const SizedBox(height: SmSpace.sm),
            Choices<Wallet>(
              values: widget.wallets,
              selected: _wallet,
              label: (w) => w.name,
              onSelected: (w) => setState(() => _wallet = w),
            ),
            for (var i = 0; i < _parts.length; i++) ...[
              const SizedBox(height: SmSpace.xl),
              Text(
                toPersianDigits('${l10n.splitPart} ${i + 1}'),
                style: SmType.caption,
              ),
              const SizedBox(height: SmSpace.sm),
              SmTextField(
                controller: _parts[i].amount,
                label: l10n.entryAmountLabel,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textDirection: TextDirection.ltr,
                onChanged: (_) => setState(() {}),
              ),
              if (categories.isNotEmpty) ...[
                const SizedBox(height: SmSpace.sm),
                Choices<Category>(
                  values: categories,
                  selected: _parts[i].category ?? categories.first,
                  label: (c) => c.name,
                  onSelected: (c) => setState(() => _parts[i].category = c),
                ),
              ],
              const SizedBox(height: SmSpace.sm),
              Choices<bool>(
                values: const [false, true],
                selected: _parts[i].outside,
                label: (v) => v ? l10n.entryOutside : l10n.entryCounted,
                onSelected: (v) => setState(() => _parts[i].outside = v),
              ),
            ],
            const SizedBox(height: SmSpace.lg),
            if (_parts.length < _maxParts)
              SmButton(
                label: l10n.splitAddPart,
                onPressed: () => setState(() => _parts.add(_Part())),
              ),
            const SizedBox(height: SmSpace.lg),
            Text(
              '${l10n.splitTotal}: ${formatMinor(_total, _wallet.currency)} '
              '${currencyLabel(l10n, _wallet.currency)}',
              style: SmType.body,
            ),
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
            SmButton(
              label: l10n.walletSave,
              onPressed: _saving || _parts.length < _minParts
                  ? null
                  : () => _save(categories),
            ),
          ],
        ),
      ),
    );
  }
}
