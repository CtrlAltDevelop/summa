// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appName => 'سومّا';

  @override
  String get healthTitle => 'اتصال به سرور';

  @override
  String get healthChecking => 'در حال بررسی…';

  @override
  String get healthOk => 'سرور آماده است';

  @override
  String get healthFailed => 'اتصال برقرار نشد';

  @override
  String get healthRetry => 'دوباره بررسی کن';

  @override
  String healthLatency(String ms) {
    return 'تأخیر: $ms میلی‌ثانیه';
  }

  @override
  String get galleryTitle => 'گالری اجزا';

  @override
  String get galleryButton => 'دکمه اصلی';

  @override
  String get galleryCard => 'کارت شیشه‌ای';

  @override
  String get galleryCount => 'شمارنده';

  @override
  String get galleryStatus => 'وضعیت‌ها';

  @override
  String get statusOk => 'موفق';

  @override
  String get statusWarn => 'هشدار';

  @override
  String get statusBad => 'خطا';
}
