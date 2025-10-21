part of 'package:ui/pages/pokemon/pokemon_detail_page.dart';

class _PokemonHeader extends ConsumerStatefulWidget {
  final Pokemon pokemon;

  const _PokemonHeader({
    required this.pokemon,
  });

  @override
  ConsumerState<_PokemonHeader> createState() => _PokemonHeaderState();
}

class _PokemonHeaderState extends ConsumerState<_PokemonHeader> {
  @override
  Widget build(BuildContext context) {
    ref.watch(favoriteIdsProvider);
    final type = widget.pokemon.types?.first.asEnum ?? PokeType.normal;
    final baseColor = PokemonTypeIconMapper.getColor(type);

    return SizedBox(
      height: Values.detailHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: Values.positionHeaderDecorationHorizontal,
            right: Values.positionHeaderDecorationHorizontal,
            top: Values.positionHeaderDecorationTop,
            child: Container(
              width: Values.detailDecorationHeight,
              height: Values.detailDecorationHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    baseColor,
                    baseColor.withValues(
                      alpha: Values.alphaColorMedium,
                    )
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: Values.positionHeaderDecorationHorizontal2,
            top: Values.positionHeaderDecorationTop2,
            child: Container(
              width: Values.detailDecorationHeight2,
              height: Values.detailDecorationHeight2,
              decoration: BoxDecoration(
                color: baseColor.withValues(alpha: Values.alphaColorLarge),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: Values.positionHeaderButtonHorizontal,
            top: Values.positionHeaderButtonTop,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            right: Values.positionHeaderButtonHorizontal,
            top: Values.positionHeaderButtonTop,
            child: FavoriteIconButton(
              pokemonId: widget.pokemon.id,
              onPressed: () => setFavorite(),
              baseColor: baseColor,
            ),
          ),
          Positioned.fill(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const RadialGradient(
                      center: Alignment(0.0, -0.2),
                      radius: 1.0,
                      colors: [
                        Colors.white70,
                        Colors.white10,
                      ],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcIn,
                  child: SvgPicture.asset(
                    PokemonTypeIconMapper.getIconUrl(
                      widget.pokemon.types?.first.asEnum ?? PokeType.unknown,
                    ),
                    height: Values.iconPokemonHeader,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: Values.paddingLong,
                  ),
                  child: CachedPokemonImage(
                    imageUrl:
                        widget.pokemon.sprites?.other?.showdown?.frontDefault ??
                            widget.pokemon.sprites!.frontShiny!,
                    size: Values.iconPokemonTypeHeight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void setFavorite() {
    ref.read(favoriteIdsProvider.notifier).togglePokemon(widget.pokemon);
  }
}
