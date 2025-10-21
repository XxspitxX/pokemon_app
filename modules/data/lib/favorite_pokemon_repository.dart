import 'package:data/base/db_source.dart';
import 'package:data/base/delete_by_id_in_storage_repository.dart';
import 'package:data/base/save_in_storage_repository.dart';
import 'package:data/base/stream_all_repository.dart';
import 'package:domain/favorite_pokemon_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:models/pokemon/info/pokemon_info.dart';

mixin FavoritePokemonDbSource
    on
        PutDbSource<Pokemon>,
        StreamAllDbSource<Pokemon>,
        DeleteByIdDbSource<Pokemon> {}

@Injectable(as: FavoritePokemonRepository)
class FavoritePokemonRepositoryAdapter
    with
        SaveInStorageRepositoryAdapter<Pokemon>,
        StorageStreamAllRepositoryAdapter<Pokemon>,
        DeleteByIdInStorageRepositoryAdapter<Pokemon>
    implements FavoritePokemonRepository {
  @override
  final FavoritePokemonDbSource dbSource;

  FavoritePokemonRepositoryAdapter(this.dbSource);
}
