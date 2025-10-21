import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/db/database_object.dart';
import 'package:models/pokemon/info/pokemon_type.dart';

part 'pokemon_species.freezed.dart';
part 'pokemon_species.g.dart';

@freezed
abstract class Species with _$Species, DatabaseObject {
  @JsonSerializable(explicitToJson: true)
  factory Species({
    String? dbId,
    @JsonKey(name: "gender_rate") required int gender,
    @JsonKey(name: "flavor_text_entries")
    required List<FlavorTextEntry> flavorTextEntries,
    @JsonKey(name: "genera") required List<Genus> genera,
  }) = _Species;

  Species._();

  @override
  void setDbId(String id) {}

  factory Species.fromJson(Map<String, dynamic> json) =>
      _$SpeciesFromJson(json);
}

@freezed
abstract class FlavorTextEntry with _$FlavorTextEntry {
  const factory FlavorTextEntry({
    @JsonKey(name: 'flavor_text') required String flavorText,
    required TypeInfo language,
    required TypeInfo version,
  }) = _FlavorTextEntry;

  factory FlavorTextEntry.fromJson(Map<String, dynamic> json) =>
      _$FlavorTextEntryFromJson(json);
}

@freezed
abstract class Genus with _$Genus {
  const factory Genus({required String genus, required TypeInfo language}) =
      _Genus;

  factory Genus.fromJson(Map<String, dynamic> json) => _$GenusFromJson(json);
}
