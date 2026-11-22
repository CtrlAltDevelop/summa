import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import 'auth_controller.dart';
import 'auth_messages.dart';
import 'auth_models.dart';

const int codeLength = 6;
const int resendSeconds = 60;
const int minPhoneDigits = 10;

/// Phone number, then the code sent to it.
class LoginFlowScreen extends ConsumerStatefulWidget {
  const LoginFlowScreen({super.key});

  @override
  ConsumerState<LoginFlowScreen> createState() => _LoginFlowScreenState();
}

class _LoginFlowScreenState extends ConsumerState<LoginFlowScreen> {
  final _phone = TextEditingController();
  final _code = TextEditingController();
  CodeChallenge? _challenge;
  bool _busy = false;
  AuthFailure? _failure;
  int _secondsLeft = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    _phone.dispose();
    _code.dispose();
    super.dispose();
  }

  bool get _phoneLooksValid =>
      toLatinDigits(_phone.text).replaceAll(RegExp(r'\D'), '').length >=
      minPhoneDigits;

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _secondsLeft = resendSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() => _secondsLeft = _secondsLeft - 1);
      if (_secondsLeft <= 0) timer.cancel();
    });
  }

  Future<void> _send() async {
    if (_busy) return;
    if (!_phoneLooksValid) {
      setState(() => _failure = AuthFailure.invalidPhone);
      return;
    }
    setState(() {
      _busy = true;
      _failure = null;
    });
    try {
      final challenge = await ref
          .read(authControllerProvider.notifier)
          .requestCode(_phone.text.trim());
      if (!mounted) return;
      _code.clear();
      setState(() => _challenge = challenge);
      _startCountdown();
    } on AuthException catch (e) {
      if (mounted) setState(() => _failure = e.failure);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _verify() async {
    final challenge = _challenge;
    if (_busy || challenge == null) return;
    setState(() {
      _busy = true;
      _failure = null;
    });
    try {
      await ref
          .read(authControllerProvider.notifier)
          .verifyCode(
            ticket: challenge.ticket,
            code: toLatinDigits(_code.text.trim()),
          );
    } on AuthException catch (e) {
      if (!mounted) return;
      _code.clear();
      setState(() => _failure = e.failure);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _onCodeChanged(String value) {
    if (toLatinDigits(value).trim().length == codeLength) _verify();
  }

  void _changeNumber() {
    _timer?.cancel();
    setState(() {
      _challenge = null;
      _failure = null;
      _secondsLeft = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final challenge = _challenge;
    return SmBackground(
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(SmSpace.screen),
            child: SmGlassCard(
              padding: const EdgeInsets.all(SmSpace.xl),
              child: AnimatedSwitcher(
                duration: SmMotion.of(context, SmMotion.medium),
                switchInCurve: SmMotion.enter,
                switchOutCurve: SmMotion.exit,
                child: challenge == null
                    ? _phoneStep(l10n)
                    : _codeStep(l10n, challenge),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _phoneStep(AppLocalizations l10n) {
    return Column(
      key: const ValueKey('phone'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(l10n.loginTitle, style: SmType.title),
        const SizedBox(height: SmSpace.sm),
        Text(l10n.loginSubtitle, style: SmType.caption),
        const SizedBox(height: SmSpace.xl),
        SmTextField(
          controller: _phone,
          label: l10n.phoneLabel,
          hint: l10n.phoneHint,
          keyboardType: TextInputType.phone,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          autofocus: true,
          onSubmitted: (_) => _send(),
        ),
        _ErrorLine(failure: _failure),
        const SizedBox(height: SmSpace.xl),
        SmButton(label: l10n.sendCode, onPressed: _busy ? null : _send),
      ],
    );
  }

  Widget _codeStep(AppLocalizations l10n, CodeChallenge challenge) {
    final canResend = _secondsLeft <= 0 && !_busy;
    return Column(
      key: const ValueKey('code'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(l10n.codeTitle, style: SmType.title),
        const SizedBox(height: SmSpace.sm),
        Text(
          l10n.codeSubtitle(toPersianDigits(challenge.destination)),
          style: SmType.caption,
        ),
        const SizedBox(height: SmSpace.xl),
        SmTextField(
          controller: _code,
          label: l10n.codeLabel,
          keyboardType: TextInputType.number,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          maxLength: codeLength,
          autofocus: true,
          onChanged: _onCodeChanged,
          onSubmitted: (_) => _verify(),
        ),
        _ErrorLine(failure: _failure),
        const SizedBox(height: SmSpace.xl),
        SmButton(label: l10n.verify, onPressed: _busy ? null : _verify),
        const SizedBox(height: SmSpace.lg),
        Center(
          child: canResend
              ? _LinkText(label: l10n.resend, onTap: _send)
              : Text(
                  _secondsLeft > 0
                      ? l10n.resendIn(toPersianDigits('$_secondsLeft'))
                      : '',
                  style: SmType.caption,
                ),
        ),
        const SizedBox(height: SmSpace.sm),
        Center(
          child: _LinkText(label: l10n.changeNumber, onTap: _changeNumber),
        ),
      ],
    );
  }
}

class _ErrorLine extends StatelessWidget {
  const _ErrorLine({required this.failure});

  final AuthFailure? failure;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AnimatedSize(
      duration: SmMotion.of(context, SmMotion.fast),
      child: failure == null
          ? const SizedBox(width: double.infinity)
          : Padding(
              padding: const EdgeInsets.only(top: SmSpace.md),
              child: Text(
                authFailureMessage(l10n, failure!),
                style: SmType.caption.copyWith(color: SmColors.danger),
              ),
            ),
    );
  }
}

class _LinkText extends StatelessWidget {
  const _LinkText({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(SmSpace.sm),
          child: Text(
            label,
            style: SmType.caption.copyWith(color: SmColors.accent),
          ),
        ),
      ),
    );
  }
}
