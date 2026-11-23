import 'package:flutter/material.dart' show CircularProgressIndicator;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import 'wallet_form_screen.dart';
import 'wallet_labels.dart';
import 'wallet_models.dart';
import 'wallets_controller.dart';

/// The home body: the accounting box (totals per currency) and the wallets.
class WalletsPanel extends ConsumerWidget {
  const WalletsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final wallets = ref.watch(walletsControllerProvider);
    return wallets.when(
      loading: () => const Center(child: CircularProgressIndicator.adaptive()),
      error: (_, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.errOffline, style: SmType.body),
          const SizedBox(height: SmSpace.md),
          SmButton(
            label: l10n.retry,
            icon: SmIcons.refresh,
            onPressed: () => ref.invalidate(walletsControllerProvider),
          ),
        ],
      ),
      data: (list) => _Loaded(list: list),
    );
  }
}

class _Loaded extends StatelessWidget {
  const _Loaded({required this.list});

  final WalletList list;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final active = list.active;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (active.isEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: SmSpace.lg),
            child: Text(l10n.walletsEmpty, style: SmType.body),
          )
        else ...[
          SmGlassCard(
            padding: const EdgeInsets.all(SmSpace.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.walletsTotalTitle, style: SmType.caption),
                for (final t in list.totals)
                  Padding(
                    padding: const EdgeInsets.only(top: SmSpace.xs),
                    child: Text(
                      '${formatMinor(t.balanceMinor, t.currency)} '
                      '${currencyLabel(l10n, t.currency)}',
                      style: SmType.title,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: SmSpace.md),
          for (final w in active)
            Padding(
              padding: const EdgeInsets.only(bottom: SmSpace.sm),
              child: _WalletTile(wallet: w),
            ),
        ],
        const SizedBox(height: SmSpace.md),
        SmButton(
          label: l10n.walletAdd,
          secondary: true,
          icon: SmIcons.wallet,
          onPressed: () => Navigator.of(context).push(
            PageRouteBuilder<void>(
              pageBuilder: (_, _, _) => const WalletFormScreen(),
            ),
          ),
        ),
      ],
    );
  }
}

class _WalletTile extends StatelessWidget {
  const _WalletTile({required this.wallet});

  final Wallet wallet;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final subtitle = [
      walletKindLabel(l10n, wallet.kind),
      if (wallet.bank.isNotEmpty) wallet.bank,
    ].join(' · ');
    return SmGlassCard(
      padding: const EdgeInsets.all(SmSpace.lg),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(wallet.name, style: SmType.body),
                Text(subtitle, style: SmType.caption),
              ],
            ),
          ),
          Text(
            '${formatMinor(wallet.balanceMinor, wallet.currency)} '
            '${currencyLabel(l10n, wallet.currency)}',
            style: SmType.body,
          ),
        ],
      ),
    );
  }
}
