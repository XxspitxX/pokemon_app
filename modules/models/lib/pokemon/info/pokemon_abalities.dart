import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/db/database_object.dart';
import 'package:models/pokemon/info/pokemon_type.dart';

part 'pokemon_abalities.freezed.dart';
part 'pokemon_abalities.g.dart';

@freezed
abstract class Abilities with _$Abilities, DatabaseObject {
  @JsonSerializable(explicitToJson: true)
  factory Abilities({required Ability ability, String? dbId}) = _Abilities;

  Abilities._();
  factory Abilities.fromJson(Map<String, dynamic> json) =>
      _$AbilitiesFromJson(json);

  @override
  void setDbId(String id) {}
}

@freezed
abstract class Ability with _$Ability, DatabaseObject {
  factory Ability({required String name, required String url, String? dbId}) =
      _Ability;

  Ability._();

  factory Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);

  @override
  void setDbId(String id) {}
}

@freezed
abstract class AbilityInfo with _$AbilityInfo {
  const factory AbilityInfo({required List<AbilityNames> names}) = _AbilityInfo;

  factory AbilityInfo.fromJson(Map<String, dynamic> json) =>
      _$AbilityInfoFromJson(json);
}

@freezed
abstract class AbilityNames with _$AbilityNames {
  const factory AbilityNames({
    required String name,
    required TypeInfo language,
  }) = _AbilityNames;

  factory AbilityNames.fromJson(Map<String, dynamic> json) =>
      _$AbilityNamesFromJson(json);
}
