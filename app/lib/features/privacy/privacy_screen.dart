import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../lock/authenticator.dart';
import '../lock/lock_controller.dart';
import '../lock/strong_auth.dart';
import '../wallets/choices.dart';
import 'privacy_controller.dart';

/// App lock, chat retention and deleting the account.
class PrivacyScreen extends ConsumerStatefulWidget {
  const PrivacyScreen({super.key});

  @override
  ConsumerState<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends ConsumerState<PrivacyScreen> {
  bool _biometricsAvailable = false;
  bool _deleting = false;
  final _confirm = TextEditingController();
  String? _error;

  @override
  void initState() {
    super.initState();
    ref.read(authenticatorProvider).canUseBiometrics().then((ok) {
      if (mounted) setState(() => _biometricsAvailable = ok);
    });
  }

  @override
  void dispose() {
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _enable() => Navigator.of(context).push<bool>(
    PageRouteBuilder<bool>(
      pageBuilder: (_, _, _) => const PasscodeSetupScreen(),
    ),
  );

  Future<void> _disable() async {
    final ok = await Navigator.of(context).push<bool>(
      PageRouteBuilder<bool>(pageBuilder: (_, _, _) => const PasscodePrompt()),
    );
    if (ok ?? false) {
      // The prompt already proved the code; switching off needs it again here
      // only because the controller verifies before it forgets the hash.
      await ref.read(lockProvider.notifier).disableAfterProof();
    }
  }

  Future<void> _beginDelete() async {
    final l10n = AppLocalizations.of(context);
    final proven = await confirmStrongAuth(context, ref);
    if (!mounted) return;
    setState(() {
      _deleting = proven;
      _error = proven ? null : l10n.strongAuthDenied;
    });
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    try {
      await deleteAccount(ref, _confirm.text.trim());
      // The session is over: leave every screen so the sign-in page shows.
      navigator.popUntil((route) => route.isFirst);
    } on Exception {
      if (mounted) setState(() => _error = l10n.deleteAccountFailed);
    }
  }

  String _delayLabel(AppLocalizations l10n, int seconds) {
    if (seconds == 0) return l10n.lockDelayNow;
    if (seconds < 60) {
      return l10n.lockDelaySeconds(toPersianDigits('$seconds'));
    }
    return l10n.lockDelayMinutes(toPersianDigits('${seconds ~/ 60}'));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final lock = ref.watch(lockProvider);
    final retention = ref.watch(chatRetentionProvider).value;
    return SmScreen(
      title: l10n.privacyTitle,
      children: [
        SmButton(
          label: lock.enabled ? l10n.lockDisable : l10n.lockEnable,
          onPressed: lock.enabled ? _disable : _enable,
        ),
        if (lock.enabled) ...[
          const SizedBox(height: SmSpace.lg),
          if (_biometricsAvailable) ...[
            Text(l10n.lockBiometricToggle, style: SmType.caption),
            const SizedBox(height: SmSpace.sm),
            Choices<bool>(
              values: const [false, true],
              selected: lock.biometric,
              label: (v) => v ? l10n.lockOn : l10n.lockOff,
              onSelected: (v) =>
                  ref.read(lockProvider.notifier).setBiometric(on: v),
            ),
            const SizedBox(height: SmSpace.lg),
          ],
          Text(l10n.lockDelayLabel, style: SmType.caption),
          const SizedBox(height: SmSpace.sm),
          Choices<int>(
            values: lockDelays,
            selected: lock.delaySeconds,
            label: (s) => _delayLabel(l10n, s),
            onSelected: (s) => ref.read(lockProvider.notifier).setDelay(s),
          ),
        ],
        const SizedBox(height: SmSpace.xl),
        Text(l10n.retentionTitle, style: SmType.caption),
        const SizedBox(height: SmSpace.sm),
        Choices<int>(
          values: retentionChoices,
          selected: retention ?? 0,
          label: (d) => d == 0
              ? l10n.retentionForever
              : l10n.retentionDays(toPersianDigits('$d')),
          onSelected: (d) => setChatRetention(ref, d),
        ),
        const SizedBox(height: SmSpace.xxl),
        if (!_deleting)
          SmButton(label: l10n.deleteAccountOpen, onPressed: _beginDelete)
        else ...[
          Text(
            l10n.deleteAccountWarning,
            style: SmType.body.copyWith(color: SmColors.danger),
          ),
          const SizedBox(height: SmSpace.md),
          SmTextField(
            controller: _confirm,
            label: l10n.deleteAccountConfirmLabel,
            textDirection: TextDirection.ltr,
          ),
          const SizedBox(height: SmSpace.md),
          SmButton(label: l10n.deleteAccountButton, onPressed: _delete),
        ],
        if (_error != null) ...[
          const SizedBox(height: SmSpace.md),
          Text(_error!, style: SmType.caption.copyWith(color: SmColors.danger)),
        ],
      ],
    );
  }
}
