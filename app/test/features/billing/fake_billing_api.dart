import 'package:summa/features/billing/billing_api.dart';
import 'package:summa/features/billing/billing_models.dart';

/// Scriptable [BillingApi]. [confirms] says whether the gateway will confirm.
class FakeBillingApi implements BillingApi {
  SubscriptionStatus current = const SubscriptionStatus(
    status: 'trial',
    daysLeft: 10,
    canWrite: true,
    trialAvailable: false,
  );
  final List<PlanInfo> planList = [];
  bool confirms = true;
  bool failCheckout = false;
  int trialsStarted = 0;
  final List<String> checkouts = [];
  final List<String> verified = [];

  @override
  Future<List<PlanInfo>> plans(String access) async => List.of(planList);

  @override
  Future<SubscriptionStatus> status(String access) async => current;

  @override
  Future<SubscriptionStatus> startTrial(String access) async {
    trialsStarted++;
    return current = const SubscriptionStatus(
      status: 'trial',
      daysLeft: 14,
      canWrite: true,
      trialAvailable: false,
    );
  }

  @override
  Future<Checkout> checkout(String access, String planCode) async {
    if (failCheckout) throw Exception('down');
    checkouts.add(planCode);
    return const Checkout(reference: 'ref-1', payUrl: 'summa://pay/ref-1');
  }

  @override
  Future<SubscriptionStatus> verify(String access, String reference) async {
    verified.add(reference);
    if (confirms) {
      current = const SubscriptionStatus(
        status: 'active',
        daysLeft: 30,
        canWrite: true,
        trialAvailable: false,
      );
    }
    return current;
  }
}
