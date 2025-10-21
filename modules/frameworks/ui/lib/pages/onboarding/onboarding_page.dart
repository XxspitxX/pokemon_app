import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:models/onboarding/onboarding_data.dart';
import 'package:ui/pages/home/home_page.dart';
import 'package:ui/providers/appLocalizations/app_localizations_provider.dart';
import 'package:ui/providers/onboarding/onboarding_page_provider.dart';
import 'package:ui/resources/assets.dart';
import 'package:ui/resources/theme/app_colors.dart';
import 'package:ui/resources/values.dart';
import 'package:ui/util/extensions/context_extensions.dart';
import 'package:ui/widgets/primary_buttom.dart';

part 'package:ui/widgets/onboarding/onboarding_card_widget.dart';
part 'package:ui/widgets/onboarding/page_indicator_widget.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  static const String route = 'onboarding';

  static Widget buildPage(BuildContext context, Object? args) {
    return const OnboardingPage();
  }

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();
  late List<OnboardingData> _onBoardList;

  @override
  void initState() {
    super.initState();

    _generatedOnBoardingList();

    Future.microtask(() async {
      if (!mounted) {
        return;
      }

      await Future.wait([
        precacheImage(const AssetImage(Assets.onboarding1), context),
        precacheImage(const AssetImage(Assets.onboarding2), context),
      ]);

      ref.read(onboardingLoadingProvider.notifier).load(false);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(onboardingProvider);
    final isLoading = ref.watch(onboardingLoadingProvider);

    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) =>
                    ref.read(onboardingProvider.notifier).setPage(index),
                itemCount: _onBoardList.length,
                itemBuilder: (context, index) {
                  return _OnboardingCardWidget(page: _onBoardList[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Values.paddingSmall,
              ),
              child: _PageIndicator(
                currentPage: currentPage,
                totalPages: _onBoardList.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Values.paddingMedium),
              child: SizedBox(
                width: double.infinity,
                height: Values.onBoardingButtonHeight,
                child: PrimaryButton(
                  text: _onBoardList[currentPage].buttonText,
                  onPressed: () => _onButtonPressed(currentPage),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _generatedOnBoardingList() {
    final loc = ref.read(appLocalizationsProvider);
    _onBoardList = [
      OnboardingData(
        characterImagePath: Assets.onboarding1,
        title: loc.onboarding_title_1,
        description: loc.onboarding_description_1,
        buttonText: loc.onboarding_button_1,
      ),
      OnboardingData(
        characterImagePath: Assets.onboarding2,
        title: loc.onboarding_title_2,
        description: loc.onboarding_description_2,
        buttonText: loc.onboarding_button_2,
      ),
    ];
  }

  void _onButtonPressed(int currentPage) {
    if (currentPage < _onBoardList.length - 1) {
      _pageController.nextPage(
        duration: Values.animationShort,
        curve: Curves.easeInOut,
      );
    } else {
      context.goNamed(HomePage.route);
    }
  }
}
