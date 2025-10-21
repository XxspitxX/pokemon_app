import 'package:domain/base/simple_get_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:models/pokemon/info/pokemon_species.dart';

mixin GetPokemonSpeciesRepository on SimpleGetRepository<Species> {}

mixin GetPokemonSpeciesUseCase on SimpleGetUseCase<Species> {}

@Injectable(as: GetPokemonSpeciesUseCase)
class GetPokemonSpeciesUseCaseAdapter
    with SimpleGetUseCaseAdapter<Species>
    implements GetPokemonSpeciesUseCase {
  @override
  final GetPokemonSpeciesRepository repository;

  GetPokemonSpeciesUseCaseAdapter(this.repository);
}
