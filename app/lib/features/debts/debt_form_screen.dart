import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../auth/auth_models.dart';
import '../wallets/choices.dart';
import '../wallets/wallet_labels.dart';
import '../wallets/wallet_models.dart';
import 'debt_controller.dart';
import 'debt_models.dart';

const _maxInstallments = 120;

/// Define a loan, an installment purchase or a personal debt.
class DebtFormScreen extends ConsumerStatefulWidget {
  const DebtFormScreen({required this.wallets, super.key});

  final List<Wallet> wallets;

  @override
  ConsumerState<DebtFormScreen> createState() => _DebtFormScreenState();
}

class _DebtFormScreenState extends ConsumerState<DebtFormScreen> {
  final _title = TextEditingController();
  final _installment = TextEditingController();
  final _count = TextEditingController();
  final _firstDue = TextEditingController();
  final _principal = TextEditingController();
  // One id per form so a retried save cannot create two.
  final _mutationId = _newMutationId();
  DebtKind _kind = DebtKind.bankLoan;
  String _currency = baseCurrency;
  Wallet? _wallet;
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
    _title.dispose();
    _installment.dispose();
    _count.dispose();
    _firstDue.dispose();
    _principal.dispose();
    super.dispose();
  }

  List<Wallet> get _walletsOfCurrency =>
      widget.wallets.where((w) => w.currency == _currency).toList();

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    final installment = parseMinor(_installment.text, _currency);
    final count = int.tryParse(toLatinDigits(_count.text.trim()));
    final first = parseJalaliDate(_firstDue.text);
    final principal = _principal.text.trim().isEmpty
        ? 0
        : parseMinor(_principal.text, _currency);
    if (_title.text.trim().isEmpty) {
      setState(() => _error = l10n.walletNameRequired);
      return;
    }
    if (installment == null || installment <= 0 || principal == null) {
      setState(() => _error = l10n.entryAmountInvalid);
      return;
    }
    if (count == null || count < 1 || count > _maxInstallments) {
      setState(() => _error = l10n.debtCountInvalid);
      return;
    }
    if (first == null) {
      setState(() => _error = l10n.debtDateInvalid);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    final wallet = _walletsOfCurrency.where((w) => w.id == _wallet?.id);
    try {
      await ref
          .read(debtsControllerProvider.notifier)
          .create(
            kind: _kind,
            title: _title.text.trim(),
            currency: _currency,
            installmentMinor: installment,
            count: count,
            firstDue: first,
            principalMinor: principal,
            walletId: wallet.firstOrNull?.id ?? '',
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
    final wallets = _walletsOfCurrency;
    return SmBackground(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(SmSpace.screen),
          children: [
            Text(l10n.debtFormTitle, style: SmType.title),
            const SizedBox(height: SmSpace.lg),
            Choices<DebtKind>(
              values: DebtKind.values,
              selected: _kind,
              label: (k) => switch (k) {
                DebtKind.bankLoan => l10n.debtKindLoan,
                DebtKind.installmentPurchase => l10n.debtKindPurchase,
                DebtKind.personal => l10n.debtKindPersonal,
              },
              onSelected: (k) => setState(() => _kind = k),
            ),
            const SizedBox(height: SmSpace.lg),
            SmTextField(controller: _title, label: l10n.debtTitleLabel),
            const SizedBox(height: SmSpace.lg),
            Text(l10n.walletCurrencyLabel, style: SmType.caption),
            const SizedBox(height: SmSpace.sm),
            Choices<String>(
              values: currencyDecimals.keys.toList(),
              selected: _currency,
              label: (c) => currencyLabel(l10n, c),
              onSelected: (c) => setState(() {
                _currency = c;
                _wallet = null;
              }),
            ),
            const SizedBox(height: SmSpace.lg),
            SmTextField(
              controller: _installment,
              label: l10n.debtInstallmentLabel,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textDirection: TextDirection.ltr,
            ),
            const SizedBox(height: SmSpace.lg),
            SmTextField(
              controller: _count,
              label: l10n.debtCountLabel,
              keyboardType: TextInputType.number,
              textDirection: TextDirection.ltr,
            ),
            const SizedBox(height: SmSpace.lg),
            SmTextField(
              controller: _firstDue,
              label: l10n.debtFirstDueLabel,
              keyboardType: TextInputType.datetime,
              textDirection: TextDirection.ltr,
            ),
            const SizedBox(height: SmSpace.lg),
            SmTextField(
              controller: _principal,
              label: l10n.debtPrincipalLabel,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textDirection: TextDirection.ltr,
            ),
            if (wallets.isNotEmpty) ...[
              const SizedBox(height: SmSpace.lg),
              Text(l10n.debtWalletLabel, style: SmType.caption),
              const SizedBox(height: SmSpace.sm),
              Choices<Wallet?>(
                values: [null, ...wallets],
                selected: _wallet,
                label: (w) => w?.name ?? l10n.recurringAskMe,
                onSelected: (w) => setState(() => _wallet = w),
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
