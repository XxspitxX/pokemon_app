import 'package:flutter/material.dart';
import 'package:ui/resources/values.dart';
// import 'package:ui/resources/theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isFullWidth;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonChild = isLoading
        ? const SizedBox(
            width: Values.sizeCircularProgressIndicator,
            height: Values.sizeCircularProgressIndicator,
            child: CircularProgressIndicator(
              strokeWidth: Values.strokeSmall,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        : Text(
            text,
            style: const TextStyle(
              fontSize: Values.fontMedium,
              fontWeight: FontWeight.w600,
              letterSpacing: Values.textSpacingSmall,
              color: Colors.white,
            ),
          );

    final button = SizedBox(
      height: Values.buttonSize,
      child: ElevatedButton(
        onPressed: onPressed,
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
