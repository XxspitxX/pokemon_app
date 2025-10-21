import 'package:data/base/db_source.dart';
import 'package:db_source/base/base_database.dart';
import 'package:db_source/configuration/database_configuration.dart';
import 'package:models/db/database_object.dart';
import 'package:sembast/sembast.dart';

mixin PutDbSourceAdapter<T extends DatabaseObject> on BaseDatabase<T>
    implements PutDbSource<T> {
  Database get db => DatabaseConfigurator().secDatabase!;

  @override
  Future<T> put(T item, [Map? args, bool? useDebounce]) async {
    await executeTransaction(() async {
      var recordId = item.dbId;
      if (recordId == null) {
        recordId = await dbStore.generateKey(db);
        item.setDbId(recordId);
      }
      var json = item.toJson();
      await dbStore.record(recordId).put(db, json);
    });
    return item;
  }
}
