//@GeneratedMicroModule;DbSourcePackageModule;package:db_source/di/db_source_di.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:data/favorite_pokemon_repository.dart' as _i943;
import 'package:db_source/favorite_pokemon_db_source.dart' as _i234;
import 'package:injectable/injectable.dart' as _i526;

class DbSourcePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i943.FavoritePokemonDbSource>(
        () => _i234.FavoritePokemonDbSourceAdapter());
  }
}
