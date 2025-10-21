import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_app/router/navigator_router.dart';
import 'package:flutter/material.dart';
import 'package:ui/l10n/app_localizations.dart';
import 'package:ui/providers/locale/locale_provider.dart';
import 'package:ui/util/application.dart';
import 'package:ui/resources/theme/theme.dart';

final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class PokemonApp extends ConsumerStatefulWidget {
  const PokemonApp({super.key});

  @override
  ConsumerState<PokemonApp> createState() => _PokemonAppState();
}

class _PokemonAppState extends ConsumerState<PokemonApp> with NavigatorRouter {
  final List<LocalizationsDelegate<dynamic>> _localizationsDelegates = [
    ...AppLocalizations.localizationsDelegates,
  ];

  @override
  Widget build(BuildContext context) {
    Application().appNavigatorKey = appNavigatorKey;
    return ProviderScope(
      child: Consumer(
        builder: (context, ref, _) {
          final locale = ref.watch(localeProvider);
          return MaterialApp.router(
            locale: locale,
            debugShowCheckedModeBanner: false,
            restorationScopeId: "restoration_scope_id",
            localizationsDelegates: _localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            themeMode: ThemeMode.light,
            title: 'Pokemon App',
            theme: Themes.materialLightTheme,
            routeInformationParser: router.routeInformationParser,
            routeInformationProvider: router.routeInformationProvider,
            routerDelegate: router.routerDelegate,
          );
        },
      ),
    );
  }
}
