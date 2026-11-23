import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Hands a file to the person: saved somewhere they can reach, or shared.
abstract interface class FileSaver {
  /// Returns a short description of where the file went.
  Future<String> save(String filename, List<int> bytes);
}

/// Writes the file to a temporary folder and opens the system share sheet.
/// Not tried on a real device yet.
class ShareFileSaver implements FileSaver {
  const ShareFileSaver();

  @override
  Future<String> save(String filename, List<int> bytes) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
    return filename;
  }
}

/// The default: nothing can be saved. `main` swaps in [ShareFileSaver].
class NoFileSaver implements FileSaver {
  const NoFileSaver();

  @override
  Future<String> save(String filename, List<int> bytes) =>
      throw UnsupportedError('No file saver is configured.');
}

final fileSaverProvider = Provider<FileSaver>((ref) => const NoFileSaver());
