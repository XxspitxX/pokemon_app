part of 'package:ui/pages/onboarding/onboarding_page.dart';

class _OnboardingCardWidget extends StatelessWidget {
  final OnboardingData page;

  const _OnboardingCardWidget({
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: context.mediaQuerySize.height * 0.25,
          ),
          child: Image.asset(
            page.characterImagePath,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: Values.paddingExtraLong),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Values.paddingExtraLong,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                page.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: Values.textTitle,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const SizedBox(height: Values.paddingMedium),
              Text(
                page.description,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: Values.textBodySmall),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
