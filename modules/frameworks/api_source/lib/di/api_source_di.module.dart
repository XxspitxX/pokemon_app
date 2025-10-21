//@GeneratedMicroModule;ApiSourcePackageModule;package:api_source/di/api_source_di.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:api_source/base/api_source.dart' as _i323;
import 'package:api_source/get_all_pokemon_api_source.dart' as _i343;
import 'package:api_source/get_pokemon_ability_api_source.dart' as _i49;
import 'package:api_source/get_pokemon_info_api_source.dart' as _i280;
import 'package:api_source/get_pokemon_species_api_source.dart' as _i834;
import 'package:api_source/get_pokemon_type_info_api_source.dart' as _i53;
import 'package:data/get_all_pokemon_repository.dart' as _i828;
import 'package:data/get_pokemon_ability_repository.dart' as _i895;
import 'package:data/get_pokemon_info_repository.dart' as _i25;
import 'package:data/get_pokemon_species_repository.dart' as _i557;
import 'package:data/get_pokemon_type_info_repository.dart' as _i807;
import 'package:dio/dio.dart' as _i361;
import 'package:injectable/injectable.dart' as _i526;

class ApiSourcePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.lazySingleton<_i323.ApiSource>(() => _i323.ApiSource(gh<_i361.Dio>()));
    gh.factory<_i25.GetPokemonInfoApiSource>(
        () => _i280.GetPokemonInfoApiSourceAdapter(gh<_i323.ApiSource>()));
    gh.factory<_i557.GetPokemonSpeciesApiSource>(
        () => _i834.GetPokemonSpeciesApiSourceAdapter(gh<_i323.ApiSource>()));
    gh.factory<_i807.GetPokemonTypeInfoApiSource>(
        () => _i53.GetPokemonTypeInfoApiSourceAdapter(gh<_i323.ApiSource>()));
    gh.factory<_i895.GetPokemonAbilityApiSource>(
        () => _i49.GetPokemonAbilityApiSourceAdapter(gh<_i323.ApiSource>()));
    gh.factory<_i828.GetAllPokemonApiSource>(
        () => _i343.GetAllPokemonApiSourceAdapter(gh<_i323.ApiSource>()));
  }
}
