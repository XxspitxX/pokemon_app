part of 'package:ui/widgets/empty_state/empty_state_widget.dart';

class _EmptyStateTitle extends StatelessWidget {
  static const Color _titleColor = Color(0xFF121212);

  final String title;

  const _EmptyStateTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: _titleColor,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
    );
  }
}