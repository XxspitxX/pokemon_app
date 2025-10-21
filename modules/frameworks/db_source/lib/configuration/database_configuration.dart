import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:db_source/configuration/encrypt_codec.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sembast/sembast_io.dart';

class DatabaseConfigurator {
  static const String _securityDbName = '_sec_pokemon_creator';
  static DatabaseConfigurator? _singleton;
  Database? _securityDb;

  factory DatabaseConfigurator() {
    _singleton ??= DatabaseConfigurator._();
    return _singleton!;
  }

  DatabaseConfigurator._();

  Future init() async {
    if (_securityDb == null) {
      final dbPath = await _getDbPath(_securityDbName);
      _securityDb = await _setupDataBase(dbPath, true);
    }
  }

  Future reloadDB() async {
    await _reloadSecurityDB();
  }

  Future _reloadSecurityDB() async {
    if (_securityDb != null) {
      final dbPath = await _getDbPath(_securityDbName);

      final factory = EncryptedDatabaseFactory(
        databaseFactory: databaseFactoryIo,
        password: 'DYf2eLYEdVTuvGgX',
      );
      factory.deleteDatabase(dbPath);

      _securityDb = await _setupDataBase(dbPath, true);
    }
  }

  Future<String> _getDbPath(String dbName) async {
    final String appDocDirectory = await _getAppDirectory();
    return '$appDocDirectory/$dbName.db';
  }

  Future<Database> _setupDataBase(String dbPath, bool encrypted) async {
    var dbFactory = databaseFactoryIo;

    if (encrypted) {
      final factory = EncryptedDatabaseFactory(
        databaseFactory: databaseFactoryIo,
        password: 'DYf2eLYEdVTuvGgX',
      );
      return factory.openDatabase(dbPath);
    } else {
      return dbFactory.openDatabase(dbPath);
    }
  }

  Database? get secDatabase {
    return _securityDb;
  }

  Future<String> _getAppDirectory() async {
    var path = '';

    if (!kIsWeb) {
      Directory directory;
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          directory = await path_provider.getApplicationDocumentsDirectory();
          break;
        case TargetPlatform.windows:
          directory = await path_provider.getApplicationSupportDirectory();
          break;
        default:
          directory = await path_provider.getLibraryDirectory();
          break;
      }
      path = directory.path;
    }

    return path;
  }
}
