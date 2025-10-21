part of 'package:ui/widgets/empty_state/empty_state_widget.dart';

class _EmptyStateDescription extends StatelessWidget {
  static const Color _descriptionColor = Color(0xFF424242);

  final String description;

  const _EmptyStateDescription({
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: _descriptionColor,
            height: 1.5,
          ),
    );
  }
}