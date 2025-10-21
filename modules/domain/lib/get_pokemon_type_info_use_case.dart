import 'package:domain/base/simple_get_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:models/pokemon/info/pokemon_damage_relations.dart';

mixin GetPokemonTypeInfoRepository on SimpleGetRepository<DamageRelations> {}

mixin GetPokemonTypeInfoUseCase on SimpleGetUseCase<DamageRelations> {}

@Injectable(as: GetPokemonTypeInfoUseCase)
class GetPokemonTypeInfoUseCaseAdapter
    with SimpleGetUseCaseAdapter<DamageRelations>
    implements GetPokemonTypeInfoUseCase {
  @override
  final GetPokemonTypeInfoRepository repository;

  GetPokemonTypeInfoUseCaseAdapter(this.repository);
}
