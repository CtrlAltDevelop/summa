import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('fa')];

  /// No description provided for @appName.
  ///
  /// In fa, this message translates to:
  /// **'سومّا'**
  String get appName;

  /// No description provided for @healthTitle.
  ///
  /// In fa, this message translates to:
  /// **'اتصال به سرور'**
  String get healthTitle;

  /// No description provided for @healthChecking.
  ///
  /// In fa, this message translates to:
  /// **'در حال بررسی…'**
  String get healthChecking;

  /// No description provided for @healthOk.
  ///
  /// In fa, this message translates to:
  /// **'سرور آماده است'**
  String get healthOk;

  /// No description provided for @healthFailed.
  ///
  /// In fa, this message translates to:
  /// **'اتصال برقرار نشد'**
  String get healthFailed;

  /// No description provided for @healthRetry.
  ///
  /// In fa, this message translates to:
  /// **'دوباره بررسی کن'**
  String get healthRetry;

  /// No description provided for @healthLatency.
  ///
  /// In fa, this message translates to:
  /// **'تأخیر: {ms} میلی‌ثانیه'**
  String healthLatency(String ms);

  /// No description provided for @galleryTitle.
  ///
  /// In fa, this message translates to:
  /// **'گالری اجزا'**
  String get galleryTitle;

  /// No description provided for @galleryButton.
  ///
  /// In fa, this message translates to:
  /// **'دکمه اصلی'**
  String get galleryButton;

  /// No description provided for @galleryCard.
  ///
  /// In fa, this message translates to:
  /// **'کارت شیشه‌ای'**
  String get galleryCard;

  /// No description provided for @galleryCount.
  ///
  /// In fa, this message translates to:
  /// **'شمارنده'**
  String get galleryCount;

  /// No description provided for @galleryStatus.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت‌ها'**
  String get galleryStatus;

  /// No description provided for @statusOk.
  ///
  /// In fa, this message translates to:
  /// **'موفق'**
  String get statusOk;

  /// No description provided for @statusWarn.
  ///
  /// In fa, this message translates to:
  /// **'هشدار'**
  String get statusWarn;

  /// No description provided for @statusBad.
  ///
  /// In fa, this message translates to:
  /// **'خطا'**
  String get statusBad;

  /// No description provided for @loginTitle.
  ///
  /// In fa, this message translates to:
  /// **'ورود به سومّا'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In fa, this message translates to:
  /// **'شماره موبایلت را بنویس تا کد تأیید برایت بفرستیم.'**
  String get loginSubtitle;

  /// No description provided for @phoneLabel.
  ///
  /// In fa, this message translates to:
  /// **'شماره موبایل'**
  String get phoneLabel;

  /// No description provided for @phoneHint.
  ///
  /// In fa, this message translates to:
  /// **'۰۹۱۲ ۳۴۵ ۶۷۸۹'**
  String get phoneHint;

  /// No description provided for @sendCode.
  ///
  /// In fa, this message translates to:
  /// **'ارسال کد'**
  String get sendCode;

  /// No description provided for @codeTitle.
  ///
  /// In fa, this message translates to:
  /// **'کد تأیید'**
  String get codeTitle;

  /// No description provided for @codeSubtitle.
  ///
  /// In fa, this message translates to:
  /// **'کد ۶ رقمی به {destination} فرستاده شد.'**
  String codeSubtitle(String destination);

  /// No description provided for @codeLabel.
  ///
  /// In fa, this message translates to:
  /// **'کد ۶ رقمی'**
  String get codeLabel;

  /// No description provided for @verify.
  ///
  /// In fa, this message translates to:
  /// **'تأیید'**
  String get verify;

  /// No description provided for @resendIn.
  ///
  /// In fa, this message translates to:
  /// **'ارسال دوباره تا {seconds} ثانیه دیگر'**
  String resendIn(String seconds);

  /// No description provided for @resend.
  ///
  /// In fa, this message translates to:
  /// **'ارسال دوباره کد'**
  String get resend;

  /// No description provided for @changeNumber.
  ///
  /// In fa, this message translates to:
  /// **'عوض کردن شماره'**
  String get changeNumber;

  /// No description provided for @nameTitle.
  ///
  /// In fa, this message translates to:
  /// **'اسمت چیه؟'**
  String get nameTitle;

  /// No description provided for @nameSubtitle.
  ///
  /// In fa, this message translates to:
  /// **'با همین اسم صدایت می‌زنیم.'**
  String get nameSubtitle;

  /// No description provided for @nameLabel.
  ///
  /// In fa, this message translates to:
  /// **'نام'**
  String get nameLabel;

  /// No description provided for @continueLabel.
  ///
  /// In fa, this message translates to:
  /// **'ادامه'**
  String get continueLabel;

  /// No description provided for @homeGreeting.
  ///
  /// In fa, this message translates to:
  /// **'سلام {name}'**
  String homeGreeting(String name);

  /// No description provided for @signOut.
  ///
  /// In fa, this message translates to:
  /// **'خروج'**
  String get signOut;

  /// No description provided for @errInvalidPhone.
  ///
  /// In fa, this message translates to:
  /// **'این شماره درست نیست. شماره موبایل ایران را بنویس.'**
  String get errInvalidPhone;

  /// No description provided for @errWrongCode.
  ///
  /// In fa, this message translates to:
  /// **'کد درست نیست یا منقضی شده. دوباره امتحان کن.'**
  String get errWrongCode;

  /// No description provided for @errTooMany.
  ///
  /// In fa, this message translates to:
  /// **'تلاش‌ها زیاد بود. کمی بعد دوباره امتحان کن.'**
  String get errTooMany;

  /// No description provided for @errOffline.
  ///
  /// In fa, this message translates to:
  /// **'اتصال برقرار نشد. اینترنت را بررسی کن.'**
  String get errOffline;

  /// No description provided for @errUnknown.
  ///
  /// In fa, this message translates to:
  /// **'مشکلی پیش آمد. دوباره امتحان کن.'**
  String get errUnknown;

  /// No description provided for @retry.
  ///
  /// In fa, this message translates to:
  /// **'تلاش دوباره'**
  String get retry;

  /// No description provided for @walletsTotalTitle.
  ///
  /// In fa, this message translates to:
  /// **'صندوق حساب‌وکتاب'**
  String get walletsTotalTitle;

  /// No description provided for @walletsEmpty.
  ///
  /// In fa, this message translates to:
  /// **'هنوز کیف پولی نداری. اولین را بساز تا موجودی‌ات را ببینی.'**
  String get walletsEmpty;

  /// No description provided for @walletAdd.
  ///
  /// In fa, this message translates to:
  /// **'کیف پول جدید'**
  String get walletAdd;

  /// No description provided for @walletFormTitle.
  ///
  /// In fa, this message translates to:
  /// **'کیف پول جدید'**
  String get walletFormTitle;

  /// No description provided for @walletNameLabel.
  ///
  /// In fa, this message translates to:
  /// **'نام کیف پول'**
  String get walletNameLabel;

  /// No description provided for @walletKindLabel.
  ///
  /// In fa, this message translates to:
  /// **'نوع'**
  String get walletKindLabel;

  /// No description provided for @walletCurrencyLabel.
  ///
  /// In fa, this message translates to:
  /// **'ارز'**
  String get walletCurrencyLabel;

  /// No description provided for @walletBankLabel.
  ///
  /// In fa, this message translates to:
  /// **'بانک (اختیاری)'**
  String get walletBankLabel;

  /// No description provided for @walletOpeningLabel.
  ///
  /// In fa, this message translates to:
  /// **'موجودی اولیه'**
  String get walletOpeningLabel;

  /// No description provided for @walletSave.
  ///
  /// In fa, this message translates to:
  /// **'ذخیره'**
  String get walletSave;

  /// No description provided for @walletNameRequired.
  ///
  /// In fa, this message translates to:
  /// **'برای کیف پول یک نام بنویس.'**
  String get walletNameRequired;

  /// No description provided for @walletBalanceInvalid.
  ///
  /// In fa, this message translates to:
  /// **'موجودی اولیه درست نیست. فقط کارت اعتباری و اقساط می‌توانند منفی شروع شوند.'**
  String get walletBalanceInvalid;

  /// No description provided for @kindCash.
  ///
  /// In fa, this message translates to:
  /// **'نقد'**
  String get kindCash;

  /// No description provided for @kindBank.
  ///
  /// In fa, this message translates to:
  /// **'حساب بانکی'**
  String get kindBank;

  /// No description provided for @kindCreditCard.
  ///
  /// In fa, this message translates to:
  /// **'کارت اعتباری'**
  String get kindCreditCard;

  /// No description provided for @kindBnpl.
  ///
  /// In fa, this message translates to:
  /// **'خرید اقساطی'**
  String get kindBnpl;

  /// No description provided for @kindGiftCard.
  ///
  /// In fa, this message translates to:
  /// **'هدیه‌کارت'**
  String get kindGiftCard;

  /// No description provided for @kindCrypto.
  ///
  /// In fa, this message translates to:
  /// **'رمزارز'**
  String get kindCrypto;

  /// No description provided for @kindGold.
  ///
  /// In fa, this message translates to:
  /// **'طلا'**
  String get kindGold;

  /// No description provided for @currencyIRT.
  ///
  /// In fa, this message translates to:
  /// **'تومان'**
  String get currencyIRT;

  /// No description provided for @currencyIRR.
  ///
  /// In fa, this message translates to:
  /// **'ریال'**
  String get currencyIRR;

  /// No description provided for @currencyUSD.
  ///
  /// In fa, this message translates to:
  /// **'دلار'**
  String get currencyUSD;

  /// No description provided for @currencyEUR.
  ///
  /// In fa, this message translates to:
  /// **'یورو'**
  String get currencyEUR;

  /// No description provided for @currencyAED.
  ///
  /// In fa, this message translates to:
  /// **'درهم'**
  String get currencyAED;

  /// No description provided for @currencyTRY.
  ///
  /// In fa, this message translates to:
  /// **'لیر'**
  String get currencyTRY;

  /// No description provided for @currencyUSDT.
  ///
  /// In fa, this message translates to:
  /// **'تتر'**
  String get currencyUSDT;

  /// No description provided for @entryAdd.
  ///
  /// In fa, this message translates to:
  /// **'ثبت خرج یا درآمد'**
  String get entryAdd;

  /// No description provided for @entryFormTitle.
  ///
  /// In fa, this message translates to:
  /// **'ثبت جدید'**
  String get entryFormTitle;

  /// No description provided for @entryExpense.
  ///
  /// In fa, this message translates to:
  /// **'خرج'**
  String get entryExpense;

  /// No description provided for @entryIncome.
  ///
  /// In fa, this message translates to:
  /// **'درآمد'**
  String get entryIncome;

  /// No description provided for @entryWalletLabel.
  ///
  /// In fa, this message translates to:
  /// **'کیف پول'**
  String get entryWalletLabel;

  /// No description provided for @entryAmountLabel.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ'**
  String get entryAmountLabel;

  /// No description provided for @entryNoteLabel.
  ///
  /// In fa, this message translates to:
  /// **'یادداشت (اختیاری)'**
  String get entryNoteLabel;

  /// No description provided for @entryAmountInvalid.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ درست نیست. یک عدد بزرگ‌تر از صفر بنویس.'**
  String get entryAmountInvalid;

  /// No description provided for @entryDelete.
  ///
  /// In fa, this message translates to:
  /// **'حذف'**
  String get entryDelete;

  /// No description provided for @transferAdd.
  ///
  /// In fa, this message translates to:
  /// **'انتقال بین کیف‌ها'**
  String get transferAdd;

  /// No description provided for @transferFormTitle.
  ///
  /// In fa, this message translates to:
  /// **'انتقال پول'**
  String get transferFormTitle;

  /// No description provided for @transferFrom.
  ///
  /// In fa, this message translates to:
  /// **'از کیف'**
  String get transferFrom;

  /// No description provided for @transferTo.
  ///
  /// In fa, this message translates to:
  /// **'به کیف'**
  String get transferTo;

  /// No description provided for @transferRateLabel.
  ///
  /// In fa, this message translates to:
  /// **'نرخ (هر یک واحد مبدأ چند واحد مقصد)'**
  String get transferRateLabel;

  /// No description provided for @transferFeeLabel.
  ///
  /// In fa, this message translates to:
  /// **'کارمزد (اختیاری)'**
  String get transferFeeLabel;

  /// No description provided for @transferOut.
  ///
  /// In fa, this message translates to:
  /// **'انتقال (برداشت)'**
  String get transferOut;

  /// No description provided for @transferIn.
  ///
  /// In fa, this message translates to:
  /// **'انتقال (دریافت)'**
  String get transferIn;

  /// No description provided for @transferSameWallet.
  ///
  /// In fa, this message translates to:
  /// **'مبدأ و مقصد باید دو کیف پول متفاوت باشند.'**
  String get transferSameWallet;

  /// No description provided for @transferRateInvalid.
  ///
  /// In fa, this message translates to:
  /// **'نرخ درست نیست. یک عدد بزرگ‌تر از صفر بنویس.'**
  String get transferRateInvalid;

  /// No description provided for @transferFeeInvalid.
  ///
  /// In fa, this message translates to:
  /// **'کارمزد درست نیست.'**
  String get transferFeeInvalid;

  /// No description provided for @entryCategoryLabel.
  ///
  /// In fa, this message translates to:
  /// **'دسته'**
  String get entryCategoryLabel;

  /// No description provided for @categoriesTitle.
  ///
  /// In fa, this message translates to:
  /// **'دسته‌ها و سقف'**
  String get categoriesTitle;

  /// No description provided for @categoriesOpen.
  ///
  /// In fa, this message translates to:
  /// **'دسته‌ها و سقف ماهانه'**
  String get categoriesOpen;

  /// No description provided for @categoryNameLabel.
  ///
  /// In fa, this message translates to:
  /// **'نام دسته جدید'**
  String get categoryNameLabel;

  /// No description provided for @categoryAdd.
  ///
  /// In fa, this message translates to:
  /// **'افزودن'**
  String get categoryAdd;

  /// No description provided for @categoryExpenses.
  ///
  /// In fa, this message translates to:
  /// **'دسته‌های خرج'**
  String get categoryExpenses;

  /// No description provided for @categoryIncomes.
  ///
  /// In fa, this message translates to:
  /// **'دسته‌های درآمد'**
  String get categoryIncomes;

  /// No description provided for @categoryNameInvalid.
  ///
  /// In fa, this message translates to:
  /// **'نام دسته درست نیست یا تکراری است.'**
  String get categoryNameInvalid;

  /// No description provided for @budgetSet.
  ///
  /// In fa, this message translates to:
  /// **'سقف'**
  String get budgetSet;

  /// No description provided for @budgetFormTitle.
  ///
  /// In fa, this message translates to:
  /// **'سقف ماهانه'**
  String get budgetFormTitle;

  /// No description provided for @budgetLimitLabel.
  ///
  /// In fa, this message translates to:
  /// **'سقف (صفر یعنی بدون سقف)'**
  String get budgetLimitLabel;

  /// No description provided for @budgetCurrencyLabel.
  ///
  /// In fa, this message translates to:
  /// **'ارز'**
  String get budgetCurrencyLabel;

  /// No description provided for @budgetsTitle.
  ///
  /// In fa, this message translates to:
  /// **'سقف این ماه'**
  String get budgetsTitle;

  /// No description provided for @budgetOver.
  ///
  /// In fa, this message translates to:
  /// **'از سقف گذشتی'**
  String get budgetOver;

  /// No description provided for @budgetWarning.
  ///
  /// In fa, this message translates to:
  /// **'نزدیک سقفی'**
  String get budgetWarning;

  /// No description provided for @chatOpen.
  ///
  /// In fa, this message translates to:
  /// **'دستیار'**
  String get chatOpen;

  /// No description provided for @chatTitle.
  ///
  /// In fa, this message translates to:
  /// **'دستیار'**
  String get chatTitle;

  /// No description provided for @chatHint.
  ///
  /// In fa, this message translates to:
  /// **'مثلاً: ۲۵۰ هزار تومن خرید نان'**
  String get chatHint;

  /// No description provided for @chatSend.
  ///
  /// In fa, this message translates to:
  /// **'ارسال'**
  String get chatSend;

  /// No description provided for @chatRegister.
  ///
  /// In fa, this message translates to:
  /// **'ثبت'**
  String get chatRegister;

  /// No description provided for @chatRegistered.
  ///
  /// In fa, this message translates to:
  /// **'ثبت شد'**
  String get chatRegistered;

  /// No description provided for @chatClear.
  ///
  /// In fa, this message translates to:
  /// **'پاک‌کردن گفتگو'**
  String get chatClear;

  /// No description provided for @chatChooseWallet.
  ///
  /// In fa, this message translates to:
  /// **'کیف را انتخاب کن'**
  String get chatChooseWallet;

  /// No description provided for @chatEmpty.
  ///
  /// In fa, this message translates to:
  /// **'جمله‌ای بنویس تا برایت کارت ثبت بسازم.'**
  String get chatEmpty;

  /// No description provided for @smsOpen.
  ///
  /// In fa, this message translates to:
  /// **'پیامک بانک'**
  String get smsOpen;

  /// No description provided for @smsTitle.
  ///
  /// In fa, this message translates to:
  /// **'پیامک بانک'**
  String get smsTitle;

  /// No description provided for @smsPasteLabel.
  ///
  /// In fa, this message translates to:
  /// **'متن پیامک را اینجا بچسبان'**
  String get smsPasteLabel;

  /// No description provided for @smsAnalyze.
  ///
  /// In fa, this message translates to:
  /// **'بررسی پیامک'**
  String get smsAnalyze;

  /// No description provided for @smsIgnoredOtp.
  ///
  /// In fa, this message translates to:
  /// **'این پیامک رمز یکبارمصرف است؛ ثبت نمی‌شود.'**
  String get smsIgnoredOtp;

  /// No description provided for @smsIgnoredFailed.
  ///
  /// In fa, this message translates to:
  /// **'این تراکنش ناموفق بوده؛ ثبت نمی‌شود.'**
  String get smsIgnoredFailed;

  /// No description provided for @smsIgnoredAd.
  ///
  /// In fa, this message translates to:
  /// **'این پیامک تبلیغاتی است؛ ثبت نمی‌شود.'**
  String get smsIgnoredAd;

  /// No description provided for @smsIgnoredNoAmount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغی در این پیامک پیدا نکردم.'**
  String get smsIgnoredNoAmount;

  /// No description provided for @smsKindLabel.
  ///
  /// In fa, this message translates to:
  /// **'نوع تراکنش'**
  String get smsKindLabel;

  /// No description provided for @smsWhatFor.
  ///
  /// In fa, this message translates to:
  /// **'برای چه بود؟'**
  String get smsWhatFor;

  /// No description provided for @smsBalance.
  ///
  /// In fa, this message translates to:
  /// **'مانده پس از تراکنش'**
  String get smsBalance;

  /// No description provided for @smsLowConfidence.
  ///
  /// In fa, this message translates to:
  /// **'مطمئن نیستم؛ لطفاً قبل از ثبت بررسی کن.'**
  String get smsLowConfidence;

  /// No description provided for @smsDuplicate.
  ///
  /// In fa, this message translates to:
  /// **'شبیه همین تراکنش قبلاً ثبت شده است. باز هم ثبت شود؟'**
  String get smsDuplicate;

  /// No description provided for @smsCardNote.
  ///
  /// In fa, this message translates to:
  /// **'این کارت (۴ رقم آخر {last4}) برای دفعه بعد به همین کیف وصل می‌شود.'**
  String smsCardNote(String last4);

  /// No description provided for @entryOutsideLabel.
  ///
  /// In fa, this message translates to:
  /// **'حساب‌وکتاب'**
  String get entryOutsideLabel;

  /// No description provided for @entryCounted.
  ///
  /// In fa, this message translates to:
  /// **'در جمع‌ها'**
  String get entryCounted;

  /// No description provided for @entryOutside.
  ///
  /// In fa, this message translates to:
  /// **'بیرون از جمع'**
  String get entryOutside;

  /// No description provided for @entryOutsideTag.
  ///
  /// In fa, this message translates to:
  /// **'بیرون از جمع'**
  String get entryOutsideTag;

  /// No description provided for @entrySplitTag.
  ///
  /// In fa, this message translates to:
  /// **'تقسیم‌شده'**
  String get entrySplitTag;

  /// No description provided for @splitOpen.
  ///
  /// In fa, this message translates to:
  /// **'تقسیم خرج'**
  String get splitOpen;

  /// No description provided for @splitTitle.
  ///
  /// In fa, this message translates to:
  /// **'تقسیم خرج'**
  String get splitTitle;

  /// No description provided for @splitPart.
  ///
  /// In fa, this message translates to:
  /// **'بخش'**
  String get splitPart;

  /// No description provided for @splitAddPart.
  ///
  /// In fa, this message translates to:
  /// **'افزودن بخش'**
  String get splitAddPart;

  /// No description provided for @splitTotal.
  ///
  /// In fa, this message translates to:
  /// **'جمع'**
  String get splitTotal;

  /// No description provided for @splitNeedsTwo.
  ///
  /// In fa, this message translates to:
  /// **'حداقل دو بخش با مبلغ درست لازم است.'**
  String get splitNeedsTwo;

  /// No description provided for @entryRefund.
  ///
  /// In fa, this message translates to:
  /// **'برگشت وجه'**
  String get entryRefund;

  /// No description provided for @refundOpen.
  ///
  /// In fa, this message translates to:
  /// **'برگشت'**
  String get refundOpen;

  /// No description provided for @refundTitle.
  ///
  /// In fa, this message translates to:
  /// **'برگشت وجه'**
  String get refundTitle;

  /// No description provided for @refundAmountLabel.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ (خالی = همه باقی‌مانده)'**
  String get refundAmountLabel;

  /// No description provided for @refundRemaining.
  ///
  /// In fa, this message translates to:
  /// **'قابل برگشت'**
  String get refundRemaining;

  /// No description provided for @entryRefundedTag.
  ///
  /// In fa, this message translates to:
  /// **'برگشت‌خورده'**
  String get entryRefundedTag;

  /// No description provided for @entryDeleteBlocked.
  ///
  /// In fa, this message translates to:
  /// **'این خرج برگشت دارد؛ اول برگشت‌ها را حذف کن.'**
  String get entryDeleteBlocked;

  /// No description provided for @refundInvalid.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ برگشت درست نیست یا بیشتر از باقی‌مانده است.'**
  String get refundInvalid;

  /// No description provided for @recurringOpen.
  ///
  /// In fa, this message translates to:
  /// **'تراکنش‌های تکراری'**
  String get recurringOpen;

  /// No description provided for @recurringTitle.
  ///
  /// In fa, this message translates to:
  /// **'تراکنش تکراری'**
  String get recurringTitle;

  /// No description provided for @recurringAdd.
  ///
  /// In fa, this message translates to:
  /// **'تکراری جدید'**
  String get recurringAdd;

  /// No description provided for @recurringNoteLabel.
  ///
  /// In fa, this message translates to:
  /// **'عنوان (مثلاً اجاره)'**
  String get recurringNoteLabel;

  /// No description provided for @recurringAmountLabel.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ (خالی = هر بار می‌پرسم)'**
  String get recurringAmountLabel;

  /// No description provided for @recurringPeriodLabel.
  ///
  /// In fa, this message translates to:
  /// **'تکرار'**
  String get recurringPeriodLabel;

  /// No description provided for @recurringMonthly.
  ///
  /// In fa, this message translates to:
  /// **'ماهانه'**
  String get recurringMonthly;

  /// No description provided for @recurringWeekly.
  ///
  /// In fa, this message translates to:
  /// **'هفتگی'**
  String get recurringWeekly;

  /// No description provided for @recurringDayLabel.
  ///
  /// In fa, this message translates to:
  /// **'روز ماه شمسی (۱ تا ۳۱)'**
  String get recurringDayLabel;

  /// No description provided for @recurringWeekdayLabel.
  ///
  /// In fa, this message translates to:
  /// **'روز هفته'**
  String get recurringWeekdayLabel;

  /// No description provided for @recurringAuto.
  ///
  /// In fa, this message translates to:
  /// **'ثبت خودکار روز سررسید'**
  String get recurringAuto;

  /// No description provided for @recurringAskMe.
  ///
  /// In fa, this message translates to:
  /// **'بپرس'**
  String get recurringAskMe;

  /// No description provided for @recurringNext.
  ///
  /// In fa, this message translates to:
  /// **'سررسید بعدی'**
  String get recurringNext;

  /// No description provided for @recurringPause.
  ///
  /// In fa, this message translates to:
  /// **'توقف'**
  String get recurringPause;

  /// No description provided for @recurringResume.
  ///
  /// In fa, this message translates to:
  /// **'ادامه'**
  String get recurringResume;

  /// No description provided for @recurringDayInvalid.
  ///
  /// In fa, this message translates to:
  /// **'روز درست نیست.'**
  String get recurringDayInvalid;

  /// No description provided for @weekdaySat.
  ///
  /// In fa, this message translates to:
  /// **'شنبه'**
  String get weekdaySat;

  /// No description provided for @weekdaySun.
  ///
  /// In fa, this message translates to:
  /// **'یکشنبه'**
  String get weekdaySun;

  /// No description provided for @weekdayMon.
  ///
  /// In fa, this message translates to:
  /// **'دوشنبه'**
  String get weekdayMon;

  /// No description provided for @weekdayTue.
  ///
  /// In fa, this message translates to:
  /// **'سه‌شنبه'**
  String get weekdayTue;

  /// No description provided for @weekdayWed.
  ///
  /// In fa, this message translates to:
  /// **'چهارشنبه'**
  String get weekdayWed;

  /// No description provided for @weekdayThu.
  ///
  /// In fa, this message translates to:
  /// **'پنجشنبه'**
  String get weekdayThu;

  /// No description provided for @weekdayFri.
  ///
  /// In fa, this message translates to:
  /// **'جمعه'**
  String get weekdayFri;

  /// No description provided for @occurrenceDueTitle.
  ///
  /// In fa, this message translates to:
  /// **'سررسید'**
  String get occurrenceDueTitle;

  /// No description provided for @occurrenceUpcoming.
  ///
  /// In fa, this message translates to:
  /// **'به‌زودی'**
  String get occurrenceUpcoming;

  /// No description provided for @occurrenceLowBalance.
  ///
  /// In fa, this message translates to:
  /// **'موجودی کیف برای این مبلغ کم است.'**
  String get occurrenceLowBalance;

  /// No description provided for @occurrenceDeducted.
  ///
  /// In fa, this message translates to:
  /// **'از همین حساب کسر شد'**
  String get occurrenceDeducted;

  /// No description provided for @occurrenceOtherWallet.
  ///
  /// In fa, this message translates to:
  /// **'از حساب دیگر'**
  String get occurrenceOtherWallet;

  /// No description provided for @occurrenceCancelled.
  ///
  /// In fa, this message translates to:
  /// **'لغو شد'**
  String get occurrenceCancelled;

  /// No description provided for @occurrenceAmountLabel.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ این بار'**
  String get occurrenceAmountLabel;

  /// No description provided for @occurrenceNeedsAmount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ این بار را بنویس.'**
  String get occurrenceNeedsAmount;

  /// No description provided for @occurrenceNotYet.
  ///
  /// In fa, this message translates to:
  /// **'هنوز نه'**
  String get occurrenceNotYet;

  /// No description provided for @occurrenceGotIt.
  ///
  /// In fa, this message translates to:
  /// **'گرفتم'**
  String get occurrenceGotIt;

  /// No description provided for @occurrenceDidYouGetIt.
  ///
  /// In fa, this message translates to:
  /// **'گرفتی؟'**
  String get occurrenceDidYouGetIt;

  /// No description provided for @recurringReceived.
  ///
  /// In fa, this message translates to:
  /// **'حقوق این ماه را گرفتم'**
  String get recurringReceived;

  /// No description provided for @recurringPaid.
  ///
  /// In fa, this message translates to:
  /// **'این ماه پرداخت شد'**
  String get recurringPaid;

  /// No description provided for @recurringCategoryLabel.
  ///
  /// In fa, this message translates to:
  /// **'دسته'**
  String get recurringCategoryLabel;

  /// No description provided for @digestTitle.
  ///
  /// In fa, this message translates to:
  /// **'حساب‌وکتاب امروز'**
  String get digestTitle;

  /// No description provided for @digestEntries.
  ///
  /// In fa, this message translates to:
  /// **'تراکنش ثبت‌شده امروز: {count}'**
  String digestEntries(String count);

  /// No description provided for @digestUncategorized.
  ///
  /// In fa, this message translates to:
  /// **'بدون دسته: {count}'**
  String digestUncategorized(String count);

  /// No description provided for @digestDue.
  ///
  /// In fa, this message translates to:
  /// **'سررسید منتظر پاسخ: {count}'**
  String digestDue(String count);

  /// No description provided for @digestNothingYet.
  ///
  /// In fa, this message translates to:
  /// **'امروز هنوز چیزی ثبت نکرده‌ای.'**
  String get digestNothingYet;

  /// No description provided for @accountingHourTitle.
  ///
  /// In fa, this message translates to:
  /// **'ساعت حساب‌وکتاب روزانه'**
  String get accountingHourTitle;

  /// No description provided for @accountingHourOff.
  ///
  /// In fa, this message translates to:
  /// **'خاموش'**
  String get accountingHourOff;

  /// No description provided for @debtAdd.
  ///
  /// In fa, this message translates to:
  /// **'وام یا قسط جدید'**
  String get debtAdd;

  /// No description provided for @debtTitle.
  ///
  /// In fa, this message translates to:
  /// **'وام یا قسط'**
  String get debtTitle;

  /// No description provided for @debtFormTitle.
  ///
  /// In fa, this message translates to:
  /// **'بدهی جدید'**
  String get debtFormTitle;

  /// No description provided for @debtKindLoan.
  ///
  /// In fa, this message translates to:
  /// **'وام بانکی'**
  String get debtKindLoan;

  /// No description provided for @debtKindPurchase.
  ///
  /// In fa, this message translates to:
  /// **'خرید اقساطی'**
  String get debtKindPurchase;

  /// No description provided for @debtKindPersonal.
  ///
  /// In fa, this message translates to:
  /// **'قرض شخصی'**
  String get debtKindPersonal;

  /// No description provided for @debtTitleLabel.
  ///
  /// In fa, this message translates to:
  /// **'عنوان (مثلاً وام مسکن)'**
  String get debtTitleLabel;

  /// No description provided for @debtInstallmentLabel.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ هر قسط'**
  String get debtInstallmentLabel;

  /// No description provided for @debtCountLabel.
  ///
  /// In fa, this message translates to:
  /// **'تعداد اقساط'**
  String get debtCountLabel;

  /// No description provided for @debtFirstDueLabel.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ اولین قسط (مثل ۱۴۰۵/۰۹/۱۵)'**
  String get debtFirstDueLabel;

  /// No description provided for @debtPrincipalLabel.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ اصل (اختیاری)'**
  String get debtPrincipalLabel;

  /// No description provided for @debtWalletLabel.
  ///
  /// In fa, this message translates to:
  /// **'کیف پرداخت (اختیاری)'**
  String get debtWalletLabel;

  /// No description provided for @debtRemaining.
  ///
  /// In fa, this message translates to:
  /// **'مانده'**
  String get debtRemaining;

  /// No description provided for @debtNextDue.
  ///
  /// In fa, this message translates to:
  /// **'قسط بعدی'**
  String get debtNextDue;

  /// No description provided for @debtClosed.
  ///
  /// In fa, this message translates to:
  /// **'تسویه شد'**
  String get debtClosed;

  /// No description provided for @debtOverdue.
  ///
  /// In fa, this message translates to:
  /// **'عقب‌افتاده'**
  String get debtOverdue;

  /// No description provided for @installmentPay.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت شد'**
  String get installmentPay;

  /// No description provided for @installmentUndo.
  ///
  /// In fa, this message translates to:
  /// **'لغو پرداخت'**
  String get installmentUndo;

  /// No description provided for @installmentPaid.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت‌شده'**
  String get installmentPaid;

  /// No description provided for @debtDelete.
  ///
  /// In fa, this message translates to:
  /// **'حذف بدهی'**
  String get debtDelete;

  /// No description provided for @debtCountInvalid.
  ///
  /// In fa, this message translates to:
  /// **'تعداد اقساط باید بین ۱ تا ۱۲۰ باشد.'**
  String get debtCountInvalid;

  /// No description provided for @debtDateInvalid.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ اولین قسط درست نیست.'**
  String get debtDateInvalid;

  /// No description provided for @debtPayWallet.
  ///
  /// In fa, this message translates to:
  /// **'از کدام کیف پرداخت شود؟'**
  String get debtPayWallet;

  /// No description provided for @debtPayFailed.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت انجام نشد؛ کیف و مبلغ را بررسی کن.'**
  String get debtPayFailed;

  /// No description provided for @assetsTitle.
  ///
  /// In fa, this message translates to:
  /// **'دارایی‌ها'**
  String get assetsTitle;

  /// No description provided for @assetAdd.
  ///
  /// In fa, this message translates to:
  /// **'دارایی جدید'**
  String get assetAdd;

  /// No description provided for @assetsValue.
  ///
  /// In fa, this message translates to:
  /// **'ارزش دارایی‌ها'**
  String get assetsValue;

  /// No description provided for @assetsProfit.
  ///
  /// In fa, this message translates to:
  /// **'سود و زیان'**
  String get assetsProfit;

  /// No description provided for @assetsRealized.
  ///
  /// In fa, this message translates to:
  /// **'سود تحقق‌یافته'**
  String get assetsRealized;

  /// No description provided for @assetFormTitle.
  ///
  /// In fa, this message translates to:
  /// **'دارایی جدید'**
  String get assetFormTitle;

  /// No description provided for @assetCustom.
  ///
  /// In fa, this message translates to:
  /// **'دلخواه'**
  String get assetCustom;

  /// No description provided for @assetNameLabel.
  ///
  /// In fa, this message translates to:
  /// **'نام دارایی'**
  String get assetNameLabel;

  /// No description provided for @assetQuantityLabel.
  ///
  /// In fa, this message translates to:
  /// **'مقدار'**
  String get assetQuantityLabel;

  /// No description provided for @assetBuyPriceLabel.
  ///
  /// In fa, this message translates to:
  /// **'قیمت خرید هر واحد (تومان)'**
  String get assetBuyPriceLabel;

  /// No description provided for @assetManualPriceLabel.
  ///
  /// In fa, this message translates to:
  /// **'قیمت امروز هر واحد (تومان)'**
  String get assetManualPriceLabel;

  /// No description provided for @assetBuyMore.
  ///
  /// In fa, this message translates to:
  /// **'خرید جدید'**
  String get assetBuyMore;

  /// No description provided for @assetSell.
  ///
  /// In fa, this message translates to:
  /// **'فروش'**
  String get assetSell;

  /// No description provided for @assetSellPriceLabel.
  ///
  /// In fa, this message translates to:
  /// **'قیمت فروش هر واحد (تومان)'**
  String get assetSellPriceLabel;

  /// No description provided for @assetDelete.
  ///
  /// In fa, this message translates to:
  /// **'حذف دارایی'**
  String get assetDelete;

  /// No description provided for @assetUnknownPrice.
  ///
  /// In fa, this message translates to:
  /// **'قیمت این دارایی هنوز معلوم نیست.'**
  String get assetUnknownPrice;

  /// No description provided for @assetStale.
  ///
  /// In fa, this message translates to:
  /// **'قیمت کهنه'**
  String get assetStale;

  /// No description provided for @assetQuantityInvalid.
  ///
  /// In fa, this message translates to:
  /// **'مقدار درست نیست.'**
  String get assetQuantityInvalid;

  /// No description provided for @assetPriceInvalid.
  ///
  /// In fa, this message translates to:
  /// **'قیمت درست نیست.'**
  String get assetPriceInvalid;

  /// No description provided for @assetNameInvalid.
  ///
  /// In fa, this message translates to:
  /// **'نام و قیمت امروز لازم است.'**
  String get assetNameInvalid;

  /// No description provided for @assetFailed.
  ///
  /// In fa, this message translates to:
  /// **'انجام نشد؛ مقدار و قیمت را بررسی کن.'**
  String get assetFailed;

  /// No description provided for @assetCost.
  ///
  /// In fa, this message translates to:
  /// **'هزینه خرید'**
  String get assetCost;

  /// No description provided for @assetHeld.
  ///
  /// In fa, this message translates to:
  /// **'مقدار فعلی'**
  String get assetHeld;

  /// No description provided for @pricesOpen.
  ///
  /// In fa, this message translates to:
  /// **'قیمت‌ها'**
  String get pricesOpen;

  /// No description provided for @pricesTitle.
  ///
  /// In fa, this message translates to:
  /// **'قیمت‌ها'**
  String get pricesTitle;

  /// No description provided for @priceUnknown.
  ///
  /// In fa, this message translates to:
  /// **'نامشخص'**
  String get priceUnknown;

  /// No description provided for @priceStaleSuffix.
  ///
  /// In fa, this message translates to:
  /// **'کهنه'**
  String get priceStaleSuffix;

  /// No description provided for @priceSourcePrefix.
  ///
  /// In fa, this message translates to:
  /// **'منبع'**
  String get priceSourcePrefix;

  /// No description provided for @netWorthTitle.
  ///
  /// In fa, this message translates to:
  /// **'خالص دارایی'**
  String get netWorthTitle;

  /// No description provided for @netWorthWallets.
  ///
  /// In fa, this message translates to:
  /// **'کیف‌ها'**
  String get netWorthWallets;

  /// No description provided for @netWorthAssets.
  ///
  /// In fa, this message translates to:
  /// **'دارایی‌ها'**
  String get netWorthAssets;

  /// No description provided for @netWorthDebts.
  ///
  /// In fa, this message translates to:
  /// **'بدهی‌ها'**
  String get netWorthDebts;

  /// No description provided for @netWorthGold.
  ///
  /// In fa, this message translates to:
  /// **'گرم طلای ۱۸ عیار'**
  String get netWorthGold;

  /// No description provided for @netWorthStale.
  ///
  /// In fa, this message translates to:
  /// **'بعضی نرخ‌ها کهنه‌اند؛ عدد تقریبی است.'**
  String get netWorthStale;

  /// No description provided for @netWorthUnconverted.
  ///
  /// In fa, this message translates to:
  /// **'ارزهای بدون نرخ (کنار گذاشته شد): {codes}'**
  String netWorthUnconverted(String codes);

  /// No description provided for @netWorthUnpriced.
  ///
  /// In fa, this message translates to:
  /// **'دارایی بدون قیمت: {count}'**
  String netWorthUnpriced(String count);

  /// No description provided for @basketsTitle.
  ///
  /// In fa, this message translates to:
  /// **'سبدهای هدف'**
  String get basketsTitle;

  /// No description provided for @basketAdd.
  ///
  /// In fa, this message translates to:
  /// **'سبد هدف جدید'**
  String get basketAdd;

  /// No description provided for @basketFormTitle.
  ///
  /// In fa, this message translates to:
  /// **'سبد هدف'**
  String get basketFormTitle;

  /// No description provided for @basketNameLabel.
  ///
  /// In fa, this message translates to:
  /// **'نام هدف (مثلاً پیش‌پرداخت خانه)'**
  String get basketNameLabel;

  /// No description provided for @basketTargetLabel.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ هدف (تومان)'**
  String get basketTargetLabel;

  /// No description provided for @basketItemsLabel.
  ///
  /// In fa, this message translates to:
  /// **'چه چیزهایی به این هدف حساب شود؟'**
  String get basketItemsLabel;

  /// No description provided for @basketTargetInvalid.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ هدف درست نیست.'**
  String get basketTargetInvalid;

  /// No description provided for @basketDelete.
  ///
  /// In fa, this message translates to:
  /// **'حذف سبد'**
  String get basketDelete;

  /// No description provided for @basketProgress.
  ///
  /// In fa, this message translates to:
  /// **'{percent}٪ از هدف'**
  String basketProgress(String percent);

  /// No description provided for @reportOpen.
  ///
  /// In fa, this message translates to:
  /// **'گزارش ماه'**
  String get reportOpen;

  /// No description provided for @reportTitle.
  ///
  /// In fa, this message translates to:
  /// **'گزارش ماه'**
  String get reportTitle;

  /// No description provided for @reportPrev.
  ///
  /// In fa, this message translates to:
  /// **'ماه قبل'**
  String get reportPrev;

  /// No description provided for @reportNext.
  ///
  /// In fa, this message translates to:
  /// **'ماه بعد'**
  String get reportNext;

  /// No description provided for @reportIncome.
  ///
  /// In fa, this message translates to:
  /// **'درآمد'**
  String get reportIncome;

  /// No description provided for @reportExpense.
  ///
  /// In fa, this message translates to:
  /// **'خرج'**
  String get reportExpense;

  /// No description provided for @reportNet.
  ///
  /// In fa, this message translates to:
  /// **'خالص'**
  String get reportNet;

  /// No description provided for @reportByCategory.
  ///
  /// In fa, this message translates to:
  /// **'خرج به تفکیک دسته'**
  String get reportByCategory;

  /// No description provided for @reportIncomeByCategory.
  ///
  /// In fa, this message translates to:
  /// **'درآمد به تفکیک دسته'**
  String get reportIncomeByCategory;

  /// No description provided for @reportDaily.
  ///
  /// In fa, this message translates to:
  /// **'خرج روزانه'**
  String get reportDaily;

  /// No description provided for @reportEmpty.
  ///
  /// In fa, this message translates to:
  /// **'در این ماه تراکنشی نیست.'**
  String get reportEmpty;

  /// No description provided for @reportEntries.
  ///
  /// In fa, this message translates to:
  /// **'تعداد تراکنش: {count}'**
  String reportEntries(String count);

  /// No description provided for @reportTop.
  ///
  /// In fa, this message translates to:
  /// **'پرخرج‌ترین دسته: {name}'**
  String reportTop(String name);

  /// No description provided for @reportFailed.
  ///
  /// In fa, this message translates to:
  /// **'گزارش گرفته نشد. دوباره امتحان کن.'**
  String get reportFailed;

  /// No description provided for @outboxPending.
  ///
  /// In fa, this message translates to:
  /// **'تراکنش در انتظار ارسال: {count}'**
  String outboxPending(String count);

  /// No description provided for @outboxRetry.
  ///
  /// In fa, this message translates to:
  /// **'ارسال دوباره'**
  String get outboxRetry;

  /// No description provided for @outboxSavedOffline.
  ///
  /// In fa, this message translates to:
  /// **'اینترنت نیست؛ ذخیره شد و با اتصال فرستاده می‌شود.'**
  String get outboxSavedOffline;

  /// No description provided for @outboxFailedTitle.
  ///
  /// In fa, this message translates to:
  /// **'این تراکنش‌ها ثبت نشدند'**
  String get outboxFailedTitle;

  /// No description provided for @outboxFailedDismiss.
  ///
  /// In fa, this message translates to:
  /// **'حذف'**
  String get outboxFailedDismiss;

  /// No description provided for @outboxQueued.
  ///
  /// In fa, this message translates to:
  /// **'در انتظار ارسال'**
  String get outboxQueued;

  /// No description provided for @billingOpen.
  ///
  /// In fa, this message translates to:
  /// **'اشتراک'**
  String get billingOpen;

  /// No description provided for @billingTitle.
  ///
  /// In fa, this message translates to:
  /// **'اشتراک'**
  String get billingTitle;

  /// No description provided for @billingStatusNone.
  ///
  /// In fa, this message translates to:
  /// **'هنوز اشتراکی نداری.'**
  String get billingStatusNone;

  /// No description provided for @billingStatusTrial.
  ///
  /// In fa, this message translates to:
  /// **'دوره آزمایشی؛ {days} روز مانده'**
  String billingStatusTrial(String days);

  /// No description provided for @billingStatusActive.
  ///
  /// In fa, this message translates to:
  /// **'اشتراک فعال؛ {days} روز مانده'**
  String billingStatusActive(String days);

  /// No description provided for @billingStatusExpired.
  ///
  /// In fa, this message translates to:
  /// **'اشتراکت تمام شده است.'**
  String get billingStatusExpired;

  /// No description provided for @billingStartTrial.
  ///
  /// In fa, this message translates to:
  /// **'شروع دوره آزمایشی'**
  String get billingStartTrial;

  /// No description provided for @billingBuy.
  ///
  /// In fa, this message translates to:
  /// **'خرید'**
  String get billingBuy;

  /// No description provided for @billingNoPlans.
  ///
  /// In fa, this message translates to:
  /// **'فعلاً پلنی برای خرید نیست.'**
  String get billingNoPlans;

  /// No description provided for @billingPlanLine.
  ///
  /// In fa, this message translates to:
  /// **'{price} تومان · {days} روز'**
  String billingPlanLine(String price, String days);

  /// No description provided for @billingPayAt.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت را اینجا انجام بده:'**
  String get billingPayAt;

  /// No description provided for @billingCheckPayment.
  ///
  /// In fa, this message translates to:
  /// **'بررسی پرداخت'**
  String get billingCheckPayment;

  /// No description provided for @billingNotConfirmed.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت هنوز تأیید نشده.'**
  String get billingNotConfirmed;

  /// No description provided for @billingFailed.
  ///
  /// In fa, this message translates to:
  /// **'انجام نشد. دوباره امتحان کن.'**
  String get billingFailed;

  /// No description provided for @readOnlyBanner.
  ///
  /// In fa, this message translates to:
  /// **'اشتراکت تمام شده؛ فعلاً فقط می‌توانی داده‌ات را ببینی.'**
  String get readOnlyBanner;

  /// No description provided for @readOnlyRenew.
  ///
  /// In fa, this message translates to:
  /// **'تمدید'**
  String get readOnlyRenew;

  /// No description provided for @supportOpen.
  ///
  /// In fa, this message translates to:
  /// **'پشتیبانی'**
  String get supportOpen;

  /// No description provided for @supportTitle.
  ///
  /// In fa, this message translates to:
  /// **'پشتیبانی'**
  String get supportTitle;

  /// No description provided for @supportNew.
  ///
  /// In fa, this message translates to:
  /// **'تیکت جدید'**
  String get supportNew;

  /// No description provided for @supportEmpty.
  ///
  /// In fa, this message translates to:
  /// **'هنوز تیکتی نداری.'**
  String get supportEmpty;

  /// No description provided for @supportSubjectLabel.
  ///
  /// In fa, this message translates to:
  /// **'موضوع'**
  String get supportSubjectLabel;

  /// No description provided for @supportBodyLabel.
  ///
  /// In fa, this message translates to:
  /// **'مشکل یا سؤالت را بنویس'**
  String get supportBodyLabel;

  /// No description provided for @supportSend.
  ///
  /// In fa, this message translates to:
  /// **'ارسال'**
  String get supportSend;

  /// No description provided for @supportReplyHint.
  ///
  /// In fa, this message translates to:
  /// **'پیامت را بنویس'**
  String get supportReplyHint;

  /// No description provided for @supportSubjectRequired.
  ///
  /// In fa, this message translates to:
  /// **'موضوع و متن را بنویس.'**
  String get supportSubjectRequired;

  /// No description provided for @supportFailed.
  ///
  /// In fa, this message translates to:
  /// **'ارسال نشد. دوباره امتحان کن.'**
  String get supportFailed;

  /// No description provided for @supportStatusOpen.
  ///
  /// In fa, this message translates to:
  /// **'باز'**
  String get supportStatusOpen;

  /// No description provided for @supportStatusPending.
  ///
  /// In fa, this message translates to:
  /// **'در انتظار پاسخ'**
  String get supportStatusPending;

  /// No description provided for @supportStatusResolved.
  ///
  /// In fa, this message translates to:
  /// **'حل شد'**
  String get supportStatusResolved;

  /// No description provided for @supportStatusClosed.
  ///
  /// In fa, this message translates to:
  /// **'بسته'**
  String get supportStatusClosed;

  /// No description provided for @supportFromTeam.
  ///
  /// In fa, this message translates to:
  /// **'پشتیبان'**
  String get supportFromTeam;

  /// No description provided for @supportFromYou.
  ///
  /// In fa, this message translates to:
  /// **'تو'**
  String get supportFromYou;

  /// No description provided for @supportUnread.
  ///
  /// In fa, this message translates to:
  /// **'پیام جدید'**
  String get supportUnread;

  /// No description provided for @lockTitle.
  ///
  /// In fa, this message translates to:
  /// **'Summa قفل است'**
  String get lockTitle;

  /// No description provided for @lockPasscodeLabel.
  ///
  /// In fa, this message translates to:
  /// **'رمز اپ'**
  String get lockPasscodeLabel;

  /// No description provided for @lockUnlock.
  ///
  /// In fa, this message translates to:
  /// **'باز کردن'**
  String get lockUnlock;

  /// No description provided for @lockBiometric.
  ///
  /// In fa, this message translates to:
  /// **'باز کردن با بیومتریک'**
  String get lockBiometric;

  /// No description provided for @lockWrong.
  ///
  /// In fa, this message translates to:
  /// **'رمز درست نیست.'**
  String get lockWrong;

  /// No description provided for @lockWait.
  ///
  /// In fa, this message translates to:
  /// **'تلاش‌ها زیاد بود؛ کمی صبر کن و دوباره امتحان کن.'**
  String get lockWait;

  /// No description provided for @privacyOpen.
  ///
  /// In fa, this message translates to:
  /// **'حریم و امنیت'**
  String get privacyOpen;

  /// No description provided for @privacyTitle.
  ///
  /// In fa, this message translates to:
  /// **'حریم و امنیت'**
  String get privacyTitle;

  /// No description provided for @lockEnable.
  ///
  /// In fa, this message translates to:
  /// **'فعال‌کردن قفل اپ'**
  String get lockEnable;

  /// No description provided for @lockDisable.
  ///
  /// In fa, this message translates to:
  /// **'خاموش‌کردن قفل'**
  String get lockDisable;

  /// No description provided for @lockChange.
  ///
  /// In fa, this message translates to:
  /// **'تغییر رمز'**
  String get lockChange;

  /// No description provided for @lockNewPasscode.
  ///
  /// In fa, this message translates to:
  /// **'رمز جدید (۴ تا ۸ رقم)'**
  String get lockNewPasscode;

  /// No description provided for @lockConfirmPasscode.
  ///
  /// In fa, this message translates to:
  /// **'تکرار رمز'**
  String get lockConfirmPasscode;

  /// No description provided for @lockMismatch.
  ///
  /// In fa, this message translates to:
  /// **'دو رمز یکی نیست.'**
  String get lockMismatch;

  /// No description provided for @lockInvalid.
  ///
  /// In fa, this message translates to:
  /// **'رمز باید ۴ تا ۸ رقم باشد.'**
  String get lockInvalid;

  /// No description provided for @lockCurrentPasscode.
  ///
  /// In fa, this message translates to:
  /// **'رمز فعلی'**
  String get lockCurrentPasscode;

  /// No description provided for @lockBiometricToggle.
  ///
  /// In fa, this message translates to:
  /// **'بیومتریک'**
  String get lockBiometricToggle;

  /// No description provided for @lockOn.
  ///
  /// In fa, this message translates to:
  /// **'روشن'**
  String get lockOn;

  /// No description provided for @lockOff.
  ///
  /// In fa, this message translates to:
  /// **'خاموش'**
  String get lockOff;

  /// No description provided for @lockDelayLabel.
  ///
  /// In fa, this message translates to:
  /// **'قفل خودکار بعد از'**
  String get lockDelayLabel;

  /// No description provided for @lockDelayNow.
  ///
  /// In fa, this message translates to:
  /// **'فوری'**
  String get lockDelayNow;

  /// No description provided for @lockDelaySeconds.
  ///
  /// In fa, this message translates to:
  /// **'{count} ثانیه'**
  String lockDelaySeconds(String count);

  /// No description provided for @lockDelayMinutes.
  ///
  /// In fa, this message translates to:
  /// **'{count} دقیقه'**
  String lockDelayMinutes(String count);

  /// No description provided for @lockSave.
  ///
  /// In fa, this message translates to:
  /// **'ذخیره'**
  String get lockSave;

  /// No description provided for @strongAuthReason.
  ///
  /// In fa, this message translates to:
  /// **'برای ادامه هویتت را تأیید کن'**
  String get strongAuthReason;

  /// No description provided for @strongAuthNeedPasscode.
  ///
  /// In fa, this message translates to:
  /// **'این کار حساس است. اول یک رمز برای اپ تعیین کن.'**
  String get strongAuthNeedPasscode;

  /// No description provided for @strongAuthPrompt.
  ///
  /// In fa, this message translates to:
  /// **'رمز اپ را وارد کن'**
  String get strongAuthPrompt;

  /// No description provided for @strongAuthDenied.
  ///
  /// In fa, this message translates to:
  /// **'تأیید نشد.'**
  String get strongAuthDenied;

  /// No description provided for @retentionTitle.
  ///
  /// In fa, this message translates to:
  /// **'نگه‌داری چت'**
  String get retentionTitle;

  /// No description provided for @retentionForever.
  ///
  /// In fa, this message translates to:
  /// **'همیشه'**
  String get retentionForever;

  /// No description provided for @retentionDays.
  ///
  /// In fa, this message translates to:
  /// **'{count} روز'**
  String retentionDays(String count);

  /// No description provided for @deleteAccountOpen.
  ///
  /// In fa, this message translates to:
  /// **'حذف حساب'**
  String get deleteAccountOpen;

  /// No description provided for @deleteAccountWarning.
  ///
  /// In fa, this message translates to:
  /// **'همه داده‌هایت برای همیشه پاک می‌شود و برگشتی ندارد. برای تأیید DELETE را بنویس.'**
  String get deleteAccountWarning;

  /// No description provided for @deleteAccountConfirmLabel.
  ///
  /// In fa, this message translates to:
  /// **'عبارت تأیید'**
  String get deleteAccountConfirmLabel;

  /// No description provided for @deleteAccountButton.
  ///
  /// In fa, this message translates to:
  /// **'حذف همیشگی حساب'**
  String get deleteAccountButton;

  /// No description provided for @deleteAccountFailed.
  ///
  /// In fa, this message translates to:
  /// **'حذف انجام نشد. عبارت را درست بنویس یا دوباره امتحان کن.'**
  String get deleteAccountFailed;

  /// No description provided for @dataOpen.
  ///
  /// In fa, this message translates to:
  /// **'خروجی و ورود داده'**
  String get dataOpen;

  /// No description provided for @dataTitle.
  ///
  /// In fa, this message translates to:
  /// **'خروجی و ورود داده'**
  String get dataTitle;

  /// No description provided for @dataExport.
  ///
  /// In fa, this message translates to:
  /// **'گرفتن خروجی CSV'**
  String get dataExport;

  /// No description provided for @dataExported.
  ///
  /// In fa, this message translates to:
  /// **'خروجی آماده شد: {where}'**
  String dataExported(String where);

  /// No description provided for @dataExportFailed.
  ///
  /// In fa, this message translates to:
  /// **'خروجی گرفته نشد. دوباره امتحان کن.'**
  String get dataExportFailed;

  /// No description provided for @dataImportTitle.
  ///
  /// In fa, this message translates to:
  /// **'ورود از CSV'**
  String get dataImportTitle;

  /// No description provided for @dataImportHint.
  ///
  /// In fa, this message translates to:
  /// **'متن CSV را اینجا بچسبان (سرستون‌ها: date، kind، amount، wallet، …)'**
  String get dataImportHint;

  /// No description provided for @dataPreview.
  ///
  /// In fa, this message translates to:
  /// **'پیش‌نمایش'**
  String get dataPreview;

  /// No description provided for @dataImport.
  ///
  /// In fa, this message translates to:
  /// **'ورود تراکنش‌ها'**
  String get dataImport;

  /// No description provided for @dataDenied.
  ///
  /// In fa, this message translates to:
  /// **'تأیید هویت نشد؛ کاری انجام نشد.'**
  String get dataDenied;

  /// No description provided for @dataPreviewResult.
  ///
  /// In fa, this message translates to:
  /// **'ردیف‌ها: {rows} · قابل ورود: {ok} · ردشده: {skipped}'**
  String dataPreviewResult(String rows, String ok, String skipped);

  /// No description provided for @dataImported.
  ///
  /// In fa, this message translates to:
  /// **'{count} تراکنش وارد شد.'**
  String dataImported(String count);

  /// No description provided for @dataLineError.
  ///
  /// In fa, this message translates to:
  /// **'خط {line}: {message}'**
  String dataLineError(String line, String message);

  /// No description provided for @dataImportFailed.
  ///
  /// In fa, this message translates to:
  /// **'ورود انجام نشد. فایل را بررسی کن.'**
  String get dataImportFailed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'fa':
      return AppLocalizationsFa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
