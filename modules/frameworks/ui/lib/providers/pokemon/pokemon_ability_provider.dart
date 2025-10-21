import 'package:domain/get_pokemon_ability_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:models/pokemon/info/pokemon_abalities.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui/util/constants/ui_constants.dart';

part 'pokemon_ability_provider.g.dart';

@riverpod
GetPokemonAbilityUseCase getPokemonAbilityUseCase(Ref ref) {
  return GetIt.instance<GetPokemonAbilityUseCase>();
}

@riverpod
class PokemonAbility extends _$PokemonAbility {
  @override
  FutureOr<AbilityInfo?> build() async {
    return AbilityInfo(names: []);
  }

  Future<void> getAbility(String url) async {
    final useCase = ref.read(getPokemonAbilityUseCaseProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final args = {
        UIConstants.url: url,
      };
      return await useCase.get(args);
    });
  }
}
