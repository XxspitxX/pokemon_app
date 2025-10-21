import 'package:domain/favorite_pokemon_use_case.dart';
import 'package:domain/get_all_pokemon_use_case.dart';
import 'package:domain/get_pokemon_ability_use_case.dart';
import 'package:domain/get_pokemon_info_use_case.dart';
import 'package:domain/get_pokemon_species_use_case.dart';
import 'package:domain/get_pokemon_type_info_use_case.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  FavoritePokemonUseCase,
  GetAllPokemonUseCase,
  GetPokemonInfoUseCase,
  GetPokemonSpeciesUseCase,
  GetPokemonTypeInfoUseCase,
  GetPokemonAbilityUseCase
])
void main() {}
