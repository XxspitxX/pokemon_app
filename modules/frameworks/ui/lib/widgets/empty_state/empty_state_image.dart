part of 'package:ui/widgets/empty_state/empty_state_widget.dart';

class _EmptyStateImage extends StatelessWidget {
  static const double _imageSize = 200;

  final String imagePath;

  const _EmptyStateImage({
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: _imageSize,
      height: _imageSize,
      fit: BoxFit.contain,
    );
  }
}