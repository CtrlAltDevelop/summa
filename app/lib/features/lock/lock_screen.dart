import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import 'lock_controller.dart';

/// Covers the app until the passcode (or biometrics) opens it.
class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({super.key});

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> {
  final _code = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final result = await ref
        .read(lockProvider.notifier)
        .unlockWithPasscode(_code.text);
    if (!mounted) return;
    _code.clear();
    setState(() {
      _error = switch (result) {
        UnlockResult.ok => null,
        UnlockResult.wrong => l10n.lockWrong,
        UnlockResult.lockedOut => l10n.lockWait,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final lock = ref.watch(lockProvider);
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
                  Text(l10n.lockTitle, style: SmType.title),
                  const SizedBox(height: SmSpace.lg),
                  TextField(
                    controller: _code,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    maxLength: 8,
                    style: SmType.body.copyWith(fontSize: 22),
                    decoration: InputDecoration(
                      labelText: l10n.lockPasscodeLabel,
                      counterText: '',
                    ),
                    onSubmitted: (_) => _submit(),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: SmSpace.sm),
                    Text(
                      _error!,
                      style: SmType.caption.copyWith(color: SmColors.danger),
                    ),
                  ],
                  const SizedBox(height: SmSpace.lg),
                  SmButton(label: l10n.lockUnlock, onPressed: _submit),
                  if (lock.biometric) ...[
                    const SizedBox(height: SmSpace.sm),
                    SmButton(
                      label: l10n.lockBiometric,
                      onPressed: () => ref
                          .read(lockProvider.notifier)
                          .unlockWithBiometrics(reason: l10n.unlockReason),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Keeps the app mounted underneath and puts the lock screen over it, so
/// nothing on screen is readable while locked and nothing is lost on unlock.
class LockGate extends ConsumerStatefulWidget {
  const LockGate({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<LockGate> createState() => _LockGateState();
}

class _LockGateState extends ConsumerState<LockGate>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final lock = ref.read(lockProvider.notifier);
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        lock.onPaused();
      case AppLifecycleState.resumed:
        lock.onResumed();
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lock = ref.watch(lockProvider);
    if (!lock.loaded) return const SmBackground(child: SizedBox.shrink());
    final covered = lock.enabled && lock.locked;
    return Stack(
      children: [
        Offstage(offstage: covered, child: widget.child),
        if (covered) const Positioned.fill(child: LockScreen()),
      ],
    );
  }
}
