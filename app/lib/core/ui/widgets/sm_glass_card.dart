import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../tokens/tokens.dart';

/// A frosted-glass panel.
class SmGlassCard extends StatelessWidget {
  const SmGlassCard({
    required this.child,
    this.padding = const EdgeInsets.all(SmSpace.lg),
    this.strong = false,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool strong;

  static const double _blur = 24;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: SmRadius.lg,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _blur, sigmaY: _blur),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: strong ? SmColors.glassFillStrong : null,
            gradient: strong
                ? null
                : const LinearGradient(
                    begin: AlignmentDirectional.topStart,
                    end: AlignmentDirectional.bottomEnd,
                    colors: [SmColors.glassGlow, SmColors.glassFill],
                  ),
            borderRadius: SmRadius.lg,
            border: Border.all(color: SmColors.glassBorder),
          ),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}
