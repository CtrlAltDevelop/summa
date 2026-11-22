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
