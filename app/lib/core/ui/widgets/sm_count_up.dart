import 'package:flutter/widgets.dart';

import '../tokens/tokens.dart';

/// Animates a number from its previous value to [value]; [format] turns the
/// in-between values into text (so the caller owns digits and separators).
class SmCountUp extends StatelessWidget {
  const SmCountUp({
    required this.value,
    required this.format,
    this.style = SmType.display,
    super.key,
  });

  final num value;
  final String Function(num value) format;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(end: value.toDouble()),
      duration: SmMotion.of(context, SmMotion.slow),
      curve: SmMotion.emphasis,
      builder: (context, current, _) => Text(format(current), style: style),
    );
  }
}
