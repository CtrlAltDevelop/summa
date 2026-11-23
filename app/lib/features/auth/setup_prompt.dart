import 'package:flutter/material.dart' show Material, MaterialType;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../wallets/wallet_form_screen.dart';
import '../wallets/wallets_controller.dart';

/// Tests that are not about this prompt switch it off.
final setupPromptEnabledProvider = Provider<bool>((_) => true);

/// Invisible; once per launch, offers to finish setup when the account has no
/// wallet yet (every other number on home depends on one).
class SetupPrompt extends ConsumerStatefulWidget {
  const SetupPrompt({super.key});

  @override
  ConsumerState<SetupPrompt> createState() => _SetupPromptState();
}

class _SetupPromptState extends ConsumerState<SetupPrompt> {
  bool _asked = false;

  void _maybeAsk(bool noWallets) {
    if (!noWallets || _asked) return;
    _asked = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _show();
    });
  }

  Future<void> _show() async {
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    final create = await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: l10n.setupLater,
      barrierColor: SmColors.shadow,
      transitionDuration: SmMotion.of(context, SmMotion.medium),
      transitionBuilder: (context, animation, _, child) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(
            begin: 0.94,
            end: 1,
          ).animate(CurvedAnimation(parent: animation, curve: SmMotion.enter)),
          child: child,
        ),
      ),
      pageBuilder: (context, _, _) => Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(SmSpace.screen),
            child: Material(
              type: MaterialType.transparency,
              child: SmGlassCard(
                strong: true,
                padding: const EdgeInsets.all(SmSpace.xl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(l10n.setupTitle, style: SmType.title),
                    const SizedBox(height: SmSpace.sm),
                    Text(l10n.walletsEmpty, style: SmType.body),
                    const SizedBox(height: SmSpace.xl),
                    SmButton(
                      label: l10n.walletAdd,
                      icon: SmIcons.wallet,
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                    const SizedBox(height: SmSpace.sm),
                    SmButton(
                      label: l10n.setupLater,
                      secondary: true,
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    if (create != true || !mounted) return;
    await navigator.push(
      PageRouteBuilder<void>(
        pageBuilder: (_, _, _) => const WalletFormScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!ref.watch(setupPromptEnabledProvider)) return const SizedBox.shrink();
    ref.listen(walletsControllerProvider, (_, next) {
      final list = next.value;
      if (list != null) _maybeAsk(list.active.isEmpty);
    });
    return const SizedBox.shrink();
  }
}
