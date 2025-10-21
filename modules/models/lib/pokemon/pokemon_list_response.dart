import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/pokemon/pokemon_result.dart';

part 'pokemon_list_response.freezed.dart';
part 'pokemon_list_response.g.dart';

@freezed
abstract class PokemonListResponse with _$PokemonListResponse {
  const factory PokemonListResponse({
    int? count,
    String? next,
    String? previous,
    List<PokemonResult>? results,
  }) = _PokemonListResponse;

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) =>
      _$PokemonListResponseFromJson(json);
}
