import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import 'auth_controller.dart';
import 'auth_messages.dart';
import 'auth_models.dart';
import 'home_screen.dart';
import 'login_flow_screen.dart';
import 'name_screen.dart';

/// Chooses the screen from the session: login, name, or home.
class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    return AnimatedSwitcher(
      duration: SmMotion.of(context, SmMotion.medium),
      switchInCurve: SmMotion.enter,
      switchOutCurve: SmMotion.exit,
      child: auth.when(
        loading: () => const _Splash(key: ValueKey('loading')),
        error: (_, _) => const _Retry(key: ValueKey('retry')),
        data: (state) => switch (state) {
          SignedOut() => const LoginFlowScreen(key: ValueKey('login')),
          SignedIn(:final profile) when !profile.hasName => const NameScreen(
            key: ValueKey('name'),
          ),
          SignedIn(:final profile) => HomeScreen(
            key: const ValueKey('home'),
            profile: profile,
          ),
        },
      ),
    );
  }
}

class _Splash extends StatelessWidget {
  const _Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return const SmBackground(
      child: Center(child: CircularProgressIndicator(color: SmColors.accent)),
    );
  }
}

class _Retry extends ConsumerWidget {
  const _Retry({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return SmBackground(
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
                  authFailureMessage(l10n, AuthFailure.offline),
                  style: SmType.body,
                ),
                const SizedBox(height: SmSpace.xl),
                SmButton(
                  label: l10n.retry,
                  icon: SmIcons.refresh,
                  onPressed: () => ref.invalidate(authControllerProvider),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
