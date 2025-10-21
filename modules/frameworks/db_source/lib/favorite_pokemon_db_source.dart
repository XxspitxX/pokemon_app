import 'package:data/favorite_pokemon_repository.dart';
import 'package:db_source/base/base_database.dart';
import 'package:db_source/base/delete_by_id_in_storage_db_source.dart';
import 'package:db_source/base/put_db_source.dart';
import 'package:db_source/base/stream_all_db_source.dart';
import 'package:injectable/injectable.dart';
import 'package:models/pokemon/info/pokemon_info.dart';

@Injectable(as: FavoritePokemonDbSource)
class FavoritePokemonDbSourceAdapter extends BaseDatabase<Pokemon>
    with
        PutDbSourceAdapter<Pokemon>,
        StreamAllDbSourceAdapter<Pokemon>,
        DeleteByIdDbSourceAdapter<Pokemon>
    implements FavoritePokemonDbSource {
  @override
  @override
  Pokemon mapper(Map<String, dynamic> value) {
    return Pokemon.fromJson(value);
  }
}
