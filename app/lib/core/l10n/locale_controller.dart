import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../format/persian.dart';
import '../storage/key_value_store.dart';

const _storageKey = 'locale';
const supportedLanguages = ['fa', 'en'];

/// The language to start in before anything is stored: the device's, if the
/// app has it, else Persian. `main` overrides [initialLocaleProvider] with it.
Locale deviceLocale(Locale device) =>
    supportedLanguages.contains(device.languageCode)
    ? Locale(device.languageCode)
    : const Locale('fa');

final initialLocaleProvider = Provider<Locale>((_) => const Locale('fa'));

/// The language the app shows; the choice is kept on the device.
final localeProvider = NotifierProvider<LocaleController, Locale>(
  LocaleController.new,
);

class LocaleController extends Notifier<Locale> {
  @override
  Locale build() {
    final initial = ref.read(initialLocaleProvider);
    setFormatLanguage(initial.languageCode);
    _restore();
    return initial;
  }

  Future<void> _restore() async {
    final stored = await ref.read(keyValueStoreProvider).read(_storageKey);
    if (stored == null || !supportedLanguages.contains(stored)) return;
    if (stored != state.languageCode) _apply(Locale(stored));
  }

  void _apply(Locale locale) {
    setFormatLanguage(locale.languageCode);
    state = locale;
  }

  Future<void> select(Locale locale) async {
    _apply(locale);
    await ref
        .read(keyValueStoreProvider)
        .write(_storageKey, locale.languageCode);
  }
}
