part of 'package:ui/pages/pokemon/pokemon_detail_page.dart';

class _PokemonInfo extends StatelessWidget {
  final Pokemon pokemon;
  const _PokemonInfo({
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          pokemon.name,
          style: TextStyle(
            fontSize: Values.textHeaderTitle,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: Values.paddingSmall),
        Text(
          'Nº${pokemon.id}',
          style: TextStyle(
            fontSize: Values.fontMedium,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        PokemonTypeChip(
          types: pokemon.types!.map((e) => e.type).toList(),
          iconSize: Values.imageSizeSmall,
          size: Values.iconSizeMedium,
        )
      ],
    );
  }
}
