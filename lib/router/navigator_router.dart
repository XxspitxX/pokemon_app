import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_app/pokemon_app.dart';
import 'package:ui/pages/home/favorites_page.dart';
import 'package:ui/pages/home/home_page.dart';
import 'package:ui/pages/home/main_page.dart';
import 'package:ui/pages/home/profile_page.dart';
import 'package:ui/pages/home/region_page.dart';
import 'package:ui/pages/onboarding/onboarding_page.dart';
import 'package:ui/pages/splash/splash_page.dart';
import 'package:ui/pages/pokemon/pokemon_detail_page.dart';
import 'package:ui/resources/values.dart';
import 'package:ui/routes/routes.dart';
import 'package:ui/util/application.dart';

mixin NavigatorRouter on State<PokemonApp> {
  Object? arguments;

  GoRouter get router {
    if (Application().globalRouter != null) {
      return Application().globalRouter!;
    }
    Application().globalRouter = GoRouter(
      initialLocation: PokemonRoutes.splash,
      routes: _buildRoutes(),
      navigatorKey: Application().appNavigatorKey,
      errorBuilder: (context, state) => Text(state.error?.message ?? ''),
    );
    return Application().globalRouter!;
  }

  List<RouteBase> _buildRoutes() {
    return [
      GoRoute(
        path: SplashPage.route,
        name: SplashPage.route,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/${OnboardingPage.route}',
        name: OnboardingPage.route,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          const OnboardingPage(),
          OnboardingPage.route,
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${HomePage.route}',
                name: HomePage.route,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${RegionPage.route}',
                name: RegionPage.route,
                builder: (context, state) => const RegionPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${FavoritesPage.route}',
                name: FavoritesPage.route,
                builder: (context, state) => const FavoritesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${ProfilePage.route}',
                name: ProfilePage.route,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/${PokemonDetailPage.route}',
        name: PokemonDetailPage.route,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          PokemonDetailPage.buildPage(context, state.extra),
          PokemonDetailPage.route,
        ),
      ),
    ];
  }

  Page _buildPageWithTransition(
    BuildContext context,
    GoRouterState state,
    Widget child,
    String routeName,
  ) {
    if (_shouldUseCustomTransition(routeName)) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: child,
        transitionDuration: Values.animationMedium,
        reverseTransitionDuration: Values.animationShort,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return _buildCustomTransition(
            animation,
            secondaryAnimation,
            child,
          );
        },
      );
    }

    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }

  bool _shouldUseCustomTransition(String routeName) {
    const customTransitionRoutes = [OnboardingPage.route];
    return customTransitionRoutes.contains(routeName);
  }

  Widget _buildCustomTransition(
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOutCubic;

    var slideTween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var slideAnimation = animation.drive(slideTween);

    var fadeTween = Tween<double>(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.easeIn));
    var fadeAnimation = animation.drive(fadeTween);

    var scaleTween = Tween<double>(begin: 0.92, end: 1.0)
        .chain(CurveTween(curve: Curves.easeOutCubic));
    var scaleAnimation = animation.drive(scaleTween);

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: child,
        ),
      ),
    );
  }
}
