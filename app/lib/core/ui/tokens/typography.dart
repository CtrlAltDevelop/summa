import 'package:flutter/painting.dart';

import 'colors.dart';

/// Text styles. No font file is bundled yet, so the platform's Persian-capable
/// system font is used.
abstract final class SmType {
  static const TextStyle display = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w800,
    height: 1.25,
    color: SmColors.textPrimary,
  );
  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.35,
    color: SmColors.textPrimary,
  );
  static const TextStyle body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.6,
    color: SmColors.textPrimary,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 12.5,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: SmColors.textSecondary,
  );
  static const TextStyle button = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: SmColors.onAccent,
  );
}
