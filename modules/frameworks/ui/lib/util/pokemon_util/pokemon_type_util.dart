import 'dart:ui';

import 'package:models/pokemon/enum/poke_type.dart';
import 'package:ui/l10n/app_localizations.dart';
import 'package:ui/resources/assets.dart';
import 'package:ui/resources/theme/app_colors.dart';

class PokemonTypeIconMapper {
  static String getIconUrl(PokeType type) {
    switch (type) {
      case PokeType.fire:
        return Assets.fire;
      case PokeType.water:
        return Assets.water;
      case PokeType.grass:
        return Assets.grass;
      case PokeType.electric:
        return Assets.electric;
      case PokeType.ice:
        return Assets.ice;
      case PokeType.fighting:
        return Assets.fighting;
      case PokeType.poison:
        return Assets.poison;
      case PokeType.ground:
        return Assets.ground;
      case PokeType.flying:
        return Assets.flying;
      case PokeType.psychic:
        return Assets.psychic;
      case PokeType.bug:
        return Assets.bug;
      case PokeType.rock:
        return Assets.rock;
      case PokeType.ghost:
        return Assets.ghost;
      case PokeType.dragon:
        return Assets.dragon;
      case PokeType.dark:
        return Assets.dark;
      case PokeType.steel:
        return Assets.steel;
      case PokeType.fairy:
        return Assets.fairy;
      case PokeType.normal:
        return Assets.normal;
      default:
        return Assets.normal;
    }
  }

  static Color getColor(PokeType type) {
    switch (type) {
      case PokeType.fire:
        return AppColors.fire;
      case PokeType.water:
        return AppColors.water;
      case PokeType.grass:
        return AppColors.grass;
      case PokeType.electric:
        return AppColors.electric;
      case PokeType.ice:
        return AppColors.ice;
      case PokeType.fighting:
        return AppColors.fighting;
      case PokeType.poison:
        return AppColors.poison;
      case PokeType.ground:
        return AppColors.ground;
      case PokeType.flying:
        return AppColors.flying;
      case PokeType.psychic:
        return AppColors.psychic;
      case PokeType.bug:
        return AppColors.bug;
      case PokeType.rock:
        return AppColors.rock;
      case PokeType.ghost:
        return AppColors.ghost;
      case PokeType.dragon:
        return AppColors.dragon;
      case PokeType.dark:
        return AppColors.dark;
      case PokeType.steel:
        return AppColors.steel;
      case PokeType.fairy:
        return AppColors.fairy;
      case PokeType.normal:
        return AppColors.normal;
      default:
        return AppColors.unknown;
    }
  }

  static Map<String, PokeType> parseLocalizedTypes(
    AppLocalizations loc,
  ) {
    return <String, PokeType>{
      loc.water: PokeType.water,
      loc.dragon: PokeType.dragon,
      loc.electric: PokeType.electric,
      loc.fairy: PokeType.fairy,
      loc.ghost: PokeType.ghost,
      loc.fire: PokeType.fire,
      loc.ice: PokeType.ice,
      loc.grass: PokeType.grass,
      loc.bug: PokeType.bug,
      loc.fighting: PokeType.fighting,
      loc.normal: PokeType.normal,
      loc.dark: PokeType.dark,
      loc.steel: PokeType.steel,
      loc.rock: PokeType.rock,
      loc.psychic: PokeType.psychic,
      loc.ground: PokeType.ground,
      loc.poison: PokeType.poison,
      loc.flying: PokeType.flying,
    };
  }

  static String getLabelType(AppLocalizations loc, PokeType type) {
    return parseLocalizedTypes(loc)
        .entries
        .firstWhere((x) => x.value == type)
        .key;
  }
}
