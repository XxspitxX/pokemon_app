import 'package:data/base/api_source.dart';
import 'package:data/base/simple_get_repository.dart';
import 'package:domain/get_pokemon_ability_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:models/pokemon/info/pokemon_abalities.dart';

mixin GetPokemonAbilityApiSource on GetApiSource<AbilityInfo> {}

@Injectable(as: GetPokemonAbilityRepository)
class GetPokemonAbilityRepositoryAdapter
    with SimpleGetRepositoryAdapter<AbilityInfo>
    implements GetPokemonAbilityRepository {
  @override
  final GetPokemonAbilityApiSource apiSource;

  GetPokemonAbilityRepositoryAdapter(this.apiSource);
}
