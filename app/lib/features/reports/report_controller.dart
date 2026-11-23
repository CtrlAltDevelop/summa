import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/grpc/grpc_providers.dart';
import '../auth/auth_controller.dart';
import '../wallets/ledger_controller.dart';
import 'report_api.dart';
import 'report_models.dart';

final reportApiProvider = Provider<ReportApi>(
  (ref) => GrpcReportApi(ref.watch(grpcChannelProvider)),
);

/// The month report for [ReportQuery]; reloads when the ledger changes.
final reportProvider = FutureProvider.family<Report, ReportQuery>((ref, query) {
  ref.watch(ledgerControllerProvider);
  final window = shamsiMonthWindowAt(DateTime.now(), query.monthOffset);
  return ref
      .read(authControllerProvider.notifier)
      .withAccess(
        (access) => ref
            .read(reportApiProvider)
            .monthly(
              access,
              start: window.start,
              end: window.end,
              currency: query.currency,
            ),
      );
}, retry: (_, _) => null);
