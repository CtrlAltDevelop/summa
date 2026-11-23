import 'package:grpc/grpc.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import '../../gen/apps/billing/grpc/billing.pbgrpc.dart' as pb;
import '../wallets/grpc_guard.dart';
import 'billing_models.dart';

abstract interface class BillingApi {
  Future<List<PlanInfo>> plans(String access);
  Future<SubscriptionStatus> status(String access);
  Future<SubscriptionStatus> startTrial(String access);
  Future<Checkout> checkout(String access, String planCode);

  /// The server asks the gateway; the app's word is never taken for payment.
  Future<SubscriptionStatus> verify(String access, String reference);
}

class GrpcBillingApi implements BillingApi {
  GrpcBillingApi(ClientChannel channel)
    : _client = pb.BillingControllerClient(channel);

  final pb.BillingControllerClient _client;

  static CallOptions _bearer(String token) =>
      CallOptions(metadata: {'authorization': 'Bearer $token'});

  static SubscriptionStatus _status(pb.StatusReply r) => SubscriptionStatus(
    status: r.status,
    daysLeft: r.daysLeft,
    canWrite: r.canWrite,
    trialAvailable: r.trialAvailable,
  );

  @override
  Future<List<PlanInfo>> plans(String access) => guardGrpc(() async {
    final r = await _client.plans(Empty(), options: _bearer(access));
    return r.plans
        .map(
          (p) => PlanInfo(
            code: p.code,
            name: p.name,
            description: p.description,
            priceMinor: p.priceMinor.toInt(),
            periodDays: p.periodDays,
          ),
        )
        .toList();
  });

  @override
  Future<SubscriptionStatus> status(String access) => guardGrpc(
    () async =>
        _status(await _client.status(Empty(), options: _bearer(access))),
  );

  @override
  Future<SubscriptionStatus> startTrial(String access) => guardGrpc(
    () async =>
        _status(await _client.startTrial(Empty(), options: _bearer(access))),
  );

  @override
  Future<Checkout> checkout(String access, String planCode) =>
      guardGrpc(() async {
        final r = await _client.checkout(
          pb.CheckoutRequest(planCode: planCode),
          options: _bearer(access),
        );
        return Checkout(reference: r.reference, payUrl: r.payUrl);
      });

  @override
  Future<SubscriptionStatus> verify(String access, String reference) =>
      guardGrpc(
        () async => _status(
          await _client.verify(
            pb.VerifyRequest(reference: reference),
            options: _bearer(access),
          ),
        ),
      );
}
