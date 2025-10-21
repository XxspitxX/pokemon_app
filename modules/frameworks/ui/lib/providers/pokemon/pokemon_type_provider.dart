import 'package:get_it/get_it.dart';
import 'package:models/pokemon/info/pokemon_damage_relations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:domain/get_pokemon_type_info_use_case.dart';
import 'package:ui/util/constants/ui_constants.dart';

part 'pokemon_type_provider.g.dart';

@riverpod
GetPokemonTypeInfoUseCase getPokemonTypeInfo(Ref ref) {
  return GetIt.instance<GetPokemonTypeInfoUseCase>();
}

@riverpod
class PokemonType extends _$PokemonType {
  @override
  FutureOr<DamageRelations?> build() async {
    return DamageRelations(
        doubleDamageFrom: [],
        doubleDamageTo: [],
        halfDamageFrom: [],
        halfDamageTo: [],
        noDamageFrom: [],
        noDamageTo: []);
  }

  Future<void> getType(String url) async {
    final useCase = ref.read(getPokemonTypeInfoProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final args = {
        UIConstants.url: url,
      };
      return await useCase.get(args);
    });
  }
}
