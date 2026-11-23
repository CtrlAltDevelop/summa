import 'package:flutter/material.dart';

import '../tokens/tokens.dart';

/// Full-screen gradient with two soft glows; the stage the glass sits on.
class SmBackground extends StatelessWidget {
  const SmBackground({
    required this.child,
    this.maxWidth = 640,
    this.showBack = true,
    super.key,
  });

  /// Widest the content column grows on big windows.
  final double maxWidth;

  /// Screens that draw their own header (see SmScreen) turn this off.
  final bool showBack;

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
          // Inputs and ink need a Material ancestor; this one paints nothing.
          Material(
            type: MaterialType.transparency,
            child: _withBackButton(context),
          ),
        ],
      ),
    );
  }

  /// Pushed screens all sit on this stage, so the back button lives here.
  Widget _withBackButton(BuildContext context) {
    // Wide windows: keep a readable column instead of stretching edge to edge.
    final column = Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: _stack(context),
      ),
    );
    return column;
  }

  Widget _stack(BuildContext context) {
    if (!showBack || !(ModalRoute.of(context)?.canPop ?? false)) return child;
    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: const Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SmSpace.sm),
              child: BackButton(color: SmColors.textPrimary),
            ),
          ),
        ),
        Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: child,
          ),
        ),
      ],
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
