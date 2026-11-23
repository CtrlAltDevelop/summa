import 'package:flutter/material.dart';

import '../../core/ui/tokens/tokens.dart';

/// A wrapped row of single-select pills.
class Choices<T> extends StatelessWidget {
  const Choices({
    required this.values,
    required this.selected,
    required this.label,
    required this.onSelected,
    super.key,
  });

  final List<T> values;
  final T selected;
  final String Function(T) label;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: SmSpace.sm,
      runSpacing: SmSpace.sm,
      children: [
        for (final v in values)
          Semantics(
            button: true,
            selected: v == selected,
            label: label(v),
            child: GestureDetector(
              onTap: () => onSelected(v),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: v == selected ? SmColors.accent : SmColors.glassFill,
                  borderRadius: SmRadius.pill,
                  border: Border.all(color: SmColors.glassBorder),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SmSpace.lg,
                    vertical: SmSpace.sm,
                  ),
                  child: Text(
                    label(v),
                    style: SmType.caption.copyWith(
                      color: v == selected
                          ? SmColors.onAccent
                          : SmColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// A wrapped row of pills where any number can be selected.
class MultiChoices<T> extends StatelessWidget {
  const MultiChoices({
    required this.values,
    required this.selected,
    required this.label,
    required this.onToggle,
    super.key,
  });

  final List<T> values;
  final Set<T> selected;
  final String Function(T) label;
  final ValueChanged<T> onToggle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: SmSpace.sm,
      runSpacing: SmSpace.sm,
      children: [
        for (final v in values)
          Semantics(
            button: true,
            selected: selected.contains(v),
            label: label(v),
            child: GestureDetector(
              onTap: () => onToggle(v),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: selected.contains(v)
                      ? SmColors.accent
                      : SmColors.glassFill,
                  borderRadius: SmRadius.pill,
                  border: Border.all(color: SmColors.glassBorder),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SmSpace.lg,
                    vertical: SmSpace.sm,
                  ),
                  child: Text(
                    label(v),
                    style: SmType.caption.copyWith(
                      color: selected.contains(v)
                          ? SmColors.onAccent
                          : SmColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
