import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import 'health_service.dart';

/// Phase 00 demo: the app calls the backend over gRPC and shows the answer.
class HealthScreen extends ConsumerWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final result = ref.watch(healthCheckProvider);
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
                  Text(l10n.healthTitle, style: SmType.title),
                  const SizedBox(height: SmSpace.lg),
                  _AnimatedState(
                    child: result.when(
                      loading: () => _Message(
                        key: const ValueKey('loading'),
                        text: l10n.healthChecking,
                      ),
                      error: (_, _) => _Message(
                        key: const ValueKey('error'),
                        text: l10n.healthFailed,
                        status: SmStatus.danger,
                      ),
                      data: (r) => r.ok
                          ? _Message(
                              key: const ValueKey('ok'),
                              text: l10n.healthOk,
                              status: SmStatus.success,
                              detail: l10n.healthLatency(
                                toPersianDigits('${r.latency.inMilliseconds}'),
                              ),
                            )
                          : _Message(
                              key: const ValueKey('down'),
                              text: l10n.healthFailed,
                              status: SmStatus.danger,
                            ),
                    ),
                  ),
                  const SizedBox(height: SmSpace.xl),
                  SmButton(
                    label: l10n.healthRetry,
                    icon: SmIcons.refresh,
                    onPressed: result.isLoading
                        ? null
                        : () => ref.invalidate(healthCheckProvider),
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

class _AnimatedState extends StatelessWidget {
  const _AnimatedState({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: SmMotion.of(context, SmMotion.medium),
      switchInCurve: SmMotion.enter,
      switchOutCurve: SmMotion.exit,
      child: child,
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.text, this.status, this.detail, super.key});

  final String text;
  final SmStatus? status;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (status != null) ...[
          SmStatusPill(label: text, status: status!),
        ] else
          Text(text, style: SmType.body),
        if (detail != null) ...[
          const SizedBox(height: SmSpace.sm),
          Text(detail!, style: SmType.caption),
        ],
      ],
    );
  }
}
