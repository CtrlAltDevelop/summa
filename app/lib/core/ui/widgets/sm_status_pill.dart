import 'package:flutter/widgets.dart';

import '../tokens/tokens.dart';

enum SmStatus { success, warning, danger }

/// Small coloured pill with a label.
class SmStatusPill extends StatelessWidget {
  const SmStatusPill({required this.label, required this.status, super.key});

  final String label;
  final SmStatus status;

  static const double _fillAlpha = 0.16;

  Color get _color => switch (status) {
    SmStatus.success => SmColors.success,
    SmStatus.warning => SmColors.warning,
    SmStatus.danger => SmColors.danger,
  };

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _color.withValues(alpha: _fillAlpha),
        borderRadius: SmRadius.pill,
        border: Border.all(color: _color),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SmSpace.md,
          vertical: SmSpace.xs,
        ),
        child: Text(label, style: SmType.caption.copyWith(color: _color)),
      ),
    );
  }
}
