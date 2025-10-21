import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:models/pokemon/enum/poke_type.dart';
import 'package:models/pokemon/info/pokemon_info.dart';
import 'package:ui/pages/pokemon/pokemon_detail_page.dart';
import 'package:ui/providers/pokemon/favorite_provider.dart';
import 'package:ui/resources/values.dart';
import 'package:ui/util/pokemon_util/pokemon_type_util.dart';
import 'package:ui/widgets/pokemon/favorite/favorite_button.dart';

class PokemonCard extends ConsumerStatefulWidget {
  final Widget image;
  final Pokemon pokemon;

  const PokemonCard({
    super.key,
    required this.pokemon,
    required this.image,
  });

  @override
  ConsumerState<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends ConsumerState<PokemonCard> {
  void goToDetail() {
    context.pushNamed(
      PokemonDetailPage.route,
      extra: PokemonDetailArguments(pokemon: widget.pokemon),
    );
  }

  void setFavorite() {
    ref.read(favoriteIdsProvider.notifier).togglePokemon(widget.pokemon);
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = PokemonTypeIconMapper.getColor(
      widget.pokemon.types?.first.asEnum ?? PokeType.normal,
    );

    return InkWell(
      onTap: () => goToDetail(),
      borderRadius: BorderRadius.circular(Values.borderRadius22),
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: Values.paddingSmall,
          horizontal: Values.paddingMedium,
        ),
        height: Values.cardSize,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(Values.borderRadius22),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.3),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Values.borderRadius22),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.3),
                blurRadius: 0,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Values.borderRadius22,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: Values.paddingMedium,
                          right: Values.paddingMedium,
                          top: Values.paddingShort,
                        ),
                        child: Text(
                          "Nº ${widget.pokemon.id.toString().padLeft(3, '0')}",
                          style: TextStyle(
                            fontSize: Values.fontSmall,
                            fontWeight: FontWeight.w900,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Values.paddingMedium,
                        ),
                        child: Text(
                          widget.pokemon.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: Values.fontLarge,
                              fontWeight: FontWeight.w900,
                              color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(Values.paddingMedium,
                            Values.paddingSmall, 0, Values.paddingSmall),
                        child: PokemonTypeChip(
                          types: widget.pokemon.types
                                  ?.map((e) => e.type)
                                  .toList() ??
                              [],
                          iconSize: Values.imageSizeChip,
                          size: Values.imageSizeChip,
                          maxTypes: Values.maxTypes,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: ClipRRect(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                baseColor.withValues(alpha: 0.95),
                                baseColor.withValues(alpha: 0.75),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(
                              Values.borderRadius22,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: Values.paddingSmall,
                              ),
                              child: ShaderMask(
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
                                    widget.pokemon.types?.first.asEnum ??
                                        PokeType.unknown,
                                  ),
                                  width: Values.iconPokemonTypeWidth,
                                  height: Values.iconPokemonTypeHeight,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Values.iconPokemonSize,
                              height: Values.iconPokemonSize,
                              child: widget.image,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: FavoriteIconButton(
                        pokemonId: widget.pokemon.id,
                        onPressed: () => setFavorite(),
                        baseColor: baseColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
