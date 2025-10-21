import 'package:data/base/api_source.dart';
import 'package:domain/base/simple_get_use_case.dart';

mixin SimpleGetRepositoryAdapter<T> implements SimpleGetRepository<T> {
  ApiSource get apiSource;

  @override
  Future<T?> get([Map? args]) {
    return (apiSource as GetApiSource<T>).get(args);
  }
}
