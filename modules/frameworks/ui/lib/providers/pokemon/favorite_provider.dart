import 'dart:async';

import 'package:domain/favorite_pokemon_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:models/pokemon/info/pokemon_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_provider.g.dart';

@riverpod
FavoritePokemonUseCase favoritePokemonUseCase(Ref ref) {
  return GetIt.instance<FavoritePokemonUseCase>();
}

@riverpod
class FavoritePokemonList extends _$FavoritePokemonList {
  @override
  FutureOr<List<Pokemon>> build() {
    final useCase = ref.read(favoritePokemonUseCaseProvider);
    return useCase.streamAll().first;
  }

  Future<void> getList() async {
    final useCase = ref.read(favoritePokemonUseCaseProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await useCase.streamAll().first;
    });
  }
}

@Riverpod(keepAlive: true)
class FavoriteIds extends _$FavoriteIds {
  @override
  Stream<Set<int>> build() {
    final useCase = ref.read(favoritePokemonUseCaseProvider);

    return useCase.streamAll().map((list) {
      return list.map((p) => p.id).toSet();
    });
  }

  Future<void> save(Pokemon pokemon) async {
    final useCase = ref.read(favoritePokemonUseCaseProvider);

    final pokemonSave = pokemon.copyWith(
      dbId: pokemon.id.toString(),
      favorite: true,
    );
    await useCase.saveInStorage(pokemonSave);
  }

  Future<void> remove(int pokemonId) async {
    final useCase = ref.read(favoritePokemonUseCaseProvider);
    
    final favoriteList = await useCase.streamAll().first;
    final pokemonToRemove = favoriteList.firstWhere(
      (p) => p.id == pokemonId,
    );
    
    if (pokemonToRemove.dbId != null) {
      await useCase.deleteInStorage(pokemonToRemove.dbId!);
    }
  }

  Future<void> togglePokemon(Pokemon p) async {
    final current = state.value ?? const <int>{};
    final isFav = current.contains(p.id);

    if (isFav) {
      await remove(p.id);
    } else {
      await save(p);
    }
    ref.invalidate(favoritePokemonListProvider);
  }
}
