// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Summa';

  @override
  String get healthTitle => 'Server connection';

  @override
  String get healthChecking => 'Checking…';

  @override
  String get healthOk => 'Server is ready';

  @override
  String get healthFailed => 'Could not connect';

  @override
  String get healthRetry => 'Check again';

  @override
  String healthLatency(String ms) {
    return 'Latency: $ms ms';
  }

  @override
  String get galleryTitle => 'Component gallery';

  @override
  String get galleryButton => 'Primary button';

  @override
  String get galleryCard => 'Glass card';

  @override
  String get galleryCount => 'Counter';

  @override
  String get galleryStatus => 'Statuses';

  @override
  String get statusOk => 'Success';

  @override
  String get statusWarn => 'Warning';

  @override
  String get statusBad => 'Error';

  @override
  String get loginTitle => 'Sign in to Summa';

  @override
  String get loginSubtitle =>
      'Enter your mobile number and we will send you a verification code.';

  @override
  String get phoneLabel => 'Mobile number';

  @override
  String get phoneHint => '0912 345 6789';

  @override
  String get sendCode => 'Send code';

  @override
  String get codeTitle => 'Verification code';

  @override
  String codeSubtitle(String destination) {
    return 'A 6-digit code was sent to $destination.';
  }

  @override
  String get codeLabel => '6-digit code';

  @override
  String get verify => 'Verify';

  @override
  String resendIn(String seconds) {
    return 'Resend in $seconds s';
  }

  @override
  String get resend => 'Resend code';

  @override
  String get changeNumber => 'Change number';

  @override
  String get nameTitle => 'What is your name?';

  @override
  String get nameSubtitle => 'This is how we will greet you.';

  @override
  String get nameLabel => 'Name';

  @override
  String get continueLabel => 'Continue';

  @override
  String homeGreeting(String name) {
    return 'Hello $name';
  }

  @override
  String get signOut => 'Sign out';

  @override
  String get errInvalidPhone =>
      'This number is not valid. Enter an Iranian mobile number.';

  @override
  String get errWrongCode => 'The code is wrong or has expired. Try again.';

  @override
  String get errTooMany => 'Too many attempts. Try again in a little while.';

  @override
  String get errOffline => 'Could not connect. Check your internet.';

  @override
  String get errUnknown => 'Something went wrong. Try again.';

  @override
  String get retry => 'Try again';

  @override
  String get walletsTotalTitle => 'Ledger balance';

  @override
  String get walletsEmpty =>
      'You have no wallets yet. Create the first one to see your balance.';

  @override
  String get walletAdd => 'New wallet';

  @override
  String get walletFormTitle => 'New wallet';

  @override
  String get walletNameLabel => 'Wallet name';

  @override
  String get walletKindLabel => 'Type';

  @override
  String get walletCurrencyLabel => 'Currency';

  @override
  String get walletBankLabel => 'Bank (optional)';

  @override
  String get walletOpeningLabel => 'Opening balance';

  @override
  String get walletSave => 'Save';

  @override
  String get walletNameRequired => 'Enter a name for the wallet.';

  @override
  String get walletBalanceInvalid =>
      'The opening balance is not valid. Only credit cards and installments can start negative.';

  @override
  String get kindCash => 'Cash';

  @override
  String get kindBank => 'Bank account';

  @override
  String get kindCreditCard => 'Credit card';

  @override
  String get kindBnpl => 'Installment purchase';

  @override
  String get kindGiftCard => 'Gift card';

  @override
  String get kindCrypto => 'Crypto';

  @override
  String get kindGold => 'Gold';

  @override
  String get currencyIRT => 'Toman';

  @override
  String get currencyIRR => 'Rial';

  @override
  String get currencyUSD => 'Dollar';

  @override
  String get currencyEUR => 'Euro';

  @override
  String get currencyAED => 'Dirham';

  @override
  String get currencyTRY => 'Lira';

  @override
  String get currencyUSDT => 'Tether';

  @override
  String get entryAdd => 'Record an expense or income';

  @override
  String get entryFormTitle => 'New entry';

  @override
  String get entryExpense => 'Expense';

  @override
  String get entryIncome => 'Income';

  @override
  String get entryWalletLabel => 'Wallet';

  @override
  String get entryAmountLabel => 'Amount';

  @override
  String get entryNoteLabel => 'Note (optional)';

  @override
  String get entryAmountInvalid =>
      'The amount is not valid. Enter a number greater than zero.';

  @override
  String get entryDelete => 'Delete';

  @override
  String get transferAdd => 'Transfer between wallets';

  @override
  String get transferFormTitle => 'Transfer money';

  @override
  String get transferFrom => 'From wallet';

  @override
  String get transferTo => 'To wallet';

  @override
  String get transferRateLabel => 'Rate (target units per one source unit)';

  @override
  String get transferFeeLabel => 'Fee (optional)';

  @override
  String get transferOut => 'Transfer (withdrawal)';

  @override
  String get transferIn => 'Transfer (deposit)';

  @override
  String get transferSameWallet =>
      'The source and target must be two different wallets.';

  @override
  String get transferRateInvalid =>
      'The rate is not valid. Enter a number greater than zero.';

  @override
  String get transferFeeInvalid => 'The fee is not valid.';

  @override
  String get entryCategoryLabel => 'Category';

  @override
  String get categoriesTitle => 'Categories and caps';

  @override
  String get categoriesOpen => 'Categories and monthly caps';

  @override
  String get categoryNameLabel => 'New category name';

  @override
  String get categoryAdd => 'Add';

  @override
  String get categoryExpenses => 'Expense categories';

  @override
  String get categoryIncomes => 'Income categories';

  @override
  String get categoryNameInvalid =>
      'The category name is not valid or already exists.';

  @override
  String get budgetSet => 'Cap';

  @override
  String get budgetFormTitle => 'Monthly cap';

  @override
  String get budgetLimitLabel => 'Cap (zero means no cap)';

  @override
  String get budgetCurrencyLabel => 'Currency';

  @override
  String get budgetsTitle => 'This month\'s caps';

  @override
  String get budgetOver => 'Over the cap';

  @override
  String get budgetWarning => 'Close to the cap';

  @override
  String get chatOpen => 'Assistant';

  @override
  String get chatTitle => 'Assistant';

  @override
  String get chatHint => 'e.g. 250,000 toman on bread';

  @override
  String get chatSend => 'Send';

  @override
  String get chatRegister => 'Register';

  @override
  String get chatRegistered => 'Registered';

  @override
  String get chatClear => 'Clear chat';

  @override
  String get chatChooseWallet => 'Choose a wallet';

  @override
  String get chatEmpty =>
      'Write a sentence and I will make a card to register.';

  @override
  String get smsOpen => 'Bank SMS';

  @override
  String get smsTitle => 'Bank SMS';

  @override
  String get smsPasteLabel => 'Paste the SMS text here';

  @override
  String get smsAnalyze => 'Check SMS';

  @override
  String get smsIgnoredOtp =>
      'This SMS is a one-time code; it will not be registered.';

  @override
  String get smsIgnoredFailed =>
      'This transaction failed; it will not be registered.';

  @override
  String get smsIgnoredAd =>
      'This SMS is an advertisement; it will not be registered.';

  @override
  String get smsIgnoredNoAmount => 'I could not find an amount in this SMS.';

  @override
  String get smsKindLabel => 'Transaction type';

  @override
  String get smsWhatFor => 'What was it for?';

  @override
  String get smsBalance => 'Balance after the transaction';

  @override
  String get smsLowConfidence =>
      'I am not sure; please check before registering.';

  @override
  String get smsDuplicate =>
      'A similar transaction was already registered. Register anyway?';

  @override
  String smsCardNote(String last4) {
    return 'This card (last 4 digits $last4) will be linked to this wallet next time.';
  }

  @override
  String get entryOutsideLabel => 'Ledger';

  @override
  String get entryCounted => 'In totals';

  @override
  String get entryOutside => 'Outside totals';

  @override
  String get entryOutsideTag => 'Outside totals';

  @override
  String get entrySplitTag => 'Split';

  @override
  String get splitOpen => 'Split an expense';

  @override
  String get splitTitle => 'Split an expense';

  @override
  String get splitPart => 'Part';

  @override
  String get splitAddPart => 'Add a part';

  @override
  String get splitTotal => 'Total';

  @override
  String get splitNeedsTwo =>
      'At least two parts with a valid amount are needed.';

  @override
  String get entryRefund => 'Refund';

  @override
  String get refundOpen => 'Refund';

  @override
  String get refundTitle => 'Refund';

  @override
  String get refundAmountLabel => 'Amount (empty = everything left)';

  @override
  String get refundRemaining => 'Refundable';

  @override
  String get entryRefundedTag => 'Refunded';

  @override
  String get entryDeleteBlocked =>
      'This expense has a refund; delete the refunds first.';

  @override
  String get refundInvalid =>
      'The refund amount is not valid or is more than what is left.';

  @override
  String get recurringOpen => 'Recurring transactions';

  @override
  String get recurringTitle => 'Recurring transaction';

  @override
  String get recurringAdd => 'New recurring';

  @override
  String get recurringNoteLabel => 'Title (e.g. rent)';

  @override
  String get recurringAmountLabel => 'Amount (empty = I ask each time)';

  @override
  String get recurringPeriodLabel => 'Repeats';

  @override
  String get recurringMonthly => 'Monthly';

  @override
  String get recurringWeekly => 'Weekly';

  @override
  String get recurringDayLabel => 'Day of the Shamsi month (1 to 31)';

  @override
  String get recurringWeekdayLabel => 'Day of the week';

  @override
  String get recurringAuto => 'Register automatically on the due day';

  @override
  String get recurringAskMe => 'Ask me';

  @override
  String get recurringNext => 'Next due';

  @override
  String get recurringPause => 'Pause';

  @override
  String get recurringResume => 'Resume';

  @override
  String get recurringDayInvalid => 'The day is not valid.';

  @override
  String get weekdaySat => 'Saturday';

  @override
  String get weekdaySun => 'Sunday';

  @override
  String get weekdayMon => 'Monday';

  @override
  String get weekdayTue => 'Tuesday';

  @override
  String get weekdayWed => 'Wednesday';

  @override
  String get weekdayThu => 'Thursday';

  @override
  String get weekdayFri => 'Friday';

  @override
  String get occurrenceDueTitle => 'Due';

  @override
  String get occurrenceUpcoming => 'Upcoming';

  @override
  String get occurrenceLowBalance =>
      'The wallet balance is low for this amount.';

  @override
  String get occurrenceDeducted => 'Deducted from this account';

  @override
  String get occurrenceOtherWallet => 'From another account';

  @override
  String get occurrenceCancelled => 'Cancelled';

  @override
  String get occurrenceAmountLabel => 'Amount this time';

  @override
  String get occurrenceNeedsAmount => 'Enter the amount for this time.';

  @override
  String get occurrenceNotYet => 'Not yet';

  @override
  String get occurrenceGotIt => 'Got it';

  @override
  String get occurrenceDidYouGetIt => 'Did you get it?';

  @override
  String get recurringReceived => 'I received this month\'s salary';

  @override
  String get recurringPaid => 'Paid this month';

  @override
  String get recurringCategoryLabel => 'Category';

  @override
  String get digestTitle => 'Today\'s books';

  @override
  String digestEntries(String count) {
    return 'Entries recorded today: $count';
  }

  @override
  String digestUncategorized(String count) {
    return 'Uncategorized: $count';
  }

  @override
  String digestDue(String count) {
    return 'Dues waiting for an answer: $count';
  }

  @override
  String get digestNothingYet => 'You have not recorded anything today.';

  @override
  String get accountingHourTitle => 'Daily accounting hour';

  @override
  String get accountingHourOff => 'Off';

  @override
  String get debtAdd => 'New loan or installment';

  @override
  String get debtTitle => 'Loan or installment';

  @override
  String get debtFormTitle => 'New debt';

  @override
  String get debtKindLoan => 'Bank loan';

  @override
  String get debtKindPurchase => 'Installment purchase';

  @override
  String get debtKindPersonal => 'Personal debt';

  @override
  String get debtTitleLabel => 'Title (e.g. mortgage)';

  @override
  String get debtInstallmentLabel => 'Amount of each installment';

  @override
  String get debtCountLabel => 'Number of installments';

  @override
  String get debtFirstDueLabel => 'First installment date (e.g. 1405/09/15)';

  @override
  String get debtPrincipalLabel => 'Principal (optional)';

  @override
  String get debtWalletLabel => 'Paying wallet (optional)';

  @override
  String get debtRemaining => 'Remaining';

  @override
  String get debtNextDue => 'Next installment';

  @override
  String get debtClosed => 'Settled';

  @override
  String get debtOverdue => 'Overdue';

  @override
  String get installmentPay => 'Paid';

  @override
  String get installmentUndo => 'Undo payment';

  @override
  String get installmentPaid => 'Paid';

  @override
  String get debtDelete => 'Delete debt';

  @override
  String get debtCountInvalid =>
      'The number of installments must be between 1 and 120.';

  @override
  String get debtDateInvalid => 'The first installment date is not valid.';

  @override
  String get debtPayWallet => 'Which wallet pays?';

  @override
  String get debtPayFailed =>
      'The payment failed; check the wallet and amount.';

  @override
  String get assetsTitle => 'Assets';

  @override
  String get assetAdd => 'New asset';

  @override
  String get assetsValue => 'Asset value';

  @override
  String get assetsProfit => 'Profit and loss';

  @override
  String get assetsRealized => 'Realized profit';

  @override
  String get assetFormTitle => 'New asset';

  @override
  String get assetCustom => 'Custom';

  @override
  String get assetNameLabel => 'Asset name';

  @override
  String get assetQuantityLabel => 'Quantity';

  @override
  String get assetBuyPriceLabel => 'Buy price per unit (Toman)';

  @override
  String get assetManualPriceLabel => 'Today\'s price per unit (Toman)';

  @override
  String get assetBuyMore => 'New purchase';

  @override
  String get assetSell => 'Sell';

  @override
  String get assetSellPriceLabel => 'Sell price per unit (Toman)';

  @override
  String get assetDelete => 'Delete asset';

  @override
  String get assetUnknownPrice => 'The price of this asset is not known yet.';

  @override
  String get assetStale => 'Stale price';

  @override
  String get assetQuantityInvalid => 'The quantity is not valid.';

  @override
  String get assetPriceInvalid => 'The price is not valid.';

  @override
  String get assetNameInvalid => 'A name and today\'s price are required.';

  @override
  String get assetFailed => 'It did not work; check the quantity and price.';

  @override
  String get assetCost => 'Purchase cost';

  @override
  String get assetHeld => 'Current quantity';

  @override
  String get pricesOpen => 'Prices';

  @override
  String get pricesTitle => 'Prices';

  @override
  String get priceUnknown => 'Unknown';

  @override
  String get priceStaleSuffix => 'stale';

  @override
  String get priceSourcePrefix => 'Source';

  @override
  String get netWorthTitle => 'Net worth';

  @override
  String get netWorthWallets => 'Wallets';

  @override
  String get netWorthAssets => 'Assets';

  @override
  String get netWorthDebts => 'Debts';

  @override
  String get netWorthGold => 'Grams of 18k gold';

  @override
  String get netWorthStale =>
      'Some rates are stale; the number is approximate.';

  @override
  String netWorthUnconverted(String codes) {
    return 'Currencies without a rate (left out): $codes';
  }

  @override
  String netWorthUnpriced(String count) {
    return 'Assets without a price: $count';
  }

  @override
  String get basketsTitle => 'Goal baskets';

  @override
  String get basketAdd => 'New goal basket';

  @override
  String get basketFormTitle => 'Goal basket';

  @override
  String get basketNameLabel => 'Goal name (e.g. house down payment)';

  @override
  String get basketTargetLabel => 'Target amount (Toman)';

  @override
  String get basketItemsLabel => 'What counts towards this goal?';

  @override
  String get basketTargetInvalid => 'The target amount is not valid.';

  @override
  String get basketDelete => 'Delete basket';

  @override
  String basketProgress(String percent) {
    return '$percent% of the goal';
  }

  @override
  String get reportOpen => 'Monthly report';

  @override
  String get reportTitle => 'Monthly report';

  @override
  String get reportPrev => 'Previous month';

  @override
  String get reportNext => 'Next month';

  @override
  String get reportIncome => 'Income';

  @override
  String get reportExpense => 'Expenses';

  @override
  String get reportNet => 'Net';

  @override
  String get reportByCategory => 'Expenses by category';

  @override
  String get reportIncomeByCategory => 'Income by category';

  @override
  String get reportDaily => 'Daily expenses';

  @override
  String get reportEmpty => 'There are no transactions this month.';

  @override
  String reportEntries(String count) {
    return 'Transactions: $count';
  }

  @override
  String reportTop(String name) {
    return 'Biggest spending category: $name';
  }

  @override
  String get reportFailed => 'The report could not be loaded. Try again.';

  @override
  String outboxPending(String count) {
    return 'Transactions waiting to send: $count';
  }

  @override
  String get outboxRetry => 'Send again';

  @override
  String get outboxSavedOffline =>
      'You are offline; saved and will be sent when you reconnect.';

  @override
  String get outboxFailedTitle => 'These transactions were not registered';

  @override
  String get outboxFailedDismiss => 'Remove';

  @override
  String get outboxQueued => 'Waiting to send';

  @override
  String get billingOpen => 'Subscription';

  @override
  String get billingTitle => 'Subscription';

  @override
  String get billingStatusNone => 'You have no subscription yet.';

  @override
  String billingStatusTrial(String days) {
    return 'Trial; $days days left';
  }

  @override
  String billingStatusActive(String days) {
    return 'Subscription active; $days days left';
  }

  @override
  String get billingStatusExpired => 'Your subscription has ended.';

  @override
  String get billingStartTrial => 'Start the trial';

  @override
  String get billingBuy => 'Buy';

  @override
  String get billingNoPlans => 'There are no plans to buy right now.';

  @override
  String billingPlanLine(String price, String days) {
    return '$price Toman · $days days';
  }

  @override
  String get billingPayAt => 'Pay here:';

  @override
  String get billingCheckPayment => 'Check payment';

  @override
  String get billingNotConfirmed => 'The payment is not confirmed yet.';

  @override
  String get billingFailed => 'It did not work. Try again.';

  @override
  String get readOnlyBanner =>
      'Your subscription has ended; for now you can only view your data.';

  @override
  String get readOnlyRenew => 'Renew';

  @override
  String get supportOpen => 'Support';

  @override
  String get supportTitle => 'Support';

  @override
  String get supportNew => 'New ticket';

  @override
  String get supportEmpty => 'You have no tickets yet.';

  @override
  String get supportSubjectLabel => 'Subject';

  @override
  String get supportBodyLabel => 'Describe your problem or question';

  @override
  String get supportSend => 'Send';

  @override
  String get supportReplyHint => 'Write your message';

  @override
  String get supportSubjectRequired => 'Write a subject and a message.';

  @override
  String get supportFailed => 'It was not sent. Try again.';

  @override
  String get supportStatusOpen => 'Open';

  @override
  String get supportStatusPending => 'Waiting for a reply';

  @override
  String get supportStatusResolved => 'Resolved';

  @override
  String get supportStatusClosed => 'Closed';

  @override
  String get supportFromTeam => 'Support';

  @override
  String get supportFromYou => 'You';

  @override
  String get supportUnread => 'New message';

  @override
  String get lockTitle => 'Summa is locked';

  @override
  String get lockPasscodeLabel => 'App passcode';

  @override
  String get lockUnlock => 'Unlock';

  @override
  String get lockBiometric => 'Unlock with biometrics';

  @override
  String get lockWrong => 'The passcode is wrong.';

  @override
  String get lockWait => 'Too many attempts; wait a moment and try again.';

  @override
  String get privacyOpen => 'Privacy and security';

  @override
  String get privacyTitle => 'Privacy and security';

  @override
  String get lockEnable => 'Turn on app lock';

  @override
  String get lockDisable => 'Turn off the lock';

  @override
  String get lockChange => 'Change passcode';

  @override
  String get lockNewPasscode => 'New passcode (4 to 8 digits)';

  @override
  String get lockConfirmPasscode => 'Repeat the passcode';

  @override
  String get lockMismatch => 'The two passcodes do not match.';

  @override
  String get lockInvalid => 'The passcode must be 4 to 8 digits.';

  @override
  String get lockCurrentPasscode => 'Current passcode';

  @override
  String get lockBiometricToggle => 'Biometrics';

  @override
  String get lockOn => 'On';

  @override
  String get lockOff => 'Off';

  @override
  String get lockDelayLabel => 'Auto-lock after';

  @override
  String get lockDelayNow => 'Immediately';

  @override
  String lockDelaySeconds(String count) {
    return '$count seconds';
  }

  @override
  String lockDelayMinutes(String count) {
    return '$count minutes';
  }

  @override
  String get lockSave => 'Save';

  @override
  String get strongAuthReason => 'Confirm your identity to continue';

  @override
  String get strongAuthNeedPasscode =>
      'This action is sensitive. Set an app passcode first.';

  @override
  String get strongAuthPrompt => 'Enter the app passcode';

  @override
  String get strongAuthDenied => 'Not confirmed.';

  @override
  String get retentionTitle => 'Chat retention';

  @override
  String get retentionForever => 'Forever';

  @override
  String retentionDays(String count) {
    return '$count days';
  }

  @override
  String get deleteAccountOpen => 'Delete account';

  @override
  String get deleteAccountWarning =>
      'All your data will be erased permanently and cannot be recovered. Type DELETE to confirm.';

  @override
  String get deleteAccountConfirmLabel => 'Confirmation phrase';

  @override
  String get deleteAccountButton => 'Delete account permanently';

  @override
  String get deleteAccountFailed =>
      'The deletion did not go through. Type the phrase correctly or try again.';

  @override
  String get dataOpen => 'Data export and import';

  @override
  String get dataTitle => 'Data export and import';

  @override
  String get dataExport => 'Export as CSV';

  @override
  String dataExported(String where) {
    return 'Export ready: $where';
  }

  @override
  String get dataExportFailed => 'The export failed. Try again.';

  @override
  String get dataImportTitle => 'Import from CSV';

  @override
  String get dataImportHint =>
      'Paste the CSV text here (headers: date, kind, amount, wallet, …)';

  @override
  String get dataPreview => 'Preview';

  @override
  String get dataImport => 'Import transactions';

  @override
  String get dataDenied => 'Identity not confirmed; nothing was done.';

  @override
  String dataPreviewResult(String rows, String ok, String skipped) {
    return 'Rows: $rows · importable: $ok · skipped: $skipped';
  }

  @override
  String dataImported(String count) {
    return '$count transactions imported.';
  }

  @override
  String dataLineError(String line, String message) {
    return 'Line $line: $message';
  }

  @override
  String get dataImportFailed => 'The import failed. Check the file.';

  @override
  String get netWorthHistoryEmpty =>
      'The chart builds up over a few days; one point is recorded each day.';

  @override
  String netWorthRange(String days) {
    return '$days days';
  }

  @override
  String get setupTitle => 'Complete your account';

  @override
  String get setupLater => 'Later';

  @override
  String get listSeparator => ', ';

  @override
  String get unlockReason => 'Unlock Summa';

  @override
  String get languageTitle => 'Language';

  @override
  String get languageFa => 'فارسی';

  @override
  String get languageEn => 'English';

  @override
  String get languageShamsiNote => 'Dates stay in the Shamsi calendar for now.';
}
