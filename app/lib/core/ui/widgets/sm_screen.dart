import 'package:flutter/material.dart' show BackButton;
import 'package:flutter/widgets.dart';

import '../tokens/tokens.dart';
import 'sm_background.dart';

/// A pushed page: back button and title on top, the content below it easing
/// in one piece after another.
class SmScreen extends StatelessWidget {
  const SmScreen({required this.title, required this.children, super.key});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final canPop = ModalRoute.of(context)?.canPop ?? false;
    return SmBackground(
      showBack: false,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                SmSpace.sm,
                SmSpace.sm,
                SmSpace.screen,
                0,
              ),
              child: Row(
                children: [
                  if (canPop) const BackButton(color: SmColors.textPrimary),
                  if (!canPop) const SizedBox(width: SmSpace.md),
                  Expanded(child: Text(title, style: SmType.title)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(SmSpace.screen),
                children: [
                  for (final (i, child) in children.indexed)
                    _Reveal(index: i, child: child),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Fades and lifts its child in; later children take a little longer.
class _Reveal extends StatelessWidget {
  const _Reveal({required this.index, required this.child});

  final int index;
  final Widget child;

  static const int _maxStaggered = 8;
  static const int _stepMs = 45;
  static const int _baseMs = 280;
  static const double _lift = 12;

  @override
  Widget build(BuildContext context) {
    final extra = (index < _maxStaggered ? index : _maxStaggered) * _stepMs;
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: SmMotion.of(context, Duration(milliseconds: _baseMs + extra)),
      curve: SmMotion.enter,
      child: child,
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(
          offset: Offset(0, (1 - t) * _lift),
          child: child,
        ),
      ),
    );
  }
}
