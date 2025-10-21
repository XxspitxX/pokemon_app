part of 'package:ui/pages/onboarding/onboarding_page.dart';

class _PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const _PageIndicator({
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => AnimatedContainer(
          duration: Values.animationShort,
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: Values.paddingSmall),
          height: Values.sizePaginatorIndicator,
          width: currentPage == index
              ? Values.widthPaginatorIndicatorSelected
              : Values.widthPaginatorIndicatorUnSelected,
          decoration: BoxDecoration(
            color: currentPage == index
                ? AppColors.pageIndicatorSelected
                : AppColors.pageIndicatorUnSelected,
            borderRadius: BorderRadius.circular(Values.paddingSmall),
          ),
        ),
      ),
    );
  }
}
