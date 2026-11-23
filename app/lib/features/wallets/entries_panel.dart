import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../categories/category_controller.dart';
import 'entry_form_screen.dart';
import 'entry_models.dart';
import 'transfer_form_screen.dart';
import 'ledger_controller.dart';
import 'wallet_labels.dart';
import 'wallet_models.dart';
import 'wallets_controller.dart';

/// Add-entry button and the recent entries, newest first.
class EntriesPanel extends ConsumerWidget {
  const EntriesPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final wallets = ref.watch(walletsControllerProvider).value?.active ?? [];
    final entries = ref.watch(ledgerControllerProvider).value ?? const [];
    ref.watch(categoriesControllerProvider); // load them before the form opens
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (wallets.isNotEmpty) ...[
          SmButton(
            label: l10n.entryAdd,
            icon: SmIcons.bolt,
            onPressed: () => Navigator.of(context).push(
              PageRouteBuilder<void>(
                pageBuilder: (_, _, _) => EntryFormScreen(wallets: wallets),
              ),
            ),
          ),
          const SizedBox(height: SmSpace.sm),
        ],
        if (wallets.length >= 2) ...[
          SmButton(
            label: l10n.transferAdd,
            icon: SmIcons.refresh,
            onPressed: () => Navigator.of(context).push(
              PageRouteBuilder<void>(
                pageBuilder: (_, _, _) => TransferFormScreen(wallets: wallets),
              ),
            ),
          ),
        ],
        if (wallets.isNotEmpty) const SizedBox(height: SmSpace.lg),
        for (final e in entries)
          Padding(
            padding: const EdgeInsets.only(bottom: SmSpace.sm),
            child: _EntryTile(entry: e),
          ),
      ],
    );
  }
}

class _EntryTile extends ConsumerWidget {
  const _EntryTile({required this.entry});

  final Entry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final income = entry.kind.isCredit;
    final amount = formatMinor(entry.amountMinor, entry.currency);
    final categoryName = ref
        .watch(categoriesControllerProvider)
        .value
        ?.where((c) => c.id == entry.categoryId)
        .map((c) => c.name)
        .firstOrNull;
    return SmGlassCard(
      padding: const EdgeInsets.all(SmSpace.lg),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.note.isEmpty
                      ? _kindLabel(l10n, entry.kind)
                      : entry.note,
                  style: SmType.body,
                ),
                Text(
                  [
                    formatJalaliDate(entry.occurredAt.toLocal()),
                    if (categoryName != null) categoryName,
                  ].join(' · '),
                  style: SmType.caption,
                ),
              ],
            ),
          ),
          Text(
            '${income ? '+' : '-'}$amount ${currencyLabel(l10n, entry.currency)}',
            style: SmType.body.copyWith(
              color: income ? SmColors.success : SmColors.textPrimary,
            ),
          ),
          const SizedBox(width: SmSpace.md),
          Semantics(
            button: true,
            label: l10n.entryDelete,
            child: GestureDetector(
              onTap: () =>
                  ref.read(ledgerControllerProvider.notifier).delete(entry.id),
              child: Text(
                l10n.entryDelete,
                style: SmType.caption.copyWith(color: SmColors.danger),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _kindLabel(AppLocalizations l10n, EntryKind kind) => switch (kind) {
  EntryKind.income => l10n.entryIncome,
  EntryKind.expense => l10n.entryExpense,
  EntryKind.transferOut => l10n.transferOut,
  EntryKind.transferIn => l10n.transferIn,
};
