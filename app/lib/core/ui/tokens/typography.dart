import 'package:flutter/painting.dart';

import 'colors.dart';

/// Text styles, all in the bundled Vazirmatn so Persian looks the same on every
/// platform.
abstract final class SmType {
  static const String fontFamily = 'Vazirmatn';

  static const TextStyle hero = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.w800,
    height: 1.2,
    color: SmColors.textPrimary,
  );
  static const TextStyle display = TextStyle(
    fontFamily: fontFamily,
    fontSize: 34,
    fontWeight: FontWeight.w800,
    height: 1.25,
    color: SmColors.textPrimary,
  );
  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.35,
    color: SmColors.textPrimary,
  );
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.6,
    color: SmColors.textPrimary,
  );
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.5,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: SmColors.textSecondary,
  );
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: SmColors.onAccent,
  );
}
