import 'package:data/base/api_source.dart';
import 'package:data/base/simple_get_repository.dart';
import 'package:domain/get_pokemon_species_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:models/pokemon/info/pokemon_species.dart';

mixin GetPokemonSpeciesApiSource on GetApiSource<Species> {}

@Injectable(as: GetPokemonSpeciesRepository)
class GetPokemonSpeciesRepositoryAdapter
    with SimpleGetRepositoryAdapter<Species>
    implements GetPokemonSpeciesRepository {
  @override
  final GetPokemonSpeciesApiSource apiSource;

  GetPokemonSpeciesRepositoryAdapter(this.apiSource);
}
