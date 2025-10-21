mixin ApiSource {}

mixin GetAllApiSource<T> on ApiSource {
  Future<List<T>> getAll([Map? args]);
}
mixin GetApiSource<T> on ApiSource {
  Future<T?> get([Map? args]);
}
mixin GetByIdApiSource<T> on ApiSource {
  Future<T?> getById(String id, [Map? args]);
}
