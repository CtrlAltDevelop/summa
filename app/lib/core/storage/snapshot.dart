import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/wallets/wallet_models.dart';
import 'key_value_store.dart';

/// Loads fresh data and remembers it; with no connection, serves the last
/// copy that was remembered. Any other failure is passed on untouched.
Future<T> withSnapshot<T>(
  Ref ref,
  String key, {
  required Future<T> Function() load,
  required Object Function(T) encode,
  required T Function(Object?) decode,
}) async {
  final store = ref.read(keyValueStoreProvider);
  try {
    final fresh = await load();
    await store.write(key, jsonEncode(encode(fresh)));
    return fresh;
  } on WalletException catch (e) {
    if (e.failure != WalletFailure.offline) rethrow;
    final raw = await store.read(key);
    if (raw == null) rethrow;
    return decode(jsonDecode(raw));
  }
}
