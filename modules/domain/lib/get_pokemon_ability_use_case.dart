import 'package:domain/base/simple_get_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:models/pokemon/info/pokemon_abalities.dart';

mixin GetPokemonAbilityRepository on SimpleGetRepository<AbilityInfo> {}

mixin GetPokemonAbilityUseCase on SimpleGetUseCase<AbilityInfo> {}

@Injectable(as: GetPokemonAbilityUseCase)
class GetPokemonAbilityUseCaseAdapter
    with SimpleGetUseCaseAdapter<AbilityInfo>
    implements GetPokemonAbilityUseCase {
  @override
  final GetPokemonAbilityRepository repository;

  GetPokemonAbilityUseCaseAdapter(this.repository);
}
