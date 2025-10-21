part of 'package:ui/pages/pokemon/pokemon_detail_page.dart';

class _PokemonWeaknesses extends ConsumerStatefulWidget {
  final List<TypeInfo> types;

  const _PokemonWeaknesses({
    required this.types,
  });

  @override
  ConsumerState<_PokemonWeaknesses> createState() => __PokemonWeaknessesState();
}

class __PokemonWeaknessesState extends ConsumerState<_PokemonWeaknesses> {
  @override
  Widget build(BuildContext context) {
    final loc = ref.read(appLocalizationsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.weaknesses,
          style: TextStyle(
            fontSize: Values.textTitle,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: Values.paddingMedium),
        PokemonTypeChip(
          types: widget.types,
          iconSize: Values.imageSizeSmall,
          size: Values.imageSizeChip,
        )
      ],
    );
  }
}
