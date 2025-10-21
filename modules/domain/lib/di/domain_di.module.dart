//@GeneratedMicroModule;DomainPackageModule;package:domain/di/domain_di.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:domain/favorite_pokemon_use_case.dart' as _i393;
import 'package:domain/get_all_pokemon_use_case.dart' as _i643;
import 'package:domain/get_pokemon_ability_use_case.dart' as _i860;
import 'package:domain/get_pokemon_info_use_case.dart' as _i21;
import 'package:domain/get_pokemon_species_use_case.dart' as _i197;
import 'package:domain/get_pokemon_type_info_use_case.dart' as _i938;
import 'package:injectable/injectable.dart' as _i526;

class DomainPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i197.GetPokemonSpeciesUseCase>(() =>
        _i197.GetPokemonSpeciesUseCaseAdapter(
            gh<_i197.GetPokemonSpeciesRepository>()));
    gh.factory<_i938.GetPokemonTypeInfoUseCase>(() =>
        _i938.GetPokemonTypeInfoUseCaseAdapter(
            gh<_i938.GetPokemonTypeInfoRepository>()));
    gh.factory<_i21.GetPokemonInfoUseCase>(() =>
        _i21.GetPokemonInfoUseCaseAdapter(gh<_i21.GetPokemonInfoRepository>()));
    gh.factory<_i643.GetAllPokemonUseCase>(() =>
        _i643.GetAllPokemonUseCaseAdapter(gh<_i643.GetAllPokemonRepository>()));
    gh.factory<_i860.GetPokemonAbilityUseCase>(() =>
        _i860.GetPokemonAbilityUseCaseAdapter(
            gh<_i860.GetPokemonAbilityRepository>()));
    gh.factory<_i393.FavoritePokemonUseCase>(() =>
        _i393.FavoritePokemonUseCaseAdapter(
            gh<_i393.FavoritePokemonRepository>()));
  }
}
