import 'package:domain/get_pokemon_species_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:models/pokemon/info/pokemon_species.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui/util/constants/ui_constants.dart';

part 'pokemon_species_provider.g.dart';

@riverpod
GetPokemonSpeciesUseCase getPokemonSpecies(Ref ref) {
  return GetIt.instance<GetPokemonSpeciesUseCase>();
}

@riverpod
class PokemonSpecies extends _$PokemonSpecies {
  @override
  FutureOr<Species?> build() async {
    return Species(
      gender: 0,
      flavorTextEntries: [],
      genera: [],
    );
  }

  Future<void> getSpecie(String url) async {
    final useCase = ref.read(getPokemonSpeciesProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final args = {
        UIConstants.url: url,
      };
      return await useCase.get(args);
    });
  }
}
