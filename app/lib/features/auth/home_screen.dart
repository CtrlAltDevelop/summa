import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../wallets/wallets_panel.dart';
import 'auth_controller.dart';
import 'auth_models.dart';

/// Home: greeting, the wallets and their totals, sign-out.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({required this.profile, super.key});

  final Profile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return SmBackground(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(SmSpace.screen),
          children: [
            Text(l10n.homeGreeting(profile.displayName), style: SmType.title),
            const SizedBox(height: SmSpace.lg),
            const WalletsPanel(),
            const SizedBox(height: SmSpace.xl),
            SmButton(
              label: l10n.signOut,
              onPressed: () =>
                  ref.read(authControllerProvider.notifier).signOut(),
            ),
          ],
        ),
      ),
    );
  }
}
