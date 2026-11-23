import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../wallets/choices.dart';
import '../wallets/wallet_labels.dart';
import '../wallets/wallet_models.dart';
import 'category_controller.dart';
import 'category_models.dart';

/// Set (or, with zero, remove) the monthly limit of one expense category.
class BudgetFormScreen extends ConsumerStatefulWidget {
  const BudgetFormScreen({required this.category, super.key});

  final Category category;

  @override
  ConsumerState<BudgetFormScreen> createState() => _BudgetFormScreenState();
}

class _BudgetFormScreenState extends ConsumerState<BudgetFormScreen> {
  final _limit = TextEditingController();
  String _currency = baseCurrency;
  String? _error;
  bool _saving = false;

  @override
  void dispose() {
    _limit.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    final limit = parseMinor(_limit.text, _currency);
    if (limit == null || limit < 0) {
      setState(() => _error = l10n.entryAmountInvalid);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref
          .read(categoriesControllerProvider.notifier)
          .setBudget(widget.category.id, _currency, limit);
      if (mounted) navigator.pop();
    } on Exception {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _error = l10n.errUnknown;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SmScreen(
      title: '${l10n.budgetFormTitle} · ${widget.category.name}',
      children: [
        Text(l10n.budgetCurrencyLabel, style: SmType.caption),
        const SizedBox(height: SmSpace.sm),
        Choices<String>(
          values: currencyDecimals.keys.toList(),
          selected: _currency,
          label: (c) => currencyLabel(l10n, c),
          onSelected: (c) => setState(() => _currency = c),
        ),
        const SizedBox(height: SmSpace.lg),
        SmTextField(
          controller: _limit,
          label: l10n.budgetLimitLabel,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textDirection: TextDirection.ltr,
          autofocus: true,
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
