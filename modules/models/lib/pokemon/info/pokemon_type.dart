import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/db/database_object.dart';
import 'package:models/pokemon/enum/poke_type.dart';

part 'pokemon_type.freezed.dart';
part 'pokemon_type.g.dart';

@freezed
abstract class PokemonType with _$PokemonType, DatabaseObject {
  @JsonSerializable(explicitToJson: true)
  const factory PokemonType({
    required int slot,
    required TypeInfo type,
    String? dbId,
  }) = _PokemonType;

  const PokemonType._();

  PokeType get asEnum => PokeType.fromNameOrUnknown(type.name);

  factory PokemonType.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypeFromJson(json);

  @override
  void setDbId(String id) {}
}

@freezed
abstract class TypeInfo with _$TypeInfo, DatabaseObject {
  factory TypeInfo({required String name, required String url, String? dbId}) =
      _TypeInfo;

  factory TypeInfo.fromJson(Map<String, dynamic> json) =>
      _$TypeInfoFromJson(json);

  TypeInfo._();

  PokeType get asEnum => PokeType.fromNameOrUnknown(name);

  @override
  void setDbId(String id) {}
}
