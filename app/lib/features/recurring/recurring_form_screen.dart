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
import '../wallets/choices.dart';
import '../wallets/entry_models.dart';
import '../wallets/wallet_models.dart';
import 'recurring_controller.dart';
import 'recurring_models.dart';

const _monthDays = 31;

/// Define a repeating expense or income: monthly on a Shamsi day, or weekly.
class RecurringFormScreen extends ConsumerStatefulWidget {
  const RecurringFormScreen({required this.wallets, super.key});

  final List<Wallet> wallets;

  @override
  ConsumerState<RecurringFormScreen> createState() =>
      _RecurringFormScreenState();
}

class _RecurringFormScreenState extends ConsumerState<RecurringFormScreen> {
  final _note = TextEditingController();
  final _amount = TextEditingController();
  final _day = TextEditingController(text: '1');
  // One id per form so a retried save cannot create two.
  final _mutationId = _newMutationId();
  late Wallet _wallet = widget.wallets.first;
  EntryKind _kind = EntryKind.expense;
  RecurringPeriod _period = RecurringPeriod.monthly;
  int _weekday = 5; // Saturday
  bool _auto = false;
  Category? _category;
  bool _saving = false;
  String? _error;

  static String _newMutationId() {
    final random = Random.secure();
    return List.generate(
      16,
      (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
  }

  /// The categories for the chosen kind; "other" is the default.
  List<Category> _categoriesFor(WidgetRef ref) {
    final kind = _kind == EntryKind.income
        ? CategoryKind.income
        : CategoryKind.expense;
    return (ref.read(categoriesControllerProvider).value ?? const <Category>[])
        .where((c) => c.kind == kind)
        .toList();
  }

  Category? _chosenCategory(WidgetRef ref) {
    final options = _categoriesFor(ref);
    if (options.isEmpty) return null;
    if (_category != null && options.any((c) => c.id == _category!.id)) {
      return _category;
    }
    return options.firstWhere((c) => c.isOther, orElse: () => options.first);
  }

  @override
  void dispose() {
    _note.dispose();
    _amount.dispose();
    _day.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    final typed = _amount.text.trim();
    final amount = typed.isEmpty ? 0 : parseMinor(typed, _wallet.currency);
    final monthly = _period == RecurringPeriod.monthly;
    final day = monthly
        ? int.tryParse(toLatinDigits(_day.text.trim()))
        : _weekday;
    if (amount == null || amount < 0) {
      setState(() => _error = l10n.entryAmountInvalid);
      return;
    }
    if (day == null || (monthly && (day < 1 || day > _monthDays))) {
      setState(() => _error = l10n.recurringDayInvalid);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref
          .read(recurringControllerProvider.notifier)
          .create(
            walletId: _wallet.id,
            kind: _kind.wire,
            amountMinor: amount,
            note: _note.text.trim(),
            period: _period,
            day: day,
            autoConfirm: _auto && amount > 0,
            clientMutationId: _mutationId,
            categoryId: _chosenCategory(ref)?.id ?? '',
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
    ref.watch(categoriesControllerProvider); // load them for the choice
    final weekdays = {
      5: l10n.weekdaySat,
      6: l10n.weekdaySun,
      0: l10n.weekdayMon,
      1: l10n.weekdayTue,
      2: l10n.weekdayWed,
      3: l10n.weekdayThu,
      4: l10n.weekdayFri,
    };
    return SmScreen(
      title: l10n.recurringTitle,
      children: [
        Choices<EntryKind>(
          values: EntryKind.recordable,
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
        if (_categoriesFor(ref).isNotEmpty) ...[
          const SizedBox(height: SmSpace.lg),
          Text(l10n.recurringCategoryLabel, style: SmType.caption),
          const SizedBox(height: SmSpace.sm),
          Choices<Category>(
            values: _categoriesFor(ref),
            selected: _chosenCategory(ref)!,
            label: (c) => c.name,
            onSelected: (c) => setState(() => _category = c),
          ),
        ],
        const SizedBox(height: SmSpace.lg),
        SmTextField(
          controller: _note,
          label: l10n.recurringNoteLabel,
          maxLength: 200,
        ),
        const SizedBox(height: SmSpace.lg),
        SmTextField(
          controller: _amount,
          label: l10n.recurringAmountLabel,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textDirection: TextDirection.ltr,
        ),
        const SizedBox(height: SmSpace.lg),
        Text(l10n.recurringPeriodLabel, style: SmType.caption),
        const SizedBox(height: SmSpace.sm),
        Choices<RecurringPeriod>(
          values: RecurringPeriod.values,
          selected: _period,
          label: (p) => p == RecurringPeriod.monthly
              ? l10n.recurringMonthly
              : l10n.recurringWeekly,
          onSelected: (p) => setState(() => _period = p),
        ),
        const SizedBox(height: SmSpace.lg),
        if (_period == RecurringPeriod.monthly)
          SmTextField(
            controller: _day,
            label: l10n.recurringDayLabel,
            keyboardType: TextInputType.number,
            textDirection: TextDirection.ltr,
          )
        else ...[
          Text(l10n.recurringWeekdayLabel, style: SmType.caption),
          const SizedBox(height: SmSpace.sm),
          Choices<int>(
            values: weekdayOrder,
            selected: _weekday,
            label: (d) => weekdays[d]!,
            onSelected: (d) => setState(() => _weekday = d),
          ),
        ],
        const SizedBox(height: SmSpace.lg),
        Choices<bool>(
          values: const [false, true],
          selected: _auto,
          label: (v) => v ? l10n.recurringAuto : l10n.recurringAskMe,
          onSelected: (v) => setState(() => _auto = v),
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
