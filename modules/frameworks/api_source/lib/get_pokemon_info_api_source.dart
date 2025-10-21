import 'package:api_source/base/api_source.dart';
import 'package:api_source/utils/api_paths.dart';
import 'package:data/get_pokemon_info_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:models/pokemon/info/pokemon_info.dart';

@Injectable(as: GetPokemonInfoApiSource)
class GetPokemonInfoApiSourceAdapter implements GetPokemonInfoApiSource {
  final ApiSource _apiSource;

  GetPokemonInfoApiSourceAdapter(this._apiSource);

  @override
  Future<Pokemon?> get([Map? args]) {
    final url = args?['url'];
    return _apiSource.getApi(ApiPaths.getPokemon(url), (response) {
      return Pokemon.fromJson(response);
    });
  }
}
