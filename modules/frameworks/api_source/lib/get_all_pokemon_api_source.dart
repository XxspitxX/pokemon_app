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
    final providedUrl = args != null ? args['url'] : null;

    final uri = providedUrl != null
        ? Uri.parse(providedUrl)
        : Uri.parse(ApiPaths.getAllPokemon);

    return _apiSource.getApi(uri.toString(), (response) {
      return PokemonListResponse.fromJson(response);
    });
  }
}
