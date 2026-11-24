import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> _arb(String lang) =>
    jsonDecode(File('lib/l10n/app_$lang.arb').readAsStringSync())
        as Map<String, dynamic>;

Set<String> _keys(Map<String, dynamic> arb) =>
    arb.keys.where((k) => !k.startsWith('@')).toSet();

final _persian = RegExp('[؀-ۿ]');

void main() {
  final fa = _arb('fa');
  final en = _arb('en');

  test('app_en.arb has every key app_fa.arb has, and no extras', () {
    expect(_keys(fa).difference(_keys(en)), isEmpty);
    expect(_keys(en).difference(_keys(fa)), isEmpty);
  });

  test('English strings keep the Persian placeholders', () {
    final holder = RegExp(r'\{(\w+)\}');
    for (final key in _keys(fa)) {
      final a = holder.allMatches(fa[key] as String).map((m) => m[1]).toSet();
      final b = holder.allMatches(en[key] as String).map((m) => m[1]).toSet();
      expect(b, a, reason: key);
    }
  });

  test('no Persian is left in English strings (except the language names)', () {
    const allowed = {'languageFa'};
    for (final key in _keys(en).difference(allowed)) {
      expect(_persian.hasMatch(en[key] as String), isFalse, reason: key);
    }
  });
}
