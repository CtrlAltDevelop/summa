import 'package:flutter/material.dart';

import 'tokens/tokens.dart';

/// The single dark glass theme.
ThemeData buildSummaTheme() {
  final scheme =
      ColorScheme.fromSeed(
        seedColor: SmColors.accent,
        brightness: Brightness.dark,
      ).copyWith(
        primary: SmColors.accent,
        onPrimary: SmColors.onAccent,
        surface: SmColors.backgroundTop,
        error: SmColors.danger,
      );
  return ThemeData(
    useMaterial3: true,
    fontFamily: SmType.fontFamily,
    colorScheme: scheme,
    scaffoldBackgroundColor: SmColors.transparent,
    textTheme: const TextTheme(
      displayLarge: SmType.display,
      titleLarge: SmType.title,
      bodyMedium: SmType.body,
      bodySmall: SmType.caption,
    ),
  );
}
