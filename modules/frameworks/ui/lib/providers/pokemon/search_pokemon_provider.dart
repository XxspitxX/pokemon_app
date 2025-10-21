import 'package:models/pokemon/enum/poke_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_pokemon_provider.g.dart';

@riverpod
class SearchPokemonNotifier extends _$SearchPokemonNotifier {
  @override
  String build() => '';

  void search(String data) => state = data;
}

@riverpod
class TypeExpander extends _$TypeExpander {
  @override
  bool build() => true;
  void toggle() => state = !state;
}

@riverpod
class FilterTypePokemonNotifier extends _$FilterTypePokemonNotifier {
  @override
  Set<PokeType> build() => {};

  void toggle(PokeType t) {
    final next = {...state};
    next.contains(t) ? next.remove(t) : next.add(t);
    state = next;
  }

  void clear() => state = {};
}
