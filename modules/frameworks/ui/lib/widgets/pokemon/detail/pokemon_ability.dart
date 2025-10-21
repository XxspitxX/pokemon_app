part of 'package:ui/pages/pokemon/pokemon_detail_page.dart';

class _PokemonCategoryAndAbility extends ConsumerStatefulWidget {
  final List<Genus> genera;
  final AbilityInfo abilityInfo;
  const _PokemonCategoryAndAbility({
    required this.genera,
    required this.abilityInfo,
  });

  @override
  ConsumerState<_PokemonCategoryAndAbility> createState() =>
      __PokemonCategoryAndAbilityState();
}

class __PokemonCategoryAndAbilityState
    extends ConsumerState<_PokemonCategoryAndAbility> {
  @override
  Widget build(BuildContext context) {
    final loc = ref.read(appLocalizationsProvider);
    final locate = ref.read(localeProvider);

    final category = widget.genera.isNotEmpty
        ? widget.genera
            .firstWhere((x) => x.language.name == locate.languageCode)
            .genus
            .replaceAll(RegExp(UIConstants.pokemon), "")
        : loc.category;

    final ability = widget.abilityInfo.names.isNotEmpty
        ? widget.abilityInfo.names
            .firstWhere((x) => x.language.name == locate.languageCode)
            .name
        : loc.ability;
    return Row(
      children: [
        Expanded(
          child: PokemonStatCard(
            label: loc.category,
            value: category,
            icon: Icons.category_outlined,
          ),
        ),
        SizedBox(width: Values.paddingMedium),
        Expanded(
          child: PokemonStatCard(
            label: loc.ability,
            value: ability,
            icon: Icons.star_outline,
          ),
        ),
      ],
    );
  }
}
