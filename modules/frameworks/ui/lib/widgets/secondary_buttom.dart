import 'package:flutter/material.dart';
import 'package:ui/resources/theme/app_colors.dart';
import 'package:ui/resources/values.dart';
// import 'package:ui/resources/theme/app_colors.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isFullWidth;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonChild = Text(
      text,
      style: const TextStyle(
        fontSize: Values.fontMedium,
        fontWeight: FontWeight.w600,
        letterSpacing: Values.textSpacingSmall,
        color: Colors.black,
      ),
    );

    final button = SizedBox(
      height: Values.buttonSize,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor:
              WidgetStateColor.resolveWith((Set<WidgetState> states) {
            return AppColors.buttonColorSecondary;
          }),
        ),
        child: buttonChild,
      ),
    );

    return isFullWidth
        ? SizedBox(
            width: double.infinity,
            child: button,
          )
        : button;
  }
}
