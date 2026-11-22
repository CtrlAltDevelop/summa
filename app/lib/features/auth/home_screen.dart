import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import 'auth_controller.dart';
import 'auth_models.dart';

/// Placeholder home until the ledger exists: a greeting and sign-out.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({required this.profile, super.key});

  final Profile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return SmBackground(
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(SmSpace.screen),
            child: SmGlassCard(
              padding: const EdgeInsets.all(SmSpace.xl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.homeGreeting(profile.displayName),
                    style: SmType.title,
                  ),
                  const SizedBox(height: SmSpace.xl),
                  SmButton(
                    label: l10n.signOut,
                    onPressed: () =>
                        ref.read(authControllerProvider.notifier).signOut(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
