import 'package:flutter/material.dart';
import 'package:ui/resources/values.dart';
import 'package:ui/widgets/primary_buttom.dart';

part 'package:ui/widgets/empty_state/empty_state_image.dart';
part 'package:ui/widgets/empty_state/empty_state_title.dart';
part 'package:ui/widgets/empty_state/empty_state_description.dart';

class EmptyStateWidget extends StatelessWidget {
  final String imagePath;
  final String? title;
  final String description;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const EmptyStateWidget({
    super.key,
    required this.imagePath,
    this.title,
    required this.description,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Values.paddingLong),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _EmptyStateImage(imagePath: imagePath),
            const SizedBox(height: Values.spacingBetweenImageAndTitle),
            if (title != null) _EmptyStateTitle(title: title!),
            const SizedBox(height: Values.spacingBetweenTitleAndDescription),
            _EmptyStateDescription(description: description),
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: Values.spacingBetweenDescriptionAndButton),
              PrimaryButton(
                text: buttonText!,
                onPressed: onButtonPressed!,
                isFullWidth: true,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
