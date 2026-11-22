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
