import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import 'auth_controller.dart';
import 'auth_messages.dart';
import 'auth_models.dart';

/// First sign-in: asks what to call the person.
class NameScreen extends ConsumerStatefulWidget {
  const NameScreen({super.key});

  @override
  ConsumerState<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends ConsumerState<NameScreen> {
  final _name = TextEditingController();
  bool _busy = false;
  AuthFailure? _failure;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_busy || _name.text.trim().isEmpty) return;
    setState(() {
      _busy = true;
      _failure = null;
    });
    try {
      await ref.read(authControllerProvider.notifier).saveName(_name.text);
    } on AuthException catch (e) {
      if (mounted) setState(() => _failure = e.failure);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SmBackground(
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(SmSpace.screen),
            child: SmGlassCard(
              padding: const EdgeInsets.all(SmSpace.xl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(l10n.nameTitle, style: SmType.title),
                  const SizedBox(height: SmSpace.sm),
                  Text(l10n.nameSubtitle, style: SmType.caption),
                  const SizedBox(height: SmSpace.xl),
                  SmTextField(
                    controller: _name,
                    label: l10n.nameLabel,
                    autofocus: true,
                    onSubmitted: (_) => _save(),
                  ),
                  if (_failure != null) ...[
                    const SizedBox(height: SmSpace.md),
                    Text(
                      authFailureMessage(l10n, _failure!),
                      style: SmType.caption.copyWith(color: SmColors.danger),
                    ),
                  ],
                  const SizedBox(height: SmSpace.xl),
                  SmButton(
                    label: l10n.continueLabel,
                    onPressed: _busy ? null : _save,
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
