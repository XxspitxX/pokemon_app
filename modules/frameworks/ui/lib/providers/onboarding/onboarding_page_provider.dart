import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_page_provider.g.dart';

@riverpod
class OnboardingNotifier extends _$OnboardingNotifier {
  @override
  int build() => 0;

  void setPage(int index) => state = index;

  void nextPage(int total) => state = (state + 1).clamp(0, total - 1);

  void prevPage() => state = (state - 1).clamp(0, state);
}

@riverpod
class OnboardingLoadingNotifier extends _$OnboardingLoadingNotifier {
  @override
  bool build() => true;

  void load(bool load) => state = load;
}
