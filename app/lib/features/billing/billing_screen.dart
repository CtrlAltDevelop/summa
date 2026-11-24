import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import 'billing_controller.dart';
import 'billing_models.dart';

/// Subscription status, the trial, and buying a plan.
class BillingScreen extends ConsumerStatefulWidget {
  const BillingScreen({super.key});

  @override
  ConsumerState<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends ConsumerState<BillingScreen> {
  Checkout? _pending;
  String? _message;
  bool _busy = false;

  Future<void> _run(Future<void> Function() action) async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      await action();
    } on Exception {
      if (mounted) setState(() => _message = l10n.billingFailed);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final status = ref.watch(subscriptionStatusProvider).value;
    final plans = ref.watch(plansProvider).value ?? const <PlanInfo>[];
    return SmScreen(
      title: l10n.billingTitle,
      children: [
        if (status != null)
          SmGlassCard(
            padding: const EdgeInsets.all(SmSpace.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(_statusText(l10n, status), style: SmType.body),
                if (status.trialAvailable) ...[
                  const SizedBox(height: SmSpace.md),
                  SmButton(
                    label: l10n.billingStartTrial,
                    onPressed: _busy ? null : () => _run(() => startTrial(ref)),
                  ),
                ],
              ],
            ),
          ),
        const SizedBox(height: SmSpace.lg),
        if (plans.isEmpty)
          Text(l10n.billingNoPlans, style: SmType.caption)
        else
          for (final p in plans)
            Padding(
              padding: const EdgeInsets.only(bottom: SmSpace.sm),
              child: SmGlassCard(
                padding: const EdgeInsets.all(SmSpace.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(p.name, style: SmType.body),
                    Text(
                      l10n.billingPlanLine(
                        formatNumber(p.priceMinor),
                        localDigits('${p.periodDays}'),
                      ),
                      style: SmType.caption,
                    ),
                    if (p.description.isNotEmpty)
                      Text(p.description, style: SmType.caption),
                    const SizedBox(height: SmSpace.md),
                    SmButton(
                      label: l10n.billingBuy,
                      onPressed: _busy
                          ? null
                          : () => _run(() async {
                              final c = await checkout(ref, p.code);
                              if (mounted) setState(() => _pending = c);
                            }),
                    ),
                  ],
                ),
              ),
            ),
        if (_pending != null) ...[
          const SizedBox(height: SmSpace.lg),
          SmGlassCard(
            padding: const EdgeInsets.all(SmSpace.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l10n.billingPayAt, style: SmType.caption),
                Text(
                  _pending!.payUrl,
                  style: SmType.body,
                  textDirection: TextDirection.ltr,
                ),
                const SizedBox(height: SmSpace.md),
                SmButton(
                  label: l10n.billingCheckPayment,
                  onPressed: _busy
                      ? null
                      : () => _run(() async {
                          final s = await verify(ref, _pending!.reference);
                          if (!mounted) return;
                          setState(() {
                            if (s.status == 'active') {
                              _pending = null;
                            } else {
                              _message = l10n.billingNotConfirmed;
                            }
                          });
                        }),
                ),
              ],
            ),
          ),
        ],
        if (_message != null) ...[
          const SizedBox(height: SmSpace.md),
          Text(
            _message!,
            style: SmType.caption.copyWith(color: SmColors.warning),
          ),
        ],
      ],
    );
  }

  String _statusText(AppLocalizations l10n, SubscriptionStatus s) {
    final days = localDigits('${s.daysLeft}');
    return switch (s.status) {
      'trial' => l10n.billingStatusTrial(days),
      'active' => l10n.billingStatusActive(days),
      'expired' => l10n.billingStatusExpired,
      _ => l10n.billingStatusNone,
    };
  }
}

/// Shown on the home screen when the server has made the account read-only.
class ReadOnlyBanner extends ConsumerWidget {
  const ReadOnlyBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final status = ref.watch(subscriptionStatusProvider).value;
    if (status == null || status.canWrite) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: SmSpace.lg),
      child: SmGlassCard(
        padding: const EdgeInsets.all(SmSpace.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.readOnlyBanner,
              style: SmType.body.copyWith(color: SmColors.warning),
            ),
            const SizedBox(height: SmSpace.md),
            SmButton(
              label: l10n.readOnlyRenew,
              onPressed: () => Navigator.of(context).push(
                PageRouteBuilder<void>(
                  pageBuilder: (_, _, _) => const BillingScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
