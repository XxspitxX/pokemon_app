import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/db/database_object.dart';
import 'package:models/pokemon/info/pokemon_type.dart';

part 'pokemon_damage_relations.freezed.dart';
part 'pokemon_damage_relations.g.dart';

@freezed
abstract class DamageRelations with _$DamageRelations, DatabaseObject {
  @JsonSerializable(explicitToJson: true)
  factory DamageRelations({
    String? dbId,
    @JsonKey(name: 'double_damage_from') List<TypeInfo>? doubleDamageFrom,
    @JsonKey(name: 'double_damage_to') List<TypeInfo>? doubleDamageTo,
    @JsonKey(name: 'half_damage_from') List<TypeInfo>? halfDamageFrom,
    @JsonKey(name: 'half_damage_to') List<TypeInfo>? halfDamageTo,
    @JsonKey(name: 'no_damage_from') List<TypeInfo>? noDamageFrom,
    @JsonKey(name: 'no_damage_to') List<TypeInfo>? noDamageTo,
  }) = _DamageRelations;

  DamageRelations._();

  @override
  void setDbId(String id) {}

  factory DamageRelations.fromJson(Map<String, dynamic> json) =>
      _$DamageRelationsFromJson(json);
}
