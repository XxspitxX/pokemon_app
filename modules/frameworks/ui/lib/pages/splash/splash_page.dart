import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:ui/pages/onboarding/onboarding_page.dart';
import 'package:ui/providers/appLocalizations/app_localizations_provider.dart';
import 'package:ui/resources/assets.dart';
import 'package:ui/resources/values.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  static const String route = '/';

  static Widget buildPage(BuildContext context, Object? args) {
    return const SplashPage();
  }

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with TickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startSplashSequence();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = ref.read(appLocalizationsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                Assets.splashAnimation,
                width: Values.lottieSize,
                height: Values.lottieSize,
                fit: BoxFit.contain,
                repeat: true,
                animate: true,
              ),
              const SizedBox(height: Values.paddingExtraLong),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  loc.welcome,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      vsync: this,
      duration: Values.animationSplash,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
  }

  Future<void> _startSplashSequence() async {
    await _fadeController.forward();
    await Future.delayed(Values.animationSplash);
    await _fadeController.reverse();

    if (mounted) {
      _navigateToOnboarding();
    }
  }

  void _navigateToOnboarding() {
    context.goNamed(OnboardingPage.route);
  }
}
