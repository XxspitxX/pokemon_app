import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:models/pokemon/enum/poke_type.dart';
import 'package:models/pokemon/info/pokemon_abalities.dart';
import 'package:models/pokemon/info/pokemon_info.dart';
import 'package:models/pokemon/info/pokemon_species.dart';
import 'package:models/pokemon/info/pokemon_type.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ui/providers/appLocalizations/app_localizations_provider.dart';
import 'package:ui/providers/locale/locale_provider.dart';
import 'package:ui/providers/pokemon/favorite_provider.dart';
import 'package:ui/providers/pokemon/pokemon_ability_provider.dart';
import 'package:ui/providers/pokemon/pokemon_species_provider.dart';
import 'package:ui/providers/pokemon/pokemon_type_provider.dart';
import 'package:ui/resources/theme/app_colors.dart';
import 'package:ui/resources/values.dart';
import 'package:ui/util/constants/ui_constants.dart';
import 'package:ui/util/pokemon_util/pokemon_type_util.dart';
import 'package:ui/widgets/pokemon/card/cache_pokemon_image.dart';
import 'package:ui/widgets/pokemon/favorite/favorite_button.dart';

part 'package:ui/widgets/pokemon/type/pokemon_type_chip.dart';
part 'package:ui/widgets/pokemon/detail/pokemon_ability.dart';
part 'package:ui/widgets/pokemon/detail/pokemon_gender.dart';
part 'package:ui/widgets/pokemon/detail/pokemon_stats.dart';
part 'package:ui/widgets/pokemon/detail/pokemon_header.dart';
part 'package:ui/widgets/pokemon/detail/pokemon_info.dart';
part 'package:ui/widgets/pokemon/detail/pokemon_weaknesses.dart';

class PokemonDetailArguments {
  final Pokemon? pokemon;

  PokemonDetailArguments({
    required this.pokemon,
  });
}

class PokemonDetailPage extends ConsumerStatefulWidget {
  final PokemonDetailArguments arguments;

  const PokemonDetailPage({
    super.key,
    required this.arguments,
  });

  static const String route = 'pokemon_detail';

  static Widget buildPage(BuildContext context, Object? args) {
    final arguments = args as PokemonDetailArguments?;
    assert(arguments != null, '$PokemonDetailArguments can not be null');

    return PokemonDetailPage(
      arguments: arguments!,
    );
  }

  @override
  ConsumerState<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends ConsumerState<PokemonDetailPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final urlType = widget.arguments.pokemon?.types?.first.type.url;
      final urlAbility = widget.arguments.pokemon?.abilities?.first.ability.url;

      ref
          .read(pokemonSpeciesProvider.notifier)
          .getSpecie(widget.arguments.pokemon?.species?.url ?? '');
      ref.read(pokemonTypeProvider.notifier).getType(urlType!);
      ref.read(pokemonAbilityProvider.notifier).getAbility(urlAbility ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    final typeState = ref.watch(pokemonTypeProvider);
    final language = ref.watch(localeProvider);
    final render = ref.watch(pokemonSpeciesProvider);
    final abilityInfo = ref.watch(pokemonAbilityProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _PokemonHeader(
            pokemon: widget.arguments.pokemon!,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: Values.paddingHeader),
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Values.paddingMedium,
                    vertical: Values.paddingLong,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PokemonInfo(pokemon: widget.arguments.pokemon!),
                      const SizedBox(height: Values.paddingMedium),
                      _PokemonDescription(
                        description: (render.value?.flavorTextEntries.isNotEmpty ?? false)
                        ? render.value?.flavorTextEntries
                                .firstWhere((x) =>
                                    x.version.name == 'x' &&
                                    language.languageCode == x.language.name)
                                .flavorText
                                .replaceAll(RegExp(r'[\n\f\r]'), ' ') 
                                .replaceAll(RegExp(r'\s+'), ' ')
                                .trim() ??
                            ''
                        : ""),
                      const SizedBox(height: Values.paddingMedium),
                      _PokemonStatsRow(
                        height: widget.arguments.pokemon?.height ?? 0,
                        weight: widget.arguments.pokemon?.weight ?? 0,
                      ),
                      const SizedBox(height: Values.paddingMedium),
                      render.when(
                        data: (data) {
                          return Column(
                            children: [
                              _PokemonCategoryAndAbility(
                                genera: render.value?.genera ?? [],
                                abilityInfo:
                                    abilityInfo.value ?? AbilityInfo(names: []),
                              ),
                              const SizedBox(height: Values.paddingMedium),
                              _PokemonGenderBar(
                                genderRate: render.value?.gender ?? 0,
                              ),
                            ],
                          );
                        },
                        loading: () => Column(
                          children: [
                            Row(
                              spacing: Values.paddingMedium,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PokemonStatCardSkeleton(),
                                SizedBox(
                                  height: Values.paddingMedium,
                                ),
                                PokemonStatCardSkeleton(),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: Values.paddingMedium,
                              children: [
                                PokemonStatCardSkeleton(),
                                SizedBox(
                                  height: Values.paddingMedium,
                                ),
                                PokemonStatCardSkeleton(),
                              ],
                            ),
                          ],
                        ),
                        error: (_, error) => SizedBox(),
                      ),
                      const SizedBox(height: Values.paddingExtraLong),
                      typeState.when(
                        loading: () => const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Values.paddingMedium),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        error: (e, _) => SizedBox(),
                        data: (type) => _PokemonWeaknesses(
                          types: type?.doubleDamageFrom ?? [],
                        ),
                      ),
                      const SizedBox(height: Values.paddingMedium),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PokemonDescription extends StatelessWidget {
  final String description;

  const _PokemonDescription({
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: Values.fontMedium,
        color: Colors.grey[700],
      ),
    );
  }
}
