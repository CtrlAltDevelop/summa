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

  @override
  String get loginTitle => 'ورود به سومّا';

  @override
  String get loginSubtitle =>
      'شماره موبایلت را بنویس تا کد تأیید برایت بفرستیم.';

  @override
  String get phoneLabel => 'شماره موبایل';

  @override
  String get phoneHint => '۰۹۱۲ ۳۴۵ ۶۷۸۹';

  @override
  String get sendCode => 'ارسال کد';

  @override
  String get codeTitle => 'کد تأیید';

  @override
  String codeSubtitle(String destination) {
    return 'کد ۶ رقمی به $destination فرستاده شد.';
  }

  @override
  String get codeLabel => 'کد ۶ رقمی';

  @override
  String get verify => 'تأیید';

  @override
  String resendIn(String seconds) {
    return 'ارسال دوباره تا $seconds ثانیه دیگر';
  }

  @override
  String get resend => 'ارسال دوباره کد';

  @override
  String get changeNumber => 'عوض کردن شماره';

  @override
  String get nameTitle => 'اسمت چیه؟';

  @override
  String get nameSubtitle => 'با همین اسم صدایت می‌زنیم.';

  @override
  String get nameLabel => 'نام';

  @override
  String get continueLabel => 'ادامه';

  @override
  String homeGreeting(String name) {
    return 'سلام $name';
  }

  @override
  String get signOut => 'خروج';

  @override
  String get errInvalidPhone =>
      'این شماره درست نیست. شماره موبایل ایران را بنویس.';

  @override
  String get errWrongCode => 'کد درست نیست یا منقضی شده. دوباره امتحان کن.';

  @override
  String get errTooMany => 'تلاش‌ها زیاد بود. کمی بعد دوباره امتحان کن.';

  @override
  String get errOffline => 'اتصال برقرار نشد. اینترنت را بررسی کن.';

  @override
  String get errUnknown => 'مشکلی پیش آمد. دوباره امتحان کن.';

  @override
  String get retry => 'تلاش دوباره';
}
