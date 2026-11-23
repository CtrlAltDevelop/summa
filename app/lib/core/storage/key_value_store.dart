import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Small persistent text storage: the offline outbox and cached snapshots.
abstract interface class KeyValueStore {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<void> delete(String key);
}

/// Lives as long as the process; the default, and what tests use.
class MemoryKeyValueStore implements KeyValueStore {
  final Map<String, String> _data = {};

  @override
  Future<String?> read(String key) async => _data[key];

  @override
  Future<void> write(String key, String value) async => _data[key] = value;

  @override
  Future<void> delete(String key) async => _data.remove(key);
}

/// One file per key inside [directory], written atomically (write then rename)
/// so a crash cannot leave half a file. The files are not encrypted yet; the
/// app directory is sandboxed, and encryption comes with the app lock.
class FileKeyValueStore implements KeyValueStore {
  FileKeyValueStore(this.directory);

  final Directory directory;

  File _file(String key) {
    final safe = key.replaceAll(RegExp(r'[^A-Za-z0-9_.-]'), '_');
    return File('${directory.path}/$safe.json');
  }

  @override
  Future<String?> read(String key) async {
    final file = _file(key);
    return await file.exists() ? file.readAsString() : null;
  }

  @override
  Future<void> write(String key, String value) async {
    await directory.create(recursive: true);
    final target = _file(key);
    final temp = File('${target.path}.tmp');
    await temp.writeAsString(value, flush: true);
    await temp.rename(target.path);
  }

  @override
  Future<void> delete(String key) async {
    final file = _file(key);
    if (await file.exists()) await file.delete();
  }
}

final keyValueStoreProvider = Provider<KeyValueStore>(
  (ref) => MemoryKeyValueStore(),
);
