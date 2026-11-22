import '../../l10n/gen/app_localizations.dart';
import 'auth_models.dart';

/// The user-facing sentence for an [AuthFailure].
String authFailureMessage(AppLocalizations l10n, AuthFailure failure) {
  return switch (failure) {
    AuthFailure.invalidPhone => l10n.errInvalidPhone,
    AuthFailure.wrongCode => l10n.errWrongCode,
    AuthFailure.tooMany => l10n.errTooMany,
    AuthFailure.offline => l10n.errOffline,
    AuthFailure.unauthorized || AuthFailure.unknown => l10n.errUnknown,
  };
}
