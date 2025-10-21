import 'package:domain/base/simple_get_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:models/pokemon/pokemon_list_response.dart';

mixin GetAllPokemonRepository on SimpleGetRepository<PokemonListResponse> {}

mixin GetAllPokemonUseCase on SimpleGetUseCase<PokemonListResponse> {}

@Injectable(as: GetAllPokemonUseCase)
class GetAllPokemonUseCaseAdapter
    with SimpleGetUseCaseAdapter<PokemonListResponse>
    implements GetAllPokemonUseCase {
  @override
  final GetAllPokemonRepository repository;

  GetAllPokemonUseCaseAdapter(this.repository);
}
