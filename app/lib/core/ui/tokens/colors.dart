import 'dart:ui';

/// Every colour in the app. Widgets read these; hex literals live nowhere else.
abstract final class SmColors {
  static const Color backgroundTop = Color(0xFF0A0A0B);
  static const Color backgroundBottom = Color(0xFF141417);
  static const Color glowA = Color(0xFFF5B63A);
  static const Color glowB = Color(0xFFB45309);

  static const Color accent = Color(0xFFF7C759);
  static const Color accentStrong = Color(0xFFE5A92B);
  static const Color onAccent = Color(0xFF1F1500);

  static const Color textPrimary = Color(0xFFF1F5F9);
  static const Color textSecondary = Color(0xFFA5B0C8);
  static const Color textMuted = Color(0xFF6B7794);

  static const Color glassFill = Color(0x0DFFFFFF);
  static const Color glassBorder = Color(0x1AFFFFFF);
  static const Color glassFillStrong = Color(0x24FFFFFF);

  /// Warm tint at a glass card's top corner.
  static const Color glassGlow = Color(0x1AF7C759);

  static const Color success = Color(0xFF4ADE80);
  static const Color warning = Color(0xFFFBBF24);
  static const Color danger = Color(0xFFF87171);

  static const Color transparent = Color(0x00000000);
  static const Color shadow = Color(0x66000000);
}
