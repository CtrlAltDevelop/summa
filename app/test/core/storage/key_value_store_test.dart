import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:summa/core/storage/key_value_store.dart';

void main() {
  late Directory dir;

  setUp(() => dir = Directory.systemTemp.createTempSync('summa_kv_'));
  tearDown(() => dir.deleteSync(recursive: true));

  test('a missing key reads as null', () async {
    expect(await FileKeyValueStore(dir).read('nothing'), isNull);
  });

  test('what is written can be read back, also by a new instance', () async {
    await FileKeyValueStore(dir).write('outbox', '{"a":1}');

    expect(await FileKeyValueStore(dir).read('outbox'), '{"a":1}');
  });

  test('persian text survives', () async {
    final store = FileKeyValueStore(dir);
    await store.write('k', 'خرید نان ۲۵۰٬۰۰۰');

    expect(await store.read('k'), 'خرید نان ۲۵۰٬۰۰۰');
  });

  test(
    'an overwrite replaces the value and leaves no temporary file',
    () async {
      final store = FileKeyValueStore(dir);
      await store.write('k', 'one');
      await store.write('k', 'two');

      expect(await store.read('k'), 'two');
      expect(dir.listSync().map((e) => e.path.split('/').last), ['k.json']);
    },
  );

  test('delete removes the key and tolerates a missing one', () async {
    final store = FileKeyValueStore(dir);
    await store.write('k', 'v');

    await store.delete('k');
    await store.delete('k');

    expect(await store.read('k'), isNull);
  });

  test('a key cannot escape the directory', () async {
    final store = FileKeyValueStore(dir);
    await store.write('../escape', 'v');

    expect(await store.read('../escape'), 'v');
    expect(dir.listSync(), hasLength(1));
    expect(File('${dir.parent.path}/escape.json').existsSync(), isFalse);
  });

  test('the in-memory store behaves the same way', () async {
    final store = MemoryKeyValueStore();
    expect(await store.read('k'), isNull);
    await store.write('k', 'v');
    expect(await store.read('k'), 'v');
    await store.delete('k');
    expect(await store.read('k'), isNull);
  });
}
