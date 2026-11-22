import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// UI values come from the design tokens. This keeps raw colours, radii and
/// icons out of every file except `lib/core/ui/tokens`.
void main() {
  const forbidden = <String, String>{
    r'Color\(0x': 'hex colour (use SmColors)',
    r'\bColors\.': 'Material Colors (use SmColors)',
    r'BorderRadius\.circular': 'raw radius (use SmRadius)',
    r'\bIcons\.': 'Material icon (use SmIcons)',
  };

  test('no raw colours, radii or icons outside core/ui/tokens', () {
    final offenders = <String>[];
    for (final entity in Directory('lib').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      final path = entity.path;
      final skip =
          path.startsWith('lib/gen/') ||
          path.startsWith('lib/l10n/gen/') ||
          path.startsWith('lib/core/ui/tokens/');
      if (skip) continue;
      final lines = entity.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        forbidden.forEach((pattern, why) {
          if (RegExp(pattern).hasMatch(lines[i])) {
            offenders.add('$path:${i + 1}: $why');
          }
        });
      }
    }
    expect(offenders, isEmpty, reason: offenders.join('\n'));
  });
}
