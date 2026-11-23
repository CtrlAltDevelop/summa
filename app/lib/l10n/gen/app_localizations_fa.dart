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

  @override
  String get chatOpen => 'دستیار';

  @override
  String get chatTitle => 'دستیار';

  @override
  String get chatHint => 'مثلاً: ۲۵۰ هزار تومن خرید نان';

  @override
  String get chatSend => 'ارسال';

  @override
  String get chatRegister => 'ثبت';

  @override
  String get chatRegistered => 'ثبت شد';

  @override
  String get chatClear => 'پاک‌کردن گفتگو';

  @override
  String get chatChooseWallet => 'کیف را انتخاب کن';

  @override
  String get chatEmpty => 'جمله‌ای بنویس تا برایت کارت ثبت بسازم.';

  @override
  String get smsOpen => 'پیامک بانک';

  @override
  String get smsTitle => 'پیامک بانک';

  @override
  String get smsPasteLabel => 'متن پیامک را اینجا بچسبان';

  @override
  String get smsAnalyze => 'بررسی پیامک';

  @override
  String get smsIgnoredOtp => 'این پیامک رمز یکبارمصرف است؛ ثبت نمی‌شود.';

  @override
  String get smsIgnoredFailed => 'این تراکنش ناموفق بوده؛ ثبت نمی‌شود.';

  @override
  String get smsIgnoredAd => 'این پیامک تبلیغاتی است؛ ثبت نمی‌شود.';

  @override
  String get smsIgnoredNoAmount => 'مبلغی در این پیامک پیدا نکردم.';

  @override
  String get smsKindLabel => 'نوع تراکنش';

  @override
  String get smsWhatFor => 'برای چه بود؟';

  @override
  String get smsBalance => 'مانده پس از تراکنش';

  @override
  String get smsLowConfidence => 'مطمئن نیستم؛ لطفاً قبل از ثبت بررسی کن.';

  @override
  String get smsDuplicate =>
      'شبیه همین تراکنش قبلاً ثبت شده است. باز هم ثبت شود؟';

  @override
  String smsCardNote(String last4) {
    return 'این کارت (۴ رقم آخر $last4) برای دفعه بعد به همین کیف وصل می‌شود.';
  }

  @override
  String get entryOutsideLabel => 'حساب‌وکتاب';

  @override
  String get entryCounted => 'در جمع‌ها';

  @override
  String get entryOutside => 'بیرون از جمع';

  @override
  String get entryOutsideTag => 'بیرون از جمع';

  @override
  String get entrySplitTag => 'تقسیم‌شده';

  @override
  String get splitOpen => 'تقسیم خرج';

  @override
  String get splitTitle => 'تقسیم خرج';

  @override
  String get splitPart => 'بخش';

  @override
  String get splitAddPart => 'افزودن بخش';

  @override
  String get splitTotal => 'جمع';

  @override
  String get splitNeedsTwo => 'حداقل دو بخش با مبلغ درست لازم است.';

  @override
  String get entryRefund => 'برگشت وجه';

  @override
  String get refundOpen => 'برگشت';

  @override
  String get refundTitle => 'برگشت وجه';

  @override
  String get refundAmountLabel => 'مبلغ (خالی = همه باقی‌مانده)';

  @override
  String get refundRemaining => 'قابل برگشت';

  @override
  String get entryRefundedTag => 'برگشت‌خورده';

  @override
  String get entryDeleteBlocked =>
      'این خرج برگشت دارد؛ اول برگشت‌ها را حذف کن.';

  @override
  String get refundInvalid =>
      'مبلغ برگشت درست نیست یا بیشتر از باقی‌مانده است.';

  @override
  String get recurringOpen => 'تراکنش‌های تکراری';

  @override
  String get recurringTitle => 'تراکنش تکراری';

  @override
  String get recurringAdd => 'تکراری جدید';

  @override
  String get recurringNoteLabel => 'عنوان (مثلاً اجاره)';

  @override
  String get recurringAmountLabel => 'مبلغ (خالی = هر بار می‌پرسم)';

  @override
  String get recurringPeriodLabel => 'تکرار';

  @override
  String get recurringMonthly => 'ماهانه';

  @override
  String get recurringWeekly => 'هفتگی';

  @override
  String get recurringDayLabel => 'روز ماه شمسی (۱ تا ۳۱)';

  @override
  String get recurringWeekdayLabel => 'روز هفته';

  @override
  String get recurringAuto => 'ثبت خودکار روز سررسید';

  @override
  String get recurringAskMe => 'بپرس';

  @override
  String get recurringNext => 'سررسید بعدی';

  @override
  String get recurringPause => 'توقف';

  @override
  String get recurringResume => 'ادامه';

  @override
  String get recurringDayInvalid => 'روز درست نیست.';

  @override
  String get weekdaySat => 'شنبه';

  @override
  String get weekdaySun => 'یکشنبه';

  @override
  String get weekdayMon => 'دوشنبه';

  @override
  String get weekdayTue => 'سه‌شنبه';

  @override
  String get weekdayWed => 'چهارشنبه';

  @override
  String get weekdayThu => 'پنجشنبه';

  @override
  String get weekdayFri => 'جمعه';

  @override
  String get occurrenceDueTitle => 'سررسید';

  @override
  String get occurrenceUpcoming => 'به‌زودی';

  @override
  String get occurrenceLowBalance => 'موجودی کیف برای این مبلغ کم است.';

  @override
  String get occurrenceDeducted => 'از همین حساب کسر شد';

  @override
  String get occurrenceOtherWallet => 'از حساب دیگر';

  @override
  String get occurrenceCancelled => 'لغو شد';

  @override
  String get occurrenceAmountLabel => 'مبلغ این بار';

  @override
  String get occurrenceNeedsAmount => 'مبلغ این بار را بنویس.';

  @override
  String get occurrenceNotYet => 'هنوز نه';

  @override
  String get occurrenceGotIt => 'گرفتم';

  @override
  String get occurrenceDidYouGetIt => 'گرفتی؟';

  @override
  String get recurringReceived => 'حقوق این ماه را گرفتم';

  @override
  String get recurringPaid => 'این ماه پرداخت شد';

  @override
  String get recurringCategoryLabel => 'دسته';

  @override
  String get digestTitle => 'حساب‌وکتاب امروز';

  @override
  String digestEntries(String count) {
    return 'تراکنش ثبت‌شده امروز: $count';
  }

  @override
  String digestUncategorized(String count) {
    return 'بدون دسته: $count';
  }

  @override
  String digestDue(String count) {
    return 'سررسید منتظر پاسخ: $count';
  }

  @override
  String get digestNothingYet => 'امروز هنوز چیزی ثبت نکرده‌ای.';

  @override
  String get accountingHourTitle => 'ساعت حساب‌وکتاب روزانه';

  @override
  String get accountingHourOff => 'خاموش';

  @override
  String get debtAdd => 'وام یا قسط جدید';

  @override
  String get debtTitle => 'وام یا قسط';

  @override
  String get debtFormTitle => 'بدهی جدید';

  @override
  String get debtKindLoan => 'وام بانکی';

  @override
  String get debtKindPurchase => 'خرید اقساطی';

  @override
  String get debtKindPersonal => 'قرض شخصی';

  @override
  String get debtTitleLabel => 'عنوان (مثلاً وام مسکن)';

  @override
  String get debtInstallmentLabel => 'مبلغ هر قسط';

  @override
  String get debtCountLabel => 'تعداد اقساط';

  @override
  String get debtFirstDueLabel => 'تاریخ اولین قسط (مثل ۱۴۰۵/۰۹/۱۵)';

  @override
  String get debtPrincipalLabel => 'مبلغ اصل (اختیاری)';

  @override
  String get debtWalletLabel => 'کیف پرداخت (اختیاری)';

  @override
  String get debtRemaining => 'مانده';

  @override
  String get debtNextDue => 'قسط بعدی';

  @override
  String get debtClosed => 'تسویه شد';

  @override
  String get debtOverdue => 'عقب‌افتاده';

  @override
  String get installmentPay => 'پرداخت شد';

  @override
  String get installmentUndo => 'لغو پرداخت';

  @override
  String get installmentPaid => 'پرداخت‌شده';

  @override
  String get debtDelete => 'حذف بدهی';

  @override
  String get debtCountInvalid => 'تعداد اقساط باید بین ۱ تا ۱۲۰ باشد.';

  @override
  String get debtDateInvalid => 'تاریخ اولین قسط درست نیست.';

  @override
  String get debtPayWallet => 'از کدام کیف پرداخت شود؟';

  @override
  String get debtPayFailed => 'پرداخت انجام نشد؛ کیف و مبلغ را بررسی کن.';

  @override
  String get assetsTitle => 'دارایی‌ها';

  @override
  String get assetAdd => 'دارایی جدید';

  @override
  String get assetsValue => 'ارزش دارایی‌ها';

  @override
  String get assetsProfit => 'سود و زیان';

  @override
  String get assetsRealized => 'سود تحقق‌یافته';

  @override
  String get assetFormTitle => 'دارایی جدید';

  @override
  String get assetCustom => 'دلخواه';

  @override
  String get assetNameLabel => 'نام دارایی';

  @override
  String get assetQuantityLabel => 'مقدار';

  @override
  String get assetBuyPriceLabel => 'قیمت خرید هر واحد (تومان)';

  @override
  String get assetManualPriceLabel => 'قیمت امروز هر واحد (تومان)';

  @override
  String get assetBuyMore => 'خرید جدید';

  @override
  String get assetSell => 'فروش';

  @override
  String get assetSellPriceLabel => 'قیمت فروش هر واحد (تومان)';

  @override
  String get assetDelete => 'حذف دارایی';

  @override
  String get assetUnknownPrice => 'قیمت این دارایی هنوز معلوم نیست.';

  @override
  String get assetStale => 'قیمت کهنه';

  @override
  String get assetQuantityInvalid => 'مقدار درست نیست.';

  @override
  String get assetPriceInvalid => 'قیمت درست نیست.';

  @override
  String get assetNameInvalid => 'نام و قیمت امروز لازم است.';

  @override
  String get assetFailed => 'انجام نشد؛ مقدار و قیمت را بررسی کن.';

  @override
  String get assetCost => 'هزینه خرید';

  @override
  String get assetHeld => 'مقدار فعلی';

  @override
  String get pricesOpen => 'قیمت‌ها';

  @override
  String get pricesTitle => 'قیمت‌ها';

  @override
  String get priceUnknown => 'نامشخص';

  @override
  String get priceStaleSuffix => 'کهنه';

  @override
  String get priceSourcePrefix => 'منبع';

  @override
  String get netWorthTitle => 'خالص دارایی';

  @override
  String get netWorthWallets => 'کیف‌ها';

  @override
  String get netWorthAssets => 'دارایی‌ها';

  @override
  String get netWorthDebts => 'بدهی‌ها';

  @override
  String get netWorthGold => 'گرم طلای ۱۸ عیار';

  @override
  String get netWorthStale => 'بعضی نرخ‌ها کهنه‌اند؛ عدد تقریبی است.';

  @override
  String netWorthUnconverted(String codes) {
    return 'ارزهای بدون نرخ (کنار گذاشته شد): $codes';
  }

  @override
  String netWorthUnpriced(String count) {
    return 'دارایی بدون قیمت: $count';
  }

  @override
  String get basketsTitle => 'سبدهای هدف';

  @override
  String get basketAdd => 'سبد هدف جدید';

  @override
  String get basketFormTitle => 'سبد هدف';

  @override
  String get basketNameLabel => 'نام هدف (مثلاً پیش‌پرداخت خانه)';

  @override
  String get basketTargetLabel => 'مبلغ هدف (تومان)';

  @override
  String get basketItemsLabel => 'چه چیزهایی به این هدف حساب شود؟';

  @override
  String get basketTargetInvalid => 'مبلغ هدف درست نیست.';

  @override
  String get basketDelete => 'حذف سبد';

  @override
  String basketProgress(String percent) {
    return '$percent٪ از هدف';
  }

  @override
  String get reportOpen => 'گزارش ماه';

  @override
  String get reportTitle => 'گزارش ماه';

  @override
  String get reportPrev => 'ماه قبل';

  @override
  String get reportNext => 'ماه بعد';

  @override
  String get reportIncome => 'درآمد';

  @override
  String get reportExpense => 'خرج';

  @override
  String get reportNet => 'خالص';

  @override
  String get reportByCategory => 'خرج به تفکیک دسته';

  @override
  String get reportIncomeByCategory => 'درآمد به تفکیک دسته';

  @override
  String get reportDaily => 'خرج روزانه';

  @override
  String get reportEmpty => 'در این ماه تراکنشی نیست.';

  @override
  String reportEntries(String count) {
    return 'تعداد تراکنش: $count';
  }

  @override
  String reportTop(String name) {
    return 'پرخرج‌ترین دسته: $name';
  }

  @override
  String get reportFailed => 'گزارش گرفته نشد. دوباره امتحان کن.';

  @override
  String outboxPending(String count) {
    return 'تراکنش در انتظار ارسال: $count';
  }

  @override
  String get outboxRetry => 'ارسال دوباره';

  @override
  String get outboxSavedOffline =>
      'اینترنت نیست؛ ذخیره شد و با اتصال فرستاده می‌شود.';

  @override
  String get outboxFailedTitle => 'این تراکنش‌ها ثبت نشدند';

  @override
  String get outboxFailedDismiss => 'حذف';

  @override
  String get outboxQueued => 'در انتظار ارسال';

  @override
  String get billingOpen => 'اشتراک';

  @override
  String get billingTitle => 'اشتراک';

  @override
  String get billingStatusNone => 'هنوز اشتراکی نداری.';

  @override
  String billingStatusTrial(String days) {
    return 'دوره آزمایشی؛ $days روز مانده';
  }

  @override
  String billingStatusActive(String days) {
    return 'اشتراک فعال؛ $days روز مانده';
  }

  @override
  String get billingStatusExpired => 'اشتراکت تمام شده است.';

  @override
  String get billingStartTrial => 'شروع دوره آزمایشی';

  @override
  String get billingBuy => 'خرید';

  @override
  String get billingNoPlans => 'فعلاً پلنی برای خرید نیست.';

  @override
  String billingPlanLine(String price, String days) {
    return '$price تومان · $days روز';
  }

  @override
  String get billingPayAt => 'پرداخت را اینجا انجام بده:';

  @override
  String get billingCheckPayment => 'بررسی پرداخت';

  @override
  String get billingNotConfirmed => 'پرداخت هنوز تأیید نشده.';

  @override
  String get billingFailed => 'انجام نشد. دوباره امتحان کن.';

  @override
  String get readOnlyBanner =>
      'اشتراکت تمام شده؛ فعلاً فقط می‌توانی داده‌ات را ببینی.';

  @override
  String get readOnlyRenew => 'تمدید';

  @override
  String get supportOpen => 'پشتیبانی';

  @override
  String get supportTitle => 'پشتیبانی';

  @override
  String get supportNew => 'تیکت جدید';

  @override
  String get supportEmpty => 'هنوز تیکتی نداری.';

  @override
  String get supportSubjectLabel => 'موضوع';

  @override
  String get supportBodyLabel => 'مشکل یا سؤالت را بنویس';

  @override
  String get supportSend => 'ارسال';

  @override
  String get supportReplyHint => 'پیامت را بنویس';

  @override
  String get supportSubjectRequired => 'موضوع و متن را بنویس.';

  @override
  String get supportFailed => 'ارسال نشد. دوباره امتحان کن.';

  @override
  String get supportStatusOpen => 'باز';

  @override
  String get supportStatusPending => 'در انتظار پاسخ';

  @override
  String get supportStatusResolved => 'حل شد';

  @override
  String get supportStatusClosed => 'بسته';

  @override
  String get supportFromTeam => 'پشتیبان';

  @override
  String get supportFromYou => 'تو';

  @override
  String get supportUnread => 'پیام جدید';

  @override
  String get lockTitle => 'Summa قفل است';

  @override
  String get lockPasscodeLabel => 'رمز اپ';

  @override
  String get lockUnlock => 'باز کردن';

  @override
  String get lockBiometric => 'باز کردن با بیومتریک';

  @override
  String get lockWrong => 'رمز درست نیست.';

  @override
  String get lockWait => 'تلاش‌ها زیاد بود؛ کمی صبر کن و دوباره امتحان کن.';

  @override
  String get privacyOpen => 'حریم و امنیت';

  @override
  String get privacyTitle => 'حریم و امنیت';

  @override
  String get lockEnable => 'فعال‌کردن قفل اپ';

  @override
  String get lockDisable => 'خاموش‌کردن قفل';

  @override
  String get lockChange => 'تغییر رمز';

  @override
  String get lockNewPasscode => 'رمز جدید (۴ تا ۸ رقم)';

  @override
  String get lockConfirmPasscode => 'تکرار رمز';

  @override
  String get lockMismatch => 'دو رمز یکی نیست.';

  @override
  String get lockInvalid => 'رمز باید ۴ تا ۸ رقم باشد.';

  @override
  String get lockCurrentPasscode => 'رمز فعلی';

  @override
  String get lockBiometricToggle => 'بیومتریک';

  @override
  String get lockOn => 'روشن';

  @override
  String get lockOff => 'خاموش';

  @override
  String get lockDelayLabel => 'قفل خودکار بعد از';

  @override
  String get lockDelayNow => 'فوری';

  @override
  String lockDelaySeconds(String count) {
    return '$count ثانیه';
  }

  @override
  String lockDelayMinutes(String count) {
    return '$count دقیقه';
  }

  @override
  String get lockSave => 'ذخیره';

  @override
  String get strongAuthReason => 'برای ادامه هویتت را تأیید کن';

  @override
  String get strongAuthNeedPasscode =>
      'این کار حساس است. اول یک رمز برای اپ تعیین کن.';

  @override
  String get strongAuthPrompt => 'رمز اپ را وارد کن';

  @override
  String get strongAuthDenied => 'تأیید نشد.';

  @override
  String get retentionTitle => 'نگه‌داری چت';

  @override
  String get retentionForever => 'همیشه';

  @override
  String retentionDays(String count) {
    return '$count روز';
  }

  @override
  String get deleteAccountOpen => 'حذف حساب';

  @override
  String get deleteAccountWarning =>
      'همه داده‌هایت برای همیشه پاک می‌شود و برگشتی ندارد. برای تأیید DELETE را بنویس.';

  @override
  String get deleteAccountConfirmLabel => 'عبارت تأیید';

  @override
  String get deleteAccountButton => 'حذف همیشگی حساب';

  @override
  String get deleteAccountFailed =>
      'حذف انجام نشد. عبارت را درست بنویس یا دوباره امتحان کن.';
}
