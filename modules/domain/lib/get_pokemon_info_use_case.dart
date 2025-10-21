import 'package:domain/base/simple_get_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:models/pokemon/info/pokemon_info.dart';

mixin GetPokemonInfoRepository on SimpleGetRepository<Pokemon> {}

mixin GetPokemonInfoUseCase on SimpleGetUseCase<Pokemon> {}

@Injectable(as: GetPokemonInfoUseCase)
class GetPokemonInfoUseCaseAdapter
    with SimpleGetUseCaseAdapter<Pokemon>
    implements GetPokemonInfoUseCase {
  @override
  final GetPokemonInfoRepository repository;

  GetPokemonInfoUseCaseAdapter(this.repository);
}
