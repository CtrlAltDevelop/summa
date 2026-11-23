import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import 'authenticator.dart';
import 'lock_controller.dart';
import 'passcode.dart';

/// Proves it is the owner before a sensitive act (deleting the account,
/// exporting or importing data). Biometrics if the device has them; otherwise
/// the app passcode, which is set up first if it does not exist yet.
Future<bool> confirmStrongAuth(BuildContext context, WidgetRef ref) async {
  final lock = ref.read(lockProvider);
  final auth = ref.read(authenticatorProvider);
  final l10n = AppLocalizations.of(context);
  final hasBiometrics = await auth.canUseBiometrics();
  if (hasBiometrics && (!lock.enabled || lock.biometric)) {
    return auth.authenticate(l10n.strongAuthReason);
  }
  if (!context.mounted) return false;
  if (!lock.enabled) {
    final enabled = await Navigator.of(context).push<bool>(
      PageRouteBuilder<bool>(
        pageBuilder: (_, _, _) => const PasscodeSetupScreen(explain: true),
      ),
    );
    if (enabled != true) return false;
  }
  if (!context.mounted) return false;
  final ok = await Navigator.of(context).push<bool>(
    PageRouteBuilder<bool>(pageBuilder: (_, _, _) => const PasscodePrompt()),
  );
  return ok ?? false;
}

/// Pick a passcode (twice). Pops `true` once the lock is enabled.
class PasscodeSetupScreen extends ConsumerStatefulWidget {
  const PasscodeSetupScreen({this.explain = false, super.key});

  /// Shows why it is needed (opened from a sensitive act).
  final bool explain;

  @override
  ConsumerState<PasscodeSetupScreen> createState() =>
      _PasscodeSetupScreenState();
}

class _PasscodeSetupScreenState extends ConsumerState<PasscodeSetupScreen> {
  final _first = TextEditingController();
  final _second = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _first.dispose();
    _second.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    if (!isValidPasscode(_first.text)) {
      setState(() => _error = l10n.lockInvalid);
      return;
    }
    if (_first.text != _second.text) {
      setState(() => _error = l10n.lockMismatch);
      return;
    }
    await ref.read(lockProvider.notifier).enable(_first.text);
    if (mounted) navigator.pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SmBackground(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(SmSpace.screen),
          children: [
            Text(l10n.lockEnable, style: SmType.title),
            if (widget.explain) ...[
              const SizedBox(height: SmSpace.sm),
              Text(l10n.strongAuthNeedPasscode, style: SmType.body),
            ],
            const SizedBox(height: SmSpace.lg),
            SmTextField(
              controller: _first,
              label: l10n.lockNewPasscode,
              keyboardType: TextInputType.number,
              textDirection: TextDirection.ltr,
              maxLength: passcodeMaxLength,
            ),
            const SizedBox(height: SmSpace.md),
            SmTextField(
              controller: _second,
              label: l10n.lockConfirmPasscode,
              keyboardType: TextInputType.number,
              textDirection: TextDirection.ltr,
              maxLength: passcodeMaxLength,
            ),
            if (_error != null) ...[
              const SizedBox(height: SmSpace.md),
              Text(
                _error!,
                style: SmType.caption.copyWith(color: SmColors.danger),
              ),
            ],
            const SizedBox(height: SmSpace.xl),
            SmButton(label: l10n.lockSave, onPressed: _save),
          ],
        ),
      ),
    );
  }
}

/// Ask for the current passcode. Pops `true` when it is right.
class PasscodePrompt extends ConsumerStatefulWidget {
  const PasscodePrompt({super.key});

  @override
  ConsumerState<PasscodePrompt> createState() => _PasscodePromptState();
}

class _PasscodePromptState extends ConsumerState<PasscodePrompt> {
  final _code = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _check() async {
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    // Re-checking through the unlock path keeps the wrong-code counting and
    // the waiting in one place.
    final result = await ref
        .read(lockProvider.notifier)
        .unlockWithPasscode(_code.text);
    if (!mounted) return;
    if (result == UnlockResult.ok) {
      navigator.pop(true);
      return;
    }
    _code.clear();
    setState(
      () => _error = result == UnlockResult.lockedOut
          ? l10n.lockWait
          : l10n.lockWrong,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SmBackground(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(SmSpace.screen),
          children: [
            Text(l10n.strongAuthPrompt, style: SmType.title),
            const SizedBox(height: SmSpace.lg),
            SmTextField(
              controller: _code,
              label: l10n.lockPasscodeLabel,
              keyboardType: TextInputType.number,
              textDirection: TextDirection.ltr,
              maxLength: passcodeMaxLength,
              autofocus: true,
              onSubmitted: (_) => _check(),
            ),
            if (_error != null) ...[
              const SizedBox(height: SmSpace.md),
              Text(
                _error!,
                style: SmType.caption.copyWith(color: SmColors.danger),
              ),
            ],
            const SizedBox(height: SmSpace.xl),
            SmButton(label: l10n.lockUnlock, onPressed: _check),
          ],
        ),
      ),
    );
  }
}
