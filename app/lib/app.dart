import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/l10n/locale_controller.dart';
import 'core/ui/theme.dart';
import 'features/auth/auth_gate.dart';
import 'features/debug/gallery_screen.dart';
import 'features/health/health_screen.dart';
import 'features/lock/lock_screen.dart';
import 'l10n/gen/app_localizations.dart';

const String galleryRoute = '/debug/gallery';
const String healthRoute = '/debug/health';

class SummaApp extends ConsumerWidget {
  const SummaApp({this.initialRoute = '/', super.key});

  final String initialRoute;

  static const Map<String, WidgetBuilder> _screens = {
    '/': _gate,
    healthRoute: _health,
    galleryRoute: _gallery,
  };

  static Widget _gate(BuildContext _) => const LockGate(child: AuthGate());
  static Widget _health(BuildContext _) => const HealthScreen();
  static Widget _gallery(BuildContext _) => const GalleryScreen();

  static Route<void> _route(String? name) => MaterialPageRoute<void>(
    settings: RouteSettings(name: name),
    builder: _screens[name] ?? _gate,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      theme: buildSummaTheme(),
      locale: ref.watch(localeProvider),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: initialRoute,
      // Open exactly the requested screen, without building its parents.
      onGenerateInitialRoutes: (name) => [_route(name)],
      onGenerateRoute: (settings) => _route(settings.name),
    );
  }
}
