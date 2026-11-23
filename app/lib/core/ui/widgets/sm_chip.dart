import 'package:flutter/widgets.dart';

import '../tokens/tokens.dart';

/// Neutral pill for a secondary figure (an equivalent value, a tag).
class SmChip extends StatelessWidget {
  const SmChip(this.label, {this.selected = false, super.key});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: selected ? SmColors.accent : SmColors.glassFill,
        borderRadius: SmRadius.pill,
        border: Border.all(
          color: selected ? SmColors.accent : SmColors.glassBorder,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SmSpace.md,
          vertical: SmSpace.xs,
        ),
        child: Text(
          label,
          style: selected
              ? SmType.caption.copyWith(color: SmColors.onAccent)
              : SmType.caption,
        ),
      ),
    );
  }
}
