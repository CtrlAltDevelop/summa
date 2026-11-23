import '../../l10n/gen/app_localizations.dart';
import 'wallet_models.dart';

String walletKindLabel(AppLocalizations l10n, WalletKind kind) =>
    switch (kind) {
      WalletKind.cash => l10n.kindCash,
      WalletKind.bank => l10n.kindBank,
      WalletKind.creditCard => l10n.kindCreditCard,
      WalletKind.bnpl => l10n.kindBnpl,
      WalletKind.giftCard => l10n.kindGiftCard,
      WalletKind.crypto => l10n.kindCrypto,
      WalletKind.gold => l10n.kindGold,
    };

String currencyLabel(AppLocalizations l10n, String code) => switch (code) {
  'IRT' => l10n.currencyIRT,
  'IRR' => l10n.currencyIRR,
  'USD' => l10n.currencyUSD,
  'EUR' => l10n.currencyEUR,
  'AED' => l10n.currencyAED,
  'TRY' => l10n.currencyTRY,
  'USDT' => l10n.currencyUSDT,
  _ => code,
};
