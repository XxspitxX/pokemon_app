import 'dart:core';

import 'package:db_source/configuration/database_configuration.dart';
import 'package:sembast/sembast.dart';

abstract class BaseDatabase<T> {
  late StoreRef<String, Map<String, Object?>> dbStore;
  static const _invalidStateKey = 'InvalidStateError';
  static const _errorTypeKey = 'errorType';
  static const _errorDetailsKey = 'errorDetails';
  static const _errorKey = 'error';

  BaseDatabase() {
    if (T.toString() == 'dynamic') {
      throw ArgumentError(
        '$this T can not be dynamic you must specify BaseDatabase<T>',
      );
    }
    dbStore = stringMapStoreFactory.store(T.toString());
  }

  void createStoreIfNeeded(String storeName) {
    if (storeName != dbStore.name) {
      dbStore = stringMapStoreFactory.store(storeName);
    }
  }

  Future executeTransaction(Future Function() transaction) async {
    try {
      await transaction();
    } catch (error) {
      if (_isDatabaseConnectionError(error)) {
        await DatabaseConfigurator().reloadDB();
        await transaction();
        return;
      }
      rethrow;
    }
  }

  Stream<T?> executeTransactionGet(Stream<T?> Function() transaction) async* {
    try {
      yield* transaction();
    } catch (error) {
      if (_isDatabaseConnectionError(error)) {
        await DatabaseConfigurator().reloadDB();
        yield* transaction();
        return;
      }
      rethrow;
    }
  }

  Stream<List<T>> executeTransactionGetAll(
    Stream<List<T>> Function() transaction,
  ) async* {
    try {
      yield* transaction();
    } catch (error) {
      if (_isDatabaseConnectionError(error)) {
        await DatabaseConfigurator().reloadDB();
        yield* transaction();
        return;
      }
      rethrow;
    }
  }

  Future<List<T>> executeTransactionGetAllFuture(
    List<T> Function() transaction,
  ) async {
    try {
      return transaction();
    } catch (error) {
      if (_isDatabaseConnectionError(error)) {
        await DatabaseConfigurator().reloadDB();
        return transaction();
      }
      rethrow;
    }
  }

  Stream<bool> executeTransactionValidate(
    Stream<bool> Function() transaction,
  ) async* {
    try {
      yield* transaction();
    } catch (error) {
      if (_isDatabaseConnectionError(error)) {
        await DatabaseConfigurator().reloadDB();
        yield* transaction();
      }
      rethrow;
    }
  }

  bool _isDatabaseConnectionError(Object error) {
    final mapError = _parseErrorMessage(error.toString());

    return mapError[_errorTypeKey] == _invalidStateKey;
  }

  Map<String, String> _parseErrorMessage(String message) {
    var parts = message.split(': ');
    if (parts.length > 1) {
      return {
        _errorTypeKey: parts[0],
        _errorDetailsKey: parts.sublist(1).join(': '),
      };
    }
    return {_errorKey: message};
  }
}
