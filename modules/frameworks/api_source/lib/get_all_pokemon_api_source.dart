import 'package:api_source/base/api_source.dart';
import 'package:api_source/utils/api_paths.dart';
import 'package:data/get_all_pokemon_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:models/pokemon/pokemon_list_response.dart';

@Injectable(as: GetAllPokemonApiSource)
class GetAllPokemonApiSourceAdapter implements GetAllPokemonApiSource {
  final ApiSource _apiSource;

  GetAllPokemonApiSourceAdapter(this._apiSource);

  @override
  Future<PokemonListResponse?> get([Map? args]) {
    return _apiSource.getApi(ApiPaths.getAllPokemon, (response) {
      return PokemonListResponse.fromJson(response);
    });
  }
}
