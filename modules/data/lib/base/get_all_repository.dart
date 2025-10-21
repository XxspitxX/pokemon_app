import 'package:data/base/api_source.dart';
import 'package:domain/base/get_all_use_case.dart';

mixin GetAllRepositoryAdapter<T> implements GetAllRepository<T> {
  ApiSource get apiSource;

  @override
  Future<List<T>> getAll([Map? args]) {
    return (apiSource as GetAllApiSource<T>).getAll(args);
  }
}
