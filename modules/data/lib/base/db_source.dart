import 'package:models/db/database_object.dart';

mixin DbSource {}

mixin StreamAllDbSource<T> on DbSource {
  Stream<List<T>> streamAll([Map? args]);
}

mixin PutDbSource<T extends DatabaseObject> on DbSource {
  Future<T> put(T item, [Map? args, bool? useDebounce]);
}

mixin DeleteByIdDbSource<T extends DatabaseObject> on DbSource {
  Future<void> deleteById(String id, [Map? args]);
}

mixin SimplePutDbSource<T extends DatabaseObject> on DbSource {
  Future<void> put(T item, [Map? args]);
}

mixin SimpleStreamDbSource<T> on DbSource {
  Stream<T?> stream([Map? args]);
}
