import 'package:data/base/api_source.dart';
import 'package:data/base/simple_get_repository.dart';
import 'package:domain/get_all_pokemon_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:models/pokemon/pokemon_list_response.dart';

mixin GetAllPokemonApiSource on GetApiSource<PokemonListResponse> {}

@Injectable(as: GetAllPokemonRepository)
class GetAllPokemonRepositoryAdapter
    with SimpleGetRepositoryAdapter<PokemonListResponse>
    implements GetAllPokemonRepository {
  @override
  final GetAllPokemonApiSource apiSource;

  GetAllPokemonRepositoryAdapter(this.apiSource);
}
