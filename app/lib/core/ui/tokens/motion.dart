import 'package:flutter/widgets.dart';

/// Durations and curves. Every animation takes its timing from here and
/// collapses to zero when the system asks for reduced motion.
abstract final class SmMotion {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 600);

  static const Curve enter = Curves.easeOutCubic;
  static const Curve exit = Curves.easeInCubic;
  static const Curve emphasis = Curves.easeInOutCubicEmphasized;

  /// [base] unless the user prefers reduced motion.
  static Duration of(BuildContext context, Duration base) =>
      MediaQuery.disableAnimationsOf(context) ? Duration.zero : base;
}
