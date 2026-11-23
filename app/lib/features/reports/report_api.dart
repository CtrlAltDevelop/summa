import 'package:grpc/grpc.dart';

import '../../gen/apps/reports/grpc/reports.pbgrpc.dart' as pb;
import '../wallets/grpc_guard.dart';
import 'report_models.dart';

abstract interface class ReportApi {
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
