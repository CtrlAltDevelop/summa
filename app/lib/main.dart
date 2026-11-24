import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'core/l10n/locale_controller.dart';
import 'core/storage/file_saver.dart';
import 'core/storage/key_value_store.dart';
import 'features/lock/authenticator.dart';
import 'features/lock/secret_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Where the offline outbox and the cached snapshots live on this device.
  final directory = await getApplicationSupportDirectory();
  runApp(
    ProviderScope(
      overrides: [
        initialLocaleProvider.overrideWithValue(
          deviceLocale(PlatformDispatcher.instance.locale),
        ),
        secretStoreProvider.overrideWithValue(const SecureSecretStore()),
        fileSaverProvider.overrideWithValue(const ShareFileSaver()),
        authenticatorProvider.overrideWithValue(LocalAuthAuthenticator()),
        keyValueStoreProvider.overrideWithValue(FileKeyValueStore(directory)),
      ],
      child: const SummaApp(),
    ),
  );
}
