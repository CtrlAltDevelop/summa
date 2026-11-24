import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'dart:ui';

import 'package:summa/core/format/persian.dart';
import 'package:summa/core/l10n/locale_controller.dart';
import 'package:summa/core/storage/key_value_store.dart';

void main() {
  tearDown(() => setFormatLanguage('fa'));

  test('English formats digits, separators and months in Latin', () {
    setFormatLanguage('en');
    final date = DateTime(2026, 11, 22); // 1 Azar 1405
    expect(formatNumber(-1234567), '-1,234,567');
    expect(formatJalaliDate(date), '1405/09/01');
    expect(formatJalaliLong(date), '1 Azar 1405');
    expect(formatQuantity('0.5'), '0.5');
  });

  test('Persian keeps Persian digits and separators', () {
    setFormatLanguage('fa');
    expect(formatNumber(1234567), '۱٬۲۳۴٬۵۶۷');
    expect(formatQuantity('0.5'), '۰٫۵');
  });

  test('the chosen language is kept and restored', () async {
    final store = MemoryKeyValueStore();
    final first = ProviderContainer(
      overrides: [keyValueStoreProvider.overrideWithValue(store)],
    );
    addTearDown(first.dispose);
    await first.read(localeProvider.notifier).select(const Locale('en'));
    expect(first.read(localeProvider), const Locale('en'));

    final second = ProviderContainer(
      overrides: [keyValueStoreProvider.overrideWithValue(store)],
    );
    addTearDown(second.dispose);
    second.read(localeProvider);
    await Future<void>.delayed(Duration.zero);
    expect(second.read(localeProvider), const Locale('en'));
  });

  test('the device language is used only when the app has it', () {
    expect(deviceLocale(const Locale('en', 'US')), const Locale('en'));
    expect(deviceLocale(const Locale('de')), const Locale('fa'));
  });
}
