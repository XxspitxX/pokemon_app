import 'package:data/base/db_source.dart';
import 'package:db_source/base/base_database.dart';
import 'package:db_source/configuration/database_configuration.dart';
import 'package:models/db/database_object.dart';
import 'package:sembast/sembast.dart';

mixin DeleteByIdDbSourceAdapter<T extends DatabaseObject> on BaseDatabase<T>
    implements DeleteByIdDbSource<T> {
  Database get db => DatabaseConfigurator().secDatabase!;

  @override
  Future<void> deleteById(String id, [Map? args]) async {
    await executeTransaction(() async {
      await dbStore.record(id).delete(db);
    });
  }
}
