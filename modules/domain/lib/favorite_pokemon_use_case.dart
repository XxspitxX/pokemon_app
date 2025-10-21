import 'package:domain/base/delete_by_id_in_storage_use_case.dart';
import 'package:domain/base/save_in_storage_use_case.dart';
import 'package:domain/base/stream_all_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:models/pokemon/info/pokemon_info.dart';

mixin FavoritePokemonRepository
    on
        SaveInStorageRepository<Pokemon>,
        StreamAllRepository<Pokemon>,
        DeleteByIdInStorageRepository<Pokemon> {}

mixin FavoritePokemonUseCase
    on
        SaveInStorageUseCase<Pokemon>,
        StreamAllUseCase<Pokemon>,
        DeleteByIdInStorageUseCase<Pokemon> {}

@Injectable(as: FavoritePokemonUseCase)
class FavoritePokemonUseCaseAdapter
    with
        SaveInStorageUseCaseAdapter<Pokemon>,
        StreamAllUseCaseAdapter<Pokemon>,
        DeleteByIdInStorageUseCaseAdapter<Pokemon>
    implements FavoritePokemonUseCase {
  @override
  final FavoritePokemonRepository repository;

  FavoritePokemonUseCaseAdapter(this.repository);
}
