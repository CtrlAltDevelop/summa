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
