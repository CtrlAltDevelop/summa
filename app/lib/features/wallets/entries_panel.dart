import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../categories/category_controller.dart';
import 'entry_form_screen.dart';
import 'entry_models.dart';
import 'split_form_screen.dart';
import 'transfer_form_screen.dart';
import 'ledger_controller.dart';
import 'refund_form_screen.dart';
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
        if (wallets.isNotEmpty) ...[
          SmButton(
            label: l10n.splitOpen,
            secondary: true,
            onPressed: () => Navigator.of(context).push(
              PageRouteBuilder<void>(
                pageBuilder: (_, _, _) => SplitFormScreen(wallets: wallets),
              ),
            ),
          ),
          const SizedBox(height: SmSpace.sm),
        ],
        if (wallets.length >= 2) ...[
          SmButton(
            label: l10n.transferAdd,
            secondary: true,
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

class _EntryTile extends ConsumerStatefulWidget {
  const _EntryTile({required this.entry});

  final Entry entry;

  @override
  ConsumerState<_EntryTile> createState() => _EntryTileState();
}

class _EntryTileState extends ConsumerState<_EntryTile> {
  String? _error;

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context);
    try {
      await ref.read(ledgerControllerProvider.notifier).delete(widget.entry.id);
    } on WalletException {
      // The server refuses to delete an expense that still has refunds.
      if (mounted) setState(() => _error = l10n.entryDeleteBlocked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final entry = widget.entry;
    final l10n = AppLocalizations.of(context);
    final income = entry.kind.isCredit;
    final amount = formatMinor(entry.amountMinor, entry.currency);
    final categoryName = ref
        .watch(categoriesControllerProvider)
        .value
        ?.where((c) => c.id == entry.categoryId)
        .map((c) => c.name)
        .firstOrNull;
    final wallets = (ref.watch(walletsControllerProvider).value?.active ?? [])
        .where((w) => w.currency == entry.currency)
        .toList();
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
                      entry.note.isEmpty
                          ? _kindLabel(l10n, entry.kind)
                          : entry.note,
                      style: SmType.body,
                    ),
                    Text(
                      [
                        formatJalaliDate(entry.occurredAt.toLocal()),
                        if (categoryName != null) categoryName,
                        if (entry.outsideTotals) l10n.entryOutsideTag,
                        if (entry.splitId.isNotEmpty) l10n.entrySplitTag,
                        if (entry.refundedMinor > 0) l10n.entryRefundedTag,
                      ].join(' · '),
                      style: SmType.caption,
                    ),
                  ],
                ),
              ),
              Text(
                '${income ? '+' : '-'}$amount '
                '${currencyLabel(l10n, entry.currency)}',
                style: SmType.body.copyWith(
                  color: income ? SmColors.success : SmColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: SmSpace.sm),
          Row(
            children: [
              if (entry.refundableMinor > 0 && wallets.isNotEmpty) ...[
                _TileAction(
                  label: l10n.refundOpen,
                  color: SmColors.accent,
                  onTap: () => Navigator.of(context).push(
                    PageRouteBuilder<void>(
                      pageBuilder: (_, _, _) =>
                          RefundFormScreen(entry: entry, wallets: wallets),
                    ),
                  ),
                ),
                const SizedBox(width: SmSpace.lg),
              ],
              _TileAction(
                label: l10n.entryDelete,
                color: SmColors.danger,
                onTap: _delete,
              ),
            ],
          ),
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

class _TileAction extends StatelessWidget {
  const _TileAction({
    required this.label,
    required this.color,
    required this.onTap,
  });

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

String _kindLabel(AppLocalizations l10n, EntryKind kind) => switch (kind) {
  EntryKind.income => l10n.entryIncome,
  EntryKind.expense => l10n.entryExpense,
  EntryKind.transferOut => l10n.transferOut,
  EntryKind.transferIn => l10n.transferIn,
  EntryKind.refund => l10n.entryRefund,
};
