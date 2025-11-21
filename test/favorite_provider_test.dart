import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:domain/favorite_pokemon_use_case.dart';
import 'package:models/pokemon/info/pokemon_info.dart';
import 'package:ui/providers/pokemon/favorite_provider.dart';
import 'mock_providers.mocks.dart';

ProviderContainer _makeContainer({
  required FavoritePokemonUseCase favoriteUC,
}) {
  return ProviderContainer(overrides: [
    favoritePokemonUseCaseProvider.overrideWithValue(favoriteUC),
  ]);
}

Pokemon fakePokemon(int id, {String? name, String? dbId, bool? favorite}) {
  return Pokemon(
    id: id,
    name: name ?? 'p$id',
    dbId: dbId,
    favorite: favorite ?? false,
  );
}

void main() {
  group('Favorite providers', () {
    late MockFavoritePokemonUseCase mockUC;
    late StreamController<List<Pokemon>> controller;

    setUp(() {
      mockUC = MockFavoritePokemonUseCase();
      controller = StreamController<List<Pokemon>>.broadcast();
      when(mockUC.streamAll()).thenAnswer((_) => controller.stream);
    });

    tearDown(() async {
      await controller.close();
    });

    test('FavoritePokemonList.getList() éxito', () async {
      final container = _makeContainer(favoriteUC: mockUC);
      addTearDown(container.dispose);

      expect(container.read(favoritePokemonListProvider), isA<AsyncLoading>());

      final emitted = [fakePokemon(3), fakePokemon(4), fakePokemon(5)];
      controller.add(emitted);

      await container.read(favoritePokemonListProvider.notifier).getList();

      final state = container.read(favoritePokemonListProvider);
      expect(state.hasValue, isTrue);
      expect(state.value, emitted);
      verify(mockUC.streamAll()).called(greaterThanOrEqualTo(1));
    });

    test('FavoritePokemonList.getList() error', () async {
      final mockUC = MockFavoritePokemonUseCase();
      final controller = StreamController<List<Pokemon>>.broadcast();

      when(mockUC.streamAll()).thenAnswer((_) => controller.stream);

      final container = ProviderContainer(overrides: [
        favoritePokemonUseCaseProvider.overrideWithValue(mockUC),
      ]);

      addTearDown(() async {
        await controller.close();
        container.dispose();
      });

      final sub = container.listen(
        favoritePokemonListProvider,
        (_, __) {},
        fireImmediately: true,
      );
      addTearDown(sub.close);

      final future =
          container.read(favoritePokemonListProvider.notifier).getList();

      controller.addError(Exception('fallo stream'));
      await controller.close();

      await future;

      final state = container.read(favoritePokemonListProvider);
      expect(state.hasError, isTrue);
    });

    test(
        'FavoriteIds.remove() elimina por dbId del pokemon presente en el stream',
        () async {
      final mockUC = MockFavoritePokemonUseCase();

      when(mockUC.streamAll()).thenAnswer(
        (_) => Stream.value([
          fakePokemon(7, dbId: '7', favorite: true),
          fakePokemon(8, dbId: '8', favorite: true),
        ]),
      );

      when(mockUC.deleteInStorage(any)).thenAnswer((_) async => Future.value());

      final container = ProviderContainer(overrides: [
        favoritePokemonUseCaseProvider.overrideWithValue(mockUC),
      ]);
      addTearDown(container.dispose);

      await container.read(favoriteIdsProvider.notifier).remove(7);

      verify(mockUC.deleteInStorage('7')).called(1);
    });
  });
}
