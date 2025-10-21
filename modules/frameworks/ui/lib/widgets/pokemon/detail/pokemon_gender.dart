part of 'package:ui/pages/pokemon/pokemon_detail_page.dart';

class _PokemonGenderBar extends ConsumerStatefulWidget {
  const _PokemonGenderBar({
    required this.genderRate,
  });

  final int genderRate;

  @override
  ConsumerState<_PokemonGenderBar> createState() => _PokemonGenderBarState();
}

class _PokemonGenderBarState extends ConsumerState<_PokemonGenderBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loc = ref.read(appLocalizationsProvider);
    final located = ref.read(localeProvider);

    final isGenderless = widget.genderRate == -1;
    final female = isGenderless ? 0.0 : (widget.genderRate / 8.0);
    final male = isGenderless ? 0.0 : (1.0 - female);

    final nf = NumberFormat.decimalPercentPattern(
      locale: located.languageCode,
      decimalDigits: 1,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          loc.gender,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.black54,
                fontSize: Values.fontMedium,
              ),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 8,
            child: Row(
              children: [
                Expanded(
                  flex: (male * 1000).round(), // proporción ♂
                  child: Container(color: AppColors.dragon),
                ),
                Expanded(
                  flex: (female * 1000).round(), // proporción ♀
                  child: Container(color: AppColors.fairy),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _GenderLegend(
              icon: Icons.male,
              color: AppColors.dragon,
              text: _pct(male, nf),
            ),
            _GenderLegend(
              icon: Icons.female,
              color: AppColors.fairy,
              text: _pct(female, nf),
            ),
          ],
        ),
      ],
    );
  }

  String _pct(double v, NumberFormat nf) => nf.format(v);
}

class _GenderLegend extends StatelessWidget {
  const _GenderLegend({
    required this.icon,
    required this.color,
    required this.text,
  });

  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: Values.iconSizeMedium, color: color),
        const SizedBox(width: Values.paddingSmall),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.black87),
        ),
      ],
    );
  }
}
