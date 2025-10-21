import 'package:api_source/base/api_source.dart';
import 'package:data/get_pokemon_ability_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:models/pokemon/info/pokemon_abalities.dart';

@Injectable(as: GetPokemonAbilityApiSource)
class GetPokemonAbilityApiSourceAdapter implements GetPokemonAbilityApiSource {
  final ApiSource _apiSource;

  GetPokemonAbilityApiSourceAdapter(this._apiSource);

  @override
  Future<AbilityInfo> get([Map? args]) {
    final url = args?['url'];
    return _apiSource.getApi(url, (response) {
      return AbilityInfo.fromJson(response);
    });
  }
}
