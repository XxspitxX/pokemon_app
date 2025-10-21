import 'package:api_source/base/api_source.dart';
import 'package:data/get_pokemon_species_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:models/pokemon/info/pokemon_species.dart';

@Injectable(as: GetPokemonSpeciesApiSource)
class GetPokemonSpeciesApiSourceAdapter implements GetPokemonSpeciesApiSource {
  final ApiSource _apiSource;

  GetPokemonSpeciesApiSourceAdapter(this._apiSource);

  @override
  Future<Species?> get([Map? args]) {
    final url = args?['url'];
    return _apiSource.getApi(url, (response) {
      return Species.fromJson(response);
    });
  }
}
