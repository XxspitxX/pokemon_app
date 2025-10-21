import 'package:api_source/base/api_source.dart';
import 'package:data/get_pokemon_type_info_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:models/pokemon/info/pokemon_damage_relations.dart';

@Injectable(as: GetPokemonTypeInfoApiSource)
class GetPokemonTypeInfoApiSourceAdapter
    implements GetPokemonTypeInfoApiSource {
  final ApiSource _apiSource;

  GetPokemonTypeInfoApiSourceAdapter(this._apiSource);

  @override
  Future<DamageRelations?> get([Map? args]) {
    final url = args?['url'];
    return _apiSource.getApi(url, (response) {
      final Map<String, dynamic> damage = response as Map<String, dynamic>;
      return DamageRelations.fromJson(damage["damage_relations"]);
    });
  }
}
