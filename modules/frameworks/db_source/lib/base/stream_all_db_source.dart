import 'package:data/base/db_source.dart';
import 'package:db_source/base/base_database.dart';
import 'package:db_source/configuration/database_configuration.dart';
import 'package:sembast/sembast.dart';

mixin StreamAllDbSourceAdapter<T> on BaseDatabase<T>
    implements StreamAllDbSource<T> {
  T mapper(Map<String, dynamic> value);

  Database get db => DatabaseConfigurator().secDatabase!;

  @override
  Stream<List<T>> streamAll([Map? args]) {
    return executeTransactionGetAll(() {
      return dbStore
          .query()
          .onSnapshots(db)
          .map(
            (records) => records.map((record) => mapper(record.value)).toList(),
          );
    });
  }
}
