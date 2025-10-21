import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_sprites.freezed.dart';
part 'pokemon_sprites.g.dart';

@freezed
abstract class Sprites with _$Sprites {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory Sprites({
    String? backDefault,
    String? backFemale,
    String? backShiny,
    String? backShinyFemale,
    String? frontDefault,
    String? frontFemale,
    String? frontShiny,
    String? frontShinyFemale,
    OtherSprites? other,

    Map<String, dynamic>? versions,
  }) = _Sprites;

  factory Sprites.fromJson(Map<String, dynamic> json) =>
      _$SpritesFromJson(json);
}

@freezed
abstract class OtherSprites with _$OtherSprites {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory OtherSprites({
    DreamWorldSprites? dreamWorld,
    HomeSprites? home,
    @JsonKey(name: 'official-artwork') OfficialArtworkSprites? officialArtwork,
    ShowdownSprites? showdown,
  }) = _OtherSprites;

  factory OtherSprites.fromJson(Map<String, dynamic> json) =>
      _$OtherSpritesFromJson(json);
}

@freezed
abstract class DreamWorldSprites with _$DreamWorldSprites {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DreamWorldSprites({String? frontDefault, String? frontFemale}) =
      _DreamWorldSprites;

  factory DreamWorldSprites.fromJson(Map<String, dynamic> json) =>
      _$DreamWorldSpritesFromJson(json);
}

@freezed
abstract class HomeSprites with _$HomeSprites {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory HomeSprites({
    String? frontDefault,
    String? frontFemale,
    String? frontShiny,
    String? frontShinyFemale,
  }) = _HomeSprites;

  factory HomeSprites.fromJson(Map<String, dynamic> json) =>
      _$HomeSpritesFromJson(json);
}

@freezed
abstract class OfficialArtworkSprites with _$OfficialArtworkSprites {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory OfficialArtworkSprites({
    String? frontDefault,
    String? frontShiny,
  }) = _OfficialArtworkSprites;

  factory OfficialArtworkSprites.fromJson(Map<String, dynamic> json) =>
      _$OfficialArtworkSpritesFromJson(json);
}

@freezed
abstract class ShowdownSprites with _$ShowdownSprites {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ShowdownSprites({
    String? backDefault,
    String? backFemale,
    String? backShiny,
    String? backShinyFemale,
    String? frontDefault,
    String? frontFemale,
    String? frontShiny,
    String? frontShinyFemale,
  }) = _ShowdownSprites;

  factory ShowdownSprites.fromJson(Map<String, dynamic> json) =>
      _$ShowdownSpritesFromJson(json);
}
