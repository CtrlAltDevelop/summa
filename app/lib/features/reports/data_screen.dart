import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/storage/file_saver.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../auth/auth_controller.dart';
import '../categories/category_controller.dart';
import '../lock/strong_auth.dart';
import '../wallets/ledger_controller.dart';
import '../wallets/wallets_controller.dart';
import 'report_api.dart';
import 'report_controller.dart';

const _shownErrors = 20;

/// Export the ledger as CSV and import a CSV. Every step first proves the
/// person is the owner (biometrics, or the app passcode).
class DataScreen extends ConsumerStatefulWidget {
  const DataScreen({super.key});

  @override
  ConsumerState<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends ConsumerState<DataScreen> {
  final _csv = TextEditingController();
  String? _message;
  bool _isError = false;
  ImportOutcome? _preview;
  bool _busy = false;

  @override
  void dispose() {
    _csv.dispose();
    super.dispose();
  }

  void _say(String text, {bool error = false}) {
    if (!mounted) return;
    setState(() {
      _message = text;
      _isError = error;
    });
  }

  /// Runs [action] only after strong authentication.
  Future<void> _guarded(Future<void> Function() action) async {
    final l10n = AppLocalizations.of(context);
    setState(() => _busy = true);
    try {
      final proven = await confirmStrongAuth(context, ref);
      if (!proven) {
        _say(l10n.dataDenied, error: true);
        return;
      }
      await action();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _export() => _guarded(() async {
    final l10n = AppLocalizations.of(context);
    try {
      final file = await ref
          .read(authControllerProvider.notifier)
          .withAccess((a) => ref.read(reportApiProvider).exportCsv(a));
      final where = await ref
          .read(fileSaverProvider)
          .save(file.filename, file.bytes);
      _say(l10n.dataExported(where));
    } on Exception {
      _say(l10n.dataExportFailed, error: true);
    }
  });

  Future<ImportOutcome?> _send({required bool commit}) async {
    final l10n = AppLocalizations.of(context);
    try {
      return await ref
          .read(authControllerProvider.notifier)
          .withAccess(
            (a) => ref
                .read(reportApiProvider)
                .importCsv(a, _csv.text, commit: commit),
          );
    } on Exception {
      _say(l10n.dataImportFailed, error: true);
      return null;
    }
  }

  Future<void> _check() => _guarded(() async {
    final result = await _send(commit: false);
    if (result == null || !mounted) return;
    setState(() {
      _preview = result;
      _message = null;
    });
  });

  Future<void> _commit() => _guarded(() async {
    final l10n = AppLocalizations.of(context);
    final result = await _send(commit: true);
    if (result == null || !mounted) return;
    if (result.errors.isNotEmpty) {
      setState(() => _preview = result);
      return;
    }
    ref
      ..invalidate(ledgerControllerProvider)
      ..invalidate(walletsControllerProvider)
      ..invalidate(categoriesControllerProvider);
    setState(() => _preview = null);
    _csv.clear();
    _say(l10n.dataImported(toPersianDigits('${result.imported}')));
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final preview = _preview;
    final clean =
        preview != null && preview.errors.isEmpty && preview.importable > 0;
    return SmScreen(
      title: l10n.dataTitle,
      children: [
        SmButton(label: l10n.dataExport, onPressed: _busy ? null : _export),
        const SizedBox(height: SmSpace.xl),
        Text(l10n.dataImportTitle, style: SmType.caption),
        const SizedBox(height: SmSpace.sm),
        SmTextField(
          controller: _csv,
          label: l10n.dataImportHint,
          maxLines: 8,
          textDirection: TextDirection.ltr,
          onChanged: (_) => setState(() => _preview = null),
        ),
        const SizedBox(height: SmSpace.md),
        SmButton(
          label: l10n.dataPreview,
          onPressed: _busy || _csv.text.trim().isEmpty ? null : _check,
        ),
        if (preview != null) ...[
          const SizedBox(height: SmSpace.md),
          Text(
            l10n.dataPreviewResult(
              toPersianDigits('${preview.rows}'),
              toPersianDigits('${preview.importable}'),
              toPersianDigits('${preview.skipped}'),
            ),
            style: SmType.body,
          ),
          for (final e in preview.errors.take(_shownErrors))
            Text(
              l10n.dataLineError(toPersianDigits('${e.line}'), e.message),
              style: SmType.caption.copyWith(color: SmColors.danger),
            ),
        ],
        if (clean) ...[
          const SizedBox(height: SmSpace.md),
          SmButton(label: l10n.dataImport, onPressed: _busy ? null : _commit),
        ],
        if (_message != null) ...[
          const SizedBox(height: SmSpace.lg),
          Text(
            _message!,
            style: SmType.body.copyWith(
              color: _isError ? SmColors.danger : SmColors.success,
            ),
          ),
        ],
      ],
    );
  }
}
