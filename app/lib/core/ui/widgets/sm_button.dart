import 'package:flutter/widgets.dart';

import '../tokens/tokens.dart';

/// Primary action button with a press-scale animation.
class SmButton extends StatefulWidget {
  const SmButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.secondary = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  /// Quiet glass style for actions that are not the screen's main one.
  final bool secondary;

  @override
  State<SmButton> createState() => _SmButtonState();
}

class _SmButtonState extends State<SmButton> {
  static const double _pressedScale = 0.96;
  static const double _disabledOpacity = 0.4;
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.onPressed == null) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;
    return Semantics(
      button: true,
      enabled: enabled,
      label: widget.label,
      child: GestureDetector(
        onTapDown: (_) => _setPressed(true),
        onTapCancel: () => _setPressed(false),
        onTapUp: (_) => _setPressed(false),
        onTap: widget.onPressed,
        child: AnimatedScale(
          scale: _pressed ? _pressedScale : 1,
          duration: SmMotion.of(context, SmMotion.fast),
          curve: SmMotion.enter,
          child: Opacity(
            opacity: enabled ? 1 : _disabledOpacity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: widget.secondary ? SmColors.glassFill : SmColors.accent,
                borderRadius: SmRadius.pill,
                border: widget.secondary
                    ? Border.all(color: SmColors.glassBorder)
                    : null,
              ),
              child: Center(
                widthFactor: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SmSpace.xl,
                    vertical: SmSpace.md,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(
                          widget.icon,
                          size: 20,
                          color: widget.secondary
                              ? SmColors.textPrimary
                              : SmColors.onAccent,
                        ),
                        const SizedBox(width: SmSpace.sm),
                      ],
                      Text(
                        widget.label,
                        style: widget.secondary
                            ? SmType.button.copyWith(
                                color: SmColors.textPrimary,
                              )
                            : SmType.button,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
