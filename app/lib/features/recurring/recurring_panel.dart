import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../wallets/choices.dart';
import '../wallets/wallet_labels.dart';
import '../wallets/wallet_models.dart';
import '../wallets/wallets_controller.dart';
import 'recurring_controller.dart';
import 'recurring_form_screen.dart';
import 'recurring_models.dart';

/// Cycles that need an answer (or are coming up), and the repeating
/// definitions with pause and delete.
class RecurringPanel extends ConsumerWidget {
  const RecurringPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state =
        ref.watch(recurringControllerProvider).value ?? RecurringState.empty;
    final wallets = ref.watch(walletsControllerProvider).value?.active ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final o in state.occurrences)
          Padding(
            padding: const EdgeInsets.only(bottom: SmSpace.md),
            child: _OccurrenceCard(occurrence: o),
          ),
        for (final r in state.recurrings)
          Padding(
            padding: const EdgeInsets.only(bottom: SmSpace.sm),
            child: _RecurringTile(recurring: r),
          ),
        if (wallets.isNotEmpty)
          SmButton(
            label: l10n.recurringAdd,
            secondary: true,
            onPressed: () => Navigator.of(context).push(
              PageRouteBuilder<void>(
                pageBuilder: (_, _, _) => RecurringFormScreen(wallets: wallets),
              ),
            ),
          ),
      ],
    );
  }
}

class _OccurrenceCard extends ConsumerStatefulWidget {
  const _OccurrenceCard({required this.occurrence});

  final Occurrence occurrence;

  @override
  ConsumerState<_OccurrenceCard> createState() => _OccurrenceCardState();
}

class _OccurrenceCardState extends ConsumerState<_OccurrenceCard> {
  final _amount = TextEditingController();
  bool _picking = false;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  Future<void> _answer(String action, {String walletId = ''}) async {
    final l10n = AppLocalizations.of(context);
    final o = widget.occurrence;
    var amount = 0;
    if ((action == 'confirm' || action == 'other_wallet') && o.isVariable) {
      final parsed = parseMinor(_amount.text, o.currency);
      if (parsed == null || parsed <= 0) {
        setState(() => _error = l10n.occurrenceNeedsAmount);
        return;
      }
      amount = parsed;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref
          .read(recurringControllerProvider.notifier)
          .resolve(
            occurrenceId: o.id,
            action: action,
            walletId: walletId,
            amountMinor: amount,
          );
    } on Exception {
      if (mounted) {
        setState(() {
          _busy = false;
          _error = l10n.errUnknown;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final o = widget.occurrence;
    final others = (ref.watch(walletsControllerProvider).value?.active ?? [])
        .where((w) => w.currency == o.currency && w.id != o.walletId)
        .toList();
    final amountText = o.isVariable
        ? ''
        : ' · ${formatMinor(o.amountMinor, o.currency)} '
              '${currencyLabel(l10n, o.currency)}';
    return SmGlassCard(
      padding: const EdgeInsets.all(SmSpace.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${o.isDue ? l10n.occurrenceDueTitle : l10n.occurrenceUpcoming}: '
            '${o.note.isEmpty ? o.kind : o.note}$amountText',
            style: SmType.body,
          ),
          Text(
            o.isDue && o.kind == 'income'
                ? '${l10n.occurrenceDidYouGetIt} ${formatJalaliLong(o.dueDate)}'
                : formatJalaliLong(o.dueDate),
            style: SmType.caption,
          ),
          if (o.lowBalance) ...[
            const SizedBox(height: SmSpace.sm),
            Text(
              l10n.occurrenceLowBalance,
              style: SmType.caption.copyWith(color: SmColors.warning),
            ),
          ],
          if (o.isDue) ...[
            if (o.isVariable) ...[
              const SizedBox(height: SmSpace.md),
              SmTextField(
                controller: _amount,
                label: l10n.occurrenceAmountLabel,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textDirection: TextDirection.ltr,
              ),
            ],
            const SizedBox(height: SmSpace.md),
            SmButton(
              label: o.kind == 'income'
                  ? l10n.occurrenceGotIt
                  : l10n.occurrenceDeducted,
              onPressed: _busy ? null : () => _answer('confirm'),
            ),
            const SizedBox(height: SmSpace.sm),
            SmButton(
              label: l10n.occurrenceNotYet,
              secondary: true,
              onPressed: _busy ? null : () => _answer('postpone'),
            ),
            if (others.isNotEmpty) ...[
              const SizedBox(height: SmSpace.sm),
              SmButton(
                label: l10n.occurrenceOtherWallet,
                secondary: true,
                onPressed: _busy
                    ? null
                    : () => setState(() => _picking = !_picking),
              ),
              if (_picking) ...[
                const SizedBox(height: SmSpace.sm),
                Choices<Wallet>(
                  values: others,
                  selected: others.first,
                  label: (w) => w.name,
                  onSelected: (w) => _answer('other_wallet', walletId: w.id),
                ),
              ],
            ],
            const SizedBox(height: SmSpace.sm),
            SmButton(
              label: l10n.occurrenceCancelled,
              secondary: true,
              onPressed: _busy ? null : () => _answer('cancel'),
            ),
          ],
          if (_error != null) ...[
            const SizedBox(height: SmSpace.sm),
            Text(
              _error!,
              style: SmType.caption.copyWith(color: SmColors.danger),
            ),
          ],
        ],
      ),
    );
  }
}

class _RecurringTile extends ConsumerStatefulWidget {
  const _RecurringTile({required this.recurring});

  final Recurring recurring;

  @override
  ConsumerState<_RecurringTile> createState() => _RecurringTileState();
}

class _RecurringTileState extends ConsumerState<_RecurringTile> {
  final _amount = TextEditingController();
  bool _asking = false;
  String? _error;

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  Future<void> _settle() async {
    final l10n = AppLocalizations.of(context);
    final r = widget.recurring;
    if (r.amountMinor == 0 && !_asking) {
      setState(() => _asking = true); // a variable amount: ask for it first
      return;
    }
    final parsed = r.amountMinor == 0
        ? parseMinor(_amount.text, r.currency)
        : 0;
    if (parsed == null || (r.amountMinor == 0 && parsed <= 0)) {
      setState(() => _error = l10n.occurrenceNeedsAmount);
      return;
    }
    try {
      await ref
          .read(recurringControllerProvider.notifier)
          .settleNow(r.id, amountMinor: parsed);
      if (mounted) {
        setState(() {
          _asking = false;
          _error = null;
          _amount.clear();
        });
      }
    } on Exception {
      if (mounted) setState(() => _error = l10n.errUnknown);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final r = widget.recurring;
    final amount = r.amountMinor == 0
        ? ''
        : ' · ${formatMinor(r.amountMinor, r.currency)} '
              '${currencyLabel(l10n, r.currency)}';
    final controller = ref.read(recurringControllerProvider.notifier);
    return SmGlassCard(
      padding: const EdgeInsets.all(SmSpace.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${r.note.isEmpty ? r.kind : r.note}$amount',
                      style: SmType.body,
                    ),
                    Text(
                      '${l10n.recurringNext}: ${formatJalaliDate(r.nextDue)}',
                      style: SmType.caption,
                    ),
                  ],
                ),
              ),
              _Link(
                label: r.active ? l10n.recurringPause : l10n.recurringResume,
                color: SmColors.accent,
                onTap: () => controller.setActive(r.id, active: !r.active),
              ),
              const SizedBox(width: SmSpace.md),
              _Link(
                label: l10n.entryDelete,
                color: SmColors.danger,
                onTap: () => controller.delete(r.id),
              ),
            ],
          ),
          const SizedBox(height: SmSpace.sm),
          _Link(
            label: r.kind == 'income'
                ? l10n.recurringReceived
                : l10n.recurringPaid,
            color: SmColors.success,
            onTap: _settle,
          ),
          if (_asking) ...[
            const SizedBox(height: SmSpace.sm),
            SmTextField(
              controller: _amount,
              label: l10n.occurrenceAmountLabel,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textDirection: TextDirection.ltr,
            ),
          ],
          if (_error != null)
            Text(
              _error!,
              style: SmType.caption.copyWith(color: SmColors.danger),
            ),
        ],
      ),
    );
  }
}

class _Link extends StatelessWidget {
  const _Link({required this.label, required this.color, required this.onTap});

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        child: Text(label, style: SmType.caption.copyWith(color: color)),
      ),
    );
  }
}
