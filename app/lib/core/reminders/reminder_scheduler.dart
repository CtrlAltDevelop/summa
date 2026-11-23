import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Schedules the daily "settle your accounts" reminder on the device.
///
/// The default does nothing: a real OS notification needs a native plugin
/// (for example `flutter_local_notifications`) set up and tried on a device.
/// Until one is plugged in here, the reminder is the card the app shows on
/// the home screen when it is open.
abstract interface class ReminderScheduler {
  /// Remind every day at [hour] (0-23, Tehran time).
  Future<void> scheduleDaily(int hour);

  Future<void> cancel();
}

class NoopReminderScheduler implements ReminderScheduler {
  const NoopReminderScheduler();

  @override
  Future<void> scheduleDaily(int hour) async {}

  @override
  Future<void> cancel() async {}
}

final reminderSchedulerProvider = Provider<ReminderScheduler>(
  (ref) => const NoopReminderScheduler(),
);
