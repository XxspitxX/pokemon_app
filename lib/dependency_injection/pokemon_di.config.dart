// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:api_source/di/api_source_di.module.dart' as _i484;
import 'package:data/di/data_di.module.dart' as _i494;
import 'package:db_source/di/db_source_di.module.dart' as _i206;
import 'package:dio/dio.dart' as _i361;
import 'package:domain/di/domain_di.module.dart' as _i1019;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:ui/di/ui_di.module.dart' as _i557;

import 'modules/module.dart' as _i555;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final pokemonAppModule = _$PokemonAppModule();
    gh.factory<_i361.Dio>(() => pokemonAppModule.dio);
    await _i484.ApiSourcePackageModule().init(gh);
    await _i494.DataPackageModule().init(gh);
    await _i1019.DomainPackageModule().init(gh);
    await _i206.DbSourcePackageModule().init(gh);
    await _i557.UiPackageModule().init(gh);
    return this;
  }
}

class _$PokemonAppModule extends _i555.PokemonAppModule {}
