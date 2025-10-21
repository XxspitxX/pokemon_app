import 'package:data/base/api_source.dart';
import 'package:data/base/simple_get_repository.dart';
import 'package:domain/get_pokemon_info_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:models/pokemon/info/pokemon_info.dart';

mixin GetPokemonInfoApiSource on GetApiSource<Pokemon> {}

@Injectable(as: GetPokemonInfoRepository)
class GetPokemonInfoRepositoryAdapter
    with SimpleGetRepositoryAdapter<Pokemon>
    implements GetPokemonInfoRepository {
  @override
  final GetPokemonInfoApiSource apiSource;

  GetPokemonInfoRepositoryAdapter(this.apiSource);
}
