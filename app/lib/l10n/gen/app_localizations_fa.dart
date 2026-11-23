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

  @override
  String get walletsTotalTitle => 'صندوق حساب‌وکتاب';

  @override
  String get walletsEmpty =>
      'هنوز کیف پولی نداری. اولین را بساز تا موجودی‌ات را ببینی.';

  @override
  String get walletAdd => 'کیف پول جدید';

  @override
  String get walletFormTitle => 'کیف پول جدید';

  @override
  String get walletNameLabel => 'نام کیف پول';

  @override
  String get walletKindLabel => 'نوع';

  @override
  String get walletCurrencyLabel => 'ارز';

  @override
  String get walletBankLabel => 'بانک (اختیاری)';

  @override
  String get walletOpeningLabel => 'موجودی اولیه';

  @override
  String get walletSave => 'ذخیره';

  @override
  String get walletNameRequired => 'برای کیف پول یک نام بنویس.';

  @override
  String get walletBalanceInvalid =>
      'موجودی اولیه درست نیست. فقط کارت اعتباری و اقساط می‌توانند منفی شروع شوند.';

  @override
  String get kindCash => 'نقد';

  @override
  String get kindBank => 'حساب بانکی';

  @override
  String get kindCreditCard => 'کارت اعتباری';

  @override
  String get kindBnpl => 'خرید اقساطی';

  @override
  String get kindGiftCard => 'هدیه‌کارت';

  @override
  String get kindCrypto => 'رمزارز';

  @override
  String get kindGold => 'طلا';

  @override
  String get currencyIRT => 'تومان';

  @override
  String get currencyIRR => 'ریال';

  @override
  String get currencyUSD => 'دلار';

  @override
  String get currencyEUR => 'یورو';

  @override
  String get currencyAED => 'درهم';

  @override
  String get currencyTRY => 'لیر';

  @override
  String get currencyUSDT => 'تتر';

  @override
  String get entryAdd => 'ثبت خرج یا درآمد';

  @override
  String get entryFormTitle => 'ثبت جدید';

  @override
  String get entryExpense => 'خرج';

  @override
  String get entryIncome => 'درآمد';

  @override
  String get entryWalletLabel => 'کیف پول';

  @override
  String get entryAmountLabel => 'مبلغ';

  @override
  String get entryNoteLabel => 'یادداشت (اختیاری)';

  @override
  String get entryAmountInvalid =>
      'مبلغ درست نیست. یک عدد بزرگ‌تر از صفر بنویس.';

  @override
  String get entryDelete => 'حذف';

  @override
  String get transferAdd => 'انتقال بین کیف‌ها';

  @override
  String get transferFormTitle => 'انتقال پول';

  @override
  String get transferFrom => 'از کیف';

  @override
  String get transferTo => 'به کیف';

  @override
  String get transferRateLabel => 'نرخ (هر یک واحد مبدأ چند واحد مقصد)';

  @override
  String get transferFeeLabel => 'کارمزد (اختیاری)';

  @override
  String get transferOut => 'انتقال (برداشت)';

  @override
  String get transferIn => 'انتقال (دریافت)';

  @override
  String get transferSameWallet => 'مبدأ و مقصد باید دو کیف پول متفاوت باشند.';

  @override
  String get transferRateInvalid =>
      'نرخ درست نیست. یک عدد بزرگ‌تر از صفر بنویس.';

  @override
  String get transferFeeInvalid => 'کارمزد درست نیست.';

  @override
  String get entryCategoryLabel => 'دسته';

  @override
  String get categoriesTitle => 'دسته‌ها و سقف';

  @override
  String get categoriesOpen => 'دسته‌ها و سقف ماهانه';

  @override
  String get categoryNameLabel => 'نام دسته جدید';

  @override
  String get categoryAdd => 'افزودن';

  @override
  String get categoryExpenses => 'دسته‌های خرج';

  @override
  String get categoryIncomes => 'دسته‌های درآمد';

  @override
  String get categoryNameInvalid => 'نام دسته درست نیست یا تکراری است.';

  @override
  String get budgetSet => 'سقف';

  @override
  String get budgetFormTitle => 'سقف ماهانه';

  @override
  String get budgetLimitLabel => 'سقف (صفر یعنی بدون سقف)';

  @override
  String get budgetCurrencyLabel => 'ارز';

  @override
  String get budgetsTitle => 'سقف این ماه';

  @override
  String get budgetOver => 'از سقف گذشتی';

  @override
  String get budgetWarning => 'نزدیک سقفی';
}
