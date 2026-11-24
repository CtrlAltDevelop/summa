import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../wallets/wallet_labels.dart';
import '../wallets/wallet_models.dart';
import 'outbox.dart';

/// Entries saved offline and not yet sent, and the ones the server refused.
class OutboxPanel extends ConsumerStatefulWidget {
  const OutboxPanel({super.key});

  @override
  ConsumerState<OutboxPanel> createState() => _OutboxPanelState();
}

class _OutboxPanelState extends ConsumerState<OutboxPanel> {
  @override
  void initState() {
    super.initState();
    // Try once as the home screen opens; no timers, no background work.
    Future.microtask(() => ref.read(outboxProvider.notifier).flush());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final outbox = ref.watch(outboxProvider);
    if (outbox.pending.isEmpty && outbox.failed.isEmpty) {
      return const SizedBox.shrink();
    }
    String money(QueuedEntry e) =>
        '${formatMinor(e.amountMinor, e.currency)} ${currencyLabel(l10n, e.currency)}';
    return Padding(
      padding: const EdgeInsets.only(bottom: SmSpace.lg),
      child: SmGlassCard(
        padding: const EdgeInsets.all(SmSpace.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (outbox.pending.isNotEmpty) ...[
              Text(
                l10n.outboxPending(localDigits('${outbox.pending.length}')),
                style: SmType.body,
              ),
              for (final e in outbox.pending)
                Text(
                  '${e.note.isEmpty ? '' : '${e.note} · '}${money(e)} · '
                  '${l10n.outboxQueued}',
                  style: SmType.caption,
                ),
              const SizedBox(height: SmSpace.md),
              SmButton(
                label: l10n.outboxRetry,
                onPressed: () => ref.read(outboxProvider.notifier).flush(),
              ),
            ],
            if (outbox.failed.isNotEmpty) ...[
              const SizedBox(height: SmSpace.md),
              Text(
                l10n.outboxFailedTitle,
                style: SmType.body.copyWith(color: SmColors.danger),
              ),
              for (final f in outbox.failed)
                Row(
                  children: [
                    Expanded(
                      child: Text(money(f.entry), style: SmType.caption),
                    ),
                    GestureDetector(
                      onTap: () => ref
                          .read(outboxProvider.notifier)
                          .dismissFailed(f.entry.mutationId),
                      child: Text(
                        l10n.outboxFailedDismiss,
                        style: SmType.caption.copyWith(color: SmColors.danger),
                      ),
                    ),
                  ],
                ),
            ],
          ],
        ),
      ),
    );
  }
}
