import 'package:flutter/widgets.dart';

import '../tokens/tokens.dart';

/// Full-screen gradient with two soft glows; the stage the glass sits on.
class SmBackground extends StatelessWidget {
  const SmBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [SmColors.backgroundTop, SmColors.backgroundBottom],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const _Glow(
            alignment: AlignmentDirectional.topEnd,
            color: SmColors.glowA,
          ),
          const _Glow(
            alignment: AlignmentDirectional.bottomStart,
            color: SmColors.glowB,
          ),
          child,
        ],
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.alignment, required this.color});

  final AlignmentGeometry alignment;
  final Color color;

  static const double _size = 320;
  static const double _alpha = 0.22;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: IgnorePointer(
        child: Container(
          width: _size,
          height: _size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color.withValues(alpha: _alpha),
                SmColors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
