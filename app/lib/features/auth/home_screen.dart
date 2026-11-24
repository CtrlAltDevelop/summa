import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../assets/assets_panel.dart';
import '../assistant/chat_screen.dart';
import '../assistant/digest_panel.dart';
import '../assistant/sms_screen.dart';
import '../billing/billing_screen.dart';
import '../categories/budgets_panel.dart';
import '../debts/debts_panel.dart';
import '../networth/networth_panel.dart';
import '../outbox/outbox_panel.dart';
import '../privacy/privacy_screen.dart';
import '../recurring/recurring_panel.dart';
import '../support/support_screen.dart';
import '../reports/data_screen.dart';
import '../reports/report_screen.dart';
import '../wallets/entries_panel.dart';
import '../wallets/wallets_panel.dart';
import 'auth_controller.dart';
import 'auth_models.dart';
import 'setup_prompt.dart';

/// Width from which home becomes a sidebar plus a two-column card grid.
const double _wideBreakpoint = 900;
const double _sidebarWidth = 290; // fits the longest English label

/// Home: greeting, the wallets and their totals, sign-out.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({required this.profile, super.key});

  final Profile profile;

  void _open(BuildContext context, Widget screen) {
    Navigator.of(context)
        .push(PageRouteBuilder<void>(pageBuilder: (_, _, _) => screen));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final wide = MediaQuery.sizeOf(context).width >= _wideBreakpoint;
    final links = <(String, Widget)>[
      (l10n.chatOpen, const ChatScreen()),
      (l10n.smsOpen, const SmsScreen()),
      (l10n.reportOpen, const ReportScreen()),
      (l10n.dataOpen, const DataScreen()),
      (l10n.privacyOpen, const PrivacyScreen()),
      (l10n.supportOpen, const SupportScreen()),
      (l10n.billingOpen, const BillingScreen()),
    ];
    final cards = <Widget>[
      const ReadOnlyBanner(),
      const OutboxPanel(),
      const NetWorthCard(),
      const WalletsPanel(),
      const DigestPanel(),
      const RecurringPanel(),
      const DebtsPanel(),
      const AssetsPanel(),
      const BasketsPanel(),
      const BudgetsPanel(),
      const EntriesPanel(),
    ];
    final signOut = SmButton(
      label: l10n.signOut,
      secondary: true,
      onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
    );
    final greeting = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SetupPrompt(),
        Text(l10n.homeGreeting(profile.displayName), style: SmType.title),
      ],
    );
    if (!wide) {
      return SmBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(SmSpace.screen),
            children: [
              greeting,
              const SizedBox(height: SmSpace.lg),
              Row(
                children: [
                  for (final (i, link) in links.take(2).indexed) ...[
                    if (i > 0) const SizedBox(width: SmSpace.sm),
                    Expanded(
                      child: SmButton(
                        label: link.$1,
                        icon: i == 0 ? SmIcons.bolt : null,
                        onPressed: () => _open(context, link.$2),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: SmSpace.lg),
              for (final card in cards) ...[
                card,
                const SizedBox(height: SmSpace.lg),
              ],
              for (final link in links.skip(2)) ...[
                SmButton(
                  label: link.$1,
                  secondary: true,
                  onPressed: () => _open(context, link.$2),
                ),
                const SizedBox(height: SmSpace.sm),
              ],
              signOut,
            ],
          ),
        ),
      );
    }
    return SmBackground(
      maxWidth: 1240,
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: _sidebarWidth,
              child: Padding(
                padding: const EdgeInsets.all(SmSpace.lg),
                child: SmGlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(l10n.appName, style: SmType.title),
                      const SizedBox(height: SmSpace.xl),
                      for (final link in links) ...[
                        SmButton(
                          label: link.$1,
                          secondary: true,
                          onPressed: () => _open(context, link.$2),
                        ),
                        const SizedBox(height: SmSpace.sm),
                      ],
                      const SizedBox(height: SmSpace.lg),
                      signOut,
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(SmSpace.lg),
                children: [
                  greeting,
                  const SizedBox(height: SmSpace.lg),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final column in [0, 1]) ...[
                        if (column == 1) const SizedBox(width: SmSpace.lg),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              for (final (i, card) in cards.indexed)
                                if (i % 2 == column) ...[
                                  card,
                                  const SizedBox(height: SmSpace.lg),
                                ],
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
