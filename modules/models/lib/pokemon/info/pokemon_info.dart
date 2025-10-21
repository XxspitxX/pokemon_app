import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/db/database_object.dart';
import 'package:models/pokemon/info/pokemon_abalities.dart';
import 'package:models/pokemon/info/pokemon_sprites.dart';
import 'package:models/pokemon/info/pokemon_type.dart';

part 'pokemon_info.freezed.dart';
part 'pokemon_info.g.dart';

@freezed
abstract class Pokemon with _$Pokemon, DatabaseObject {
  @JsonSerializable(explicitToJson: true)
  factory Pokemon({
    required int id,
    required String name,
    String? dbId,
    @JsonKey(name: 'base_experience') int? baseExperience,
    double? height,
    double? weight,
    @JsonKey(name: 'is_default') bool? isDefault,
    int? order,
    @JsonKey(name: 'location_area_encounters') String? locationAreaEncounters,
    Sprites? sprites,
    List<PokemonType>? types,
    TypeInfo? species,
    List<Abilities>? abilities,

    @Default(false) bool favorite,
  }) = _Pokemon;

  Pokemon._();

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);

  @override
  void setDbId(String id) {}

  Pokemon withDbId(String id) => copyWith(dbId: id);
}

@freezed
abstract class PokemonDetailsPageState with _$PokemonDetailsPageState {
  const factory PokemonDetailsPageState({
    @Default([]) List<Pokemon> items,
    @Default(0) int nextIndex,
    @Default(false) bool isLoading,
    @Default(true) bool hasMore,
    @Default(true) bool isInitializing,
  }) = _PokemonDetailsPageState;
}
