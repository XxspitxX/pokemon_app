import 'package:data/base/api_source.dart';
import 'package:data/base/simple_get_repository.dart';
import 'package:domain/get_pokemon_type_info_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:models/pokemon/info/pokemon_damage_relations.dart';

mixin GetPokemonTypeInfoApiSource on GetApiSource<DamageRelations> {}

@Injectable(as: GetPokemonTypeInfoRepository)
class GetPokemonTypeInfoRepositoryAdapter
    with SimpleGetRepositoryAdapter<DamageRelations>
    implements GetPokemonTypeInfoRepository {
  @override
  final GetPokemonTypeInfoApiSource apiSource;

  GetPokemonTypeInfoRepositoryAdapter(this.apiSource);
}
