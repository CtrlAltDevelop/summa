import 'package:flutter/widgets.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';

/// Every shared widget in one place (`/debug/gallery`).
class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  static const int _sample = 12850000;
  num _value = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _value = _sample);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SmBackground(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(SmSpace.screen),
          children: [
            Text(l10n.galleryTitle, style: SmType.display),
            const SizedBox(height: SmSpace.xl),
            _Section(
              title: l10n.galleryButton,
              child: SmButton(
                label: l10n.healthRetry,
                icon: SmIcons.bolt,
                onPressed: () {},
              ),
            ),
            _Section(
              title: l10n.galleryCard,
              child: SmGlassCard(
                strong: true,
                child: Text(l10n.healthOk, style: SmType.body),
              ),
            ),
            _Section(
              title: l10n.galleryCount,
              child: SmCountUp(value: _value, format: formatNumber),
            ),
            _Section(
              title: l10n.galleryStatus,
              child: Wrap(
                spacing: SmSpace.sm,
                children: [
                  SmStatusPill(label: l10n.statusOk, status: SmStatus.success),
                  SmStatusPill(
                    label: l10n.statusWarn,
                    status: SmStatus.warning,
                  ),
                  SmStatusPill(label: l10n.statusBad, status: SmStatus.danger),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: SmSpace.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: SmType.caption),
          const SizedBox(height: SmSpace.sm),
          child,
        ],
      ),
    );
  }
}
