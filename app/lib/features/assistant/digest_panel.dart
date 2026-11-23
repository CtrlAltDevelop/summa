import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../wallets/choices.dart';
import 'assistant_controller.dart';
import 'chat_models.dart';

/// Hours offered for the daily reminder; -1 turns it off.
const accountingHours = [-1, 7, 8, 9, 10, 12, 14, 16, 18, 19, 20, 21, 22, 23];

/// The reminder card (when it is time) and the accounting-hour chooser.
class DigestPanel extends ConsumerWidget {
  const DigestPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final digest = ref.watch(digestProvider).value;
    if (digest == null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (digest.shouldRemind) ...[
          _ReminderCard(digest: digest),
          const SizedBox(height: SmSpace.md),
        ],
        SmGlassCard(
          padding: const EdgeInsets.all(SmSpace.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.accountingHourTitle, style: SmType.caption),
              const SizedBox(height: SmSpace.sm),
              Choices<int>(
                values: accountingHours,
                selected: accountingHours.contains(digest.accountingHour)
                    ? digest.accountingHour
                    : -1,
                label: (h) =>
                    h < 0 ? l10n.accountingHourOff : toPersianDigits('$h:00'),
                onSelected: (h) => setAccountingHour(ref, h),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReminderCard extends StatelessWidget {
  const _ReminderCard({required this.digest});

  final Digest digest;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final lines = [
      if (digest.entriesToday == 0)
        l10n.digestNothingYet
      else
        l10n.digestEntries(toPersianDigits('${digest.entriesToday}')),
      if (digest.uncategorizedToday > 0)
        l10n.digestUncategorized(
          toPersianDigits('${digest.uncategorizedToday}'),
        ),
      if (digest.dueQuestions > 0)
        l10n.digestDue(toPersianDigits('${digest.dueQuestions}')),
    ];
    return SmGlassCard(
      padding: const EdgeInsets.all(SmSpace.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.digestTitle, style: SmType.title),
          const SizedBox(height: SmSpace.sm),
          for (final line in lines) Text(line, style: SmType.body),
        ],
      ),
    );
  }
}
