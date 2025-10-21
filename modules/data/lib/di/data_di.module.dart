//@GeneratedMicroModule;DataPackageModule;package:data/di/data_di.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:data/favorite_pokemon_repository.dart' as _i943;
import 'package:data/get_all_pokemon_repository.dart' as _i828;
import 'package:data/get_pokemon_ability_repository.dart' as _i895;
import 'package:data/get_pokemon_info_repository.dart' as _i25;
import 'package:data/get_pokemon_species_repository.dart' as _i557;
import 'package:data/get_pokemon_type_info_repository.dart' as _i807;
import 'package:domain/favorite_pokemon_use_case.dart' as _i393;
import 'package:domain/get_all_pokemon_use_case.dart' as _i643;
import 'package:domain/get_pokemon_ability_use_case.dart' as _i860;
import 'package:domain/get_pokemon_info_use_case.dart' as _i21;
import 'package:domain/get_pokemon_species_use_case.dart' as _i197;
import 'package:domain/get_pokemon_type_info_use_case.dart' as _i938;
import 'package:injectable/injectable.dart' as _i526;

class DataPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i393.FavoritePokemonRepository>(() =>
        _i943.FavoritePokemonRepositoryAdapter(
            gh<_i943.FavoritePokemonDbSource>()));
    gh.factory<_i197.GetPokemonSpeciesRepository>(() =>
        _i557.GetPokemonSpeciesRepositoryAdapter(
            gh<_i557.GetPokemonSpeciesApiSource>()));
    gh.factory<_i938.GetPokemonTypeInfoRepository>(() =>
        _i807.GetPokemonTypeInfoRepositoryAdapter(
            gh<_i807.GetPokemonTypeInfoApiSource>()));
    gh.factory<_i21.GetPokemonInfoRepository>(() =>
        _i25.GetPokemonInfoRepositoryAdapter(
            gh<_i25.GetPokemonInfoApiSource>()));
    gh.factory<_i860.GetPokemonAbilityRepository>(() =>
        _i895.GetPokemonAbilityRepositoryAdapter(
            gh<_i895.GetPokemonAbilityApiSource>()));
    gh.factory<_i643.GetAllPokemonRepository>(() =>
        _i828.GetAllPokemonRepositoryAdapter(
            gh<_i828.GetAllPokemonApiSource>()));
  }
}
