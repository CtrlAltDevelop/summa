import 'dart:ui';

/// Every colour in the app. Widgets read these; hex literals live nowhere else.
abstract final class SmColors {
  static const Color backgroundTop = Color(0xFF0B1020);
  static const Color backgroundBottom = Color(0xFF151C3A);
  static const Color glowA = Color(0xFF3B82F6);
  static const Color glowB = Color(0xFF8B5CF6);

  static const Color accent = Color(0xFF5EEAD4);
  static const Color accentStrong = Color(0xFF2DD4BF);
  static const Color onAccent = Color(0xFF04201C);

  static const Color textPrimary = Color(0xFFF1F5F9);
  static const Color textSecondary = Color(0xFFA5B0C8);
  static const Color textMuted = Color(0xFF6B7794);

  static const Color glassFill = Color(0x14FFFFFF);
  static const Color glassBorder = Color(0x29FFFFFF);
  static const Color glassFillStrong = Color(0x24FFFFFF);

  static const Color success = Color(0xFF4ADE80);
  static const Color warning = Color(0xFFFBBF24);
  static const Color danger = Color(0xFFF87171);

  static const Color transparent = Color(0x00000000);
  static const Color shadow = Color(0x66000000);
}
