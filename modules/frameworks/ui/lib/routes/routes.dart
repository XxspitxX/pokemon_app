import 'package:flutter/widgets.dart';
import 'package:ui/pages/home/favorites_page.dart';
import 'package:ui/pages/home/home_page.dart';
import 'package:ui/pages/home/profile_page.dart';
import 'package:ui/pages/home/region_page.dart';
import 'package:ui/pages/onboarding/onboarding_page.dart';
import 'package:ui/pages/pokemon/pokemon_detail_page.dart';
import 'package:ui/pages/splash/splash_page.dart';

typedef OnPageBuilder = Widget Function(
  BuildContext context,
  Object? arguments,
);

class PokemonRoutes {
  PokemonRoutes._();

  static const splash = SplashPage.route;

  static Map<String, OnPageBuilder> routes = {
    SplashPage.route: SplashPage.buildPage,
    OnboardingPage.route: OnboardingPage.buildPage,
    HomePage.route: HomePage.buildPage,
    RegionPage.route: RegionPage.buildPage,
    FavoritesPage.route: FavoritesPage.buildPage,
    ProfilePage.route: ProfilePage.buildPage,
    PokemonDetailPage.route: PokemonDetailPage.buildPage,
  };
}
