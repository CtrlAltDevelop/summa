import 'package:grpc/grpc.dart';

import '../../gen/apps/reports/grpc/reports.pbgrpc.dart' as pb;
import '../wallets/grpc_guard.dart';
import 'report_models.dart';

class ExportFile {
  const ExportFile({required this.filename, required this.bytes});

  final String filename;
  final List<int> bytes;
}

class ImportLineError {
  const ImportLineError({required this.line, required this.message});

  final int line;
  final String message;
}

/// What an import (or its preview) found. Nothing was imported if [errors]
/// is not empty.
class ImportOutcome {
  const ImportOutcome({
    required this.rows,
    required this.importable,
    required this.imported,
    required this.skipped,
    required this.errors,
  });

  final int rows;
  final int importable;
  final int imported;
  final int skipped;
  final List<ImportLineError> errors;
}

abstract interface class ReportApi {
  Future<ExportFile> exportCsv(String access);

  /// A preview ([commit] false) only counts and checks.
  Future<ImportOutcome> importCsv(
    String access,
    String text, {
    required bool commit,
  });

  Future<Report> monthly(
    String access, {
    required DateTime start,
    required DateTime end,
    required String currency,
  });
}

class GrpcReportApi implements ReportApi {
  GrpcReportApi(ClientChannel channel)
    : _client = pb.ReportsControllerClient(channel);

  final pb.ReportsControllerClient _client;

  static CallOptions _bearer(String token) =>
      CallOptions(metadata: {'authorization': 'Bearer $token'});

  @override
  Future<ExportFile> exportCsv(String access) => guardGrpc(() async {
    final r = await _client.exportCsv(
      pb.ExportRequest(),
      options: _bearer(access),
    );
    return ExportFile(filename: r.filename, bytes: r.content);
  });

  @override
  Future<ImportOutcome> importCsv(
    String access,
    String text, {
    required bool commit,
  }) => guardGrpc(() async {
    final r = await _client.importCsv(
      pb.ImportRequest(text: text, commit: commit),
      options: _bearer(access),
    );
    return ImportOutcome(
      rows: r.rows,
      importable: r.importable,
      imported: r.imported,
      skipped: r.skipped,
      errors: [
        for (final e in r.errors)
          ImportLineError(line: e.line, message: e.message),
      ],
    );
  });

  @override
  Future<Report> monthly(
    String access, {
    required DateTime start,
    required DateTime end,
    required String currency,
  }) => guardGrpc(() async {
    final r = await _client.monthly(
      pb.ReportRequest(
        startsAt: start.toUtc().toIso8601String(),
        endsAt: end.toUtc().toIso8601String(),
        currency: currency,
      ),
      options: _bearer(access),
    );
    return Report(
      currency: r.currency,
      incomeMinor: r.incomeMinor.toInt(),
      expenseMinor: r.expenseMinor.toInt(),
      netMinor: r.netMinor.toInt(),
      entries: r.entries,
      byCategory: r.byCategory
          .map(
            (c) => CategoryTotal(
              categoryId: c.categoryId,
              name: c.name,
              kind: c.kind,
              totalMinor: c.totalMinor.toInt(),
            ),
          )
          .toList(),
      daily: r.daily
          .map(
            (d) => DayTotal(
              day: DateTime.parse(d.day),
              incomeMinor: d.incomeMinor.toInt(),
              expenseMinor: d.expenseMinor.toInt(),
            ),
          )
          .toList(),
      topExpenseCategory: r.topExpenseCategory,
      currencies: r.currencies.toList(),
    );
  });
}
