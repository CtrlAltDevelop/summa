import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'core/storage/key_value_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Where the offline outbox and the cached snapshots live on this device.
  final directory = await getApplicationSupportDirectory();
  runApp(
    ProviderScope(
      overrides: [
        keyValueStoreProvider.overrideWithValue(FileKeyValueStore(directory)),
      ],
      child: const SummaApp(),
    ),
  );
}
