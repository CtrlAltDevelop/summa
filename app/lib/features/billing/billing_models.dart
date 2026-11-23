class PlanInfo {
  const PlanInfo({
    required this.code,
    required this.name,
    required this.description,
    required this.priceMinor,
    required this.periodDays,
  });

  final String code;
  final String name;
  final String description;

  /// Toman.
  final int priceMinor;
  final int periodDays;
}

/// `none`, `trial`, `active` or `expired`.
class SubscriptionStatus {
  const SubscriptionStatus({
    required this.status,
    required this.daysLeft,
    required this.canWrite,
    required this.trialAvailable,
  });

  final String status;
  final int daysLeft;

  /// False when the account is read-only (the server refuses writes).
  final bool canWrite;
  final bool trialAvailable;
}

class Checkout {
  const Checkout({required this.reference, required this.payUrl});

  final String reference;
  final String payUrl;
}
