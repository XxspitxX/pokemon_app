import 'package:domain/get_all_pokemon_use_case.dart';
import 'package:domain/get_pokemon_info_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:models/pokemon/info/pokemon_info.dart';
import 'package:models/pokemon/pokemon_list_response.dart';
import 'package:models/pokemon/pokemon_result.dart';
import 'package:ui/providers/pokemon/pokemon_provider.dart';
import 'package:ui/util/constants/ui_constants.dart';

import 'mock_providers.mocks.dart';

ProviderContainer _makeContainer({
  required GetAllPokemonUseCase getAllPokemonUseCase,
  required GetPokemonInfoUseCase getPokemonInfoUseCase,
}) {
  return ProviderContainer(overrides: [
    getAllPokemonUseCaseProvider.overrideWithValue(getAllPokemonUseCase),
    getPokemonInfoUseCaseProvider.overrideWithValue(getPokemonInfoUseCase),
  ]);
}

PokemonListResponse _fakeList(int n) {
  final results = List.generate(
    n,
    (i) => PokemonResult(name: 'p${i + 1}', url: 'url_${i + 1}'),
  );
  return PokemonListResponse(results: results);
}

Pokemon _fakePokemonFromUrl(String url) {
  final numPart = int.tryParse(url.split('_').last) ?? 0;
  return Pokemon(id: numPart, name: 'poke_$numPart');
}

Future<void> waitForPagerItems(
  WidgetTester tester,
  ProviderContainer container,
  int minCount, {
  Duration step = const Duration(milliseconds: 16),
  int maxTicks = 240,
}) async {
  for (var i = 0; i < maxTicks; i++) {
    final v = container.read(pokemonDetailsPagerProvider);
    if (v.hasValue && (v.value?.items.length ?? 0) >= minCount) {
      return;
    }
    await tester.pump(step);
  }
  fail('No llegó a $minCount items a tiempo');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PokemonList', () {
    test('getList: éxito', () async {
      final mockAll = MockGetAllPokemonUseCase();
      final mockInfo = MockGetPokemonInfoUseCase();

      when(mockAll.get()).thenAnswer((_) async => _fakeList(3));

      final container = _makeContainer(
        getAllPokemonUseCase: mockAll,
        getPokemonInfoUseCase: mockInfo,
      );

      expect(container.read(pokemonListProvider), isA<AsyncLoading>());

      final initial = await container.read(pokemonListProvider.future);
      expect(initial?.results, isEmpty);

      await container.read(pokemonListProvider.notifier).getList();

      final value = container.read(pokemonListProvider);
      expect(value.hasValue, isTrue);
      expect(value.value?.results?.length, 3);
      verify(mockAll.get()).called(1);
    });

    test('PokemonList.getList() error', () async {
      final mockAll = MockGetAllPokemonUseCase();
      final mockInfo = MockGetPokemonInfoUseCase();

      when(mockAll.get()).thenThrow(Exception('falló la API'));

      final container = _makeContainer(
        getAllPokemonUseCase: mockAll,
        getPokemonInfoUseCase: mockInfo,
      );

      addTearDown(container.dispose);

      final sub = container.listen(
        pokemonListProvider,
        (_, __) {},
        fireImmediately: true,
      );
      addTearDown(sub.close);

      expect(container.read(pokemonListProvider), isA<AsyncLoading>());

      final future = container.read(pokemonListProvider.notifier).getList();

      await future;

      final value = container.read(pokemonListProvider);
      expect(value.hasError, isTrue);
      expect(value.error, isA<Exception>());
      verify(mockAll.get()).called(1);
    });
  });

  group('PokemonInfo', () {
    test('getPokemon: éxito', () async {
      final mockAll = MockGetAllPokemonUseCase();
      final mockInfo = MockGetPokemonInfoUseCase();

      when(mockInfo.get(any)).thenAnswer((inv) async {
        final args = inv.positionalArguments.first as Map;
        return _fakePokemonFromUrl(args[UIConstants.url] as String);
      });

      final container = _makeContainer(
        getAllPokemonUseCase: mockAll,
        getPokemonInfoUseCase: mockInfo,
      );
      final initial = await container.read(pokemonInfoProvider.future);
      expect(initial, isA<Pokemon>());

      // acción
      await container.read(pokemonInfoProvider.notifier).getPokemon('url_7');

      final value = container.read(pokemonInfoProvider);
      expect(value.hasValue, isTrue);
      expect(value.value?.id, 7);
      expect(value.value?.name, 'poke_7');
      verify(mockInfo.get({UIConstants.url: 'url_7'})).called(1);
    });
  });

  group('PokemonDetailsPager', () {
    testWidgets('inicializa y carga el primer lote (5 ítems)', (tester) async {
      final mockAll = MockGetAllPokemonUseCase();
      final mockInfo = MockGetPokemonInfoUseCase();

      when(mockAll.get()).thenAnswer((_) async => _fakeList(12));
      when(mockInfo.get(any)).thenAnswer((inv) async {
        final args = inv.positionalArguments.first as Map;
        return _fakePokemonFromUrl(args[UIConstants.url] as String);
      });

      final container = _makeContainer(
        getAllPokemonUseCase: mockAll,
        getPokemonInfoUseCase: mockInfo,
      );
      addTearDown(container.dispose);

      final sub = container.listen(
        pokemonDetailsPagerProvider,
        (_, __) {},
        fireImmediately: true,
      );
      addTearDown(sub.close);

      await container.read(pokemonListProvider.notifier).getList();

      final initialState =
          await container.read(pokemonDetailsPagerProvider.future);
      expect(initialState.items, isEmpty);
      expect(initialState.isInitializing, isTrue);

      await waitForPagerItems(tester, container, 5);

      final pager = container.read(pokemonDetailsPagerProvider);
      expect(pager.hasValue, isTrue);
      expect(pager.value!.items.length, 5);
      expect(pager.value!.nextIndex, 5);
      expect(pager.value!.hasMore, isTrue);

      verify(mockInfo.get(any)).called(5);
    });

    testWidgets('refresh reinicia y vuelve a pedir la lista', (tester) async {
      final mockAll = MockGetAllPokemonUseCase();
      final mockInfo = MockGetPokemonInfoUseCase();

      when(mockAll.get()).thenAnswer((_) async => _fakeList(6));
      when(mockInfo.get(any)).thenAnswer((inv) async {
        final args = inv.positionalArguments.first as Map;
        return _fakePokemonFromUrl(args[UIConstants.url] as String);
      });

      final container = _makeContainer(
        getAllPokemonUseCase: mockAll,
        getPokemonInfoUseCase: mockInfo,
      );
      addTearDown(container.dispose);

      final sub = container.listen(
        pokemonDetailsPagerProvider,
        (_, __) {},
        fireImmediately: true,
      );
      addTearDown(sub.close);

      await container.read(pokemonListProvider.notifier).getList();
      await container.read(pokemonDetailsPagerProvider.future);
      await waitForPagerItems(tester, container, 5);
      expect(
          container.read(pokemonDetailsPagerProvider).value!.items.length, 5);

      await container.read(pokemonDetailsPagerProvider.notifier).refresh();

      await waitForPagerItems(tester, container, 5);

      final s = container.read(pokemonDetailsPagerProvider).value!;
      expect(s.items.length, 5);

      verify(mockAll.get()).called(greaterThanOrEqualTo(2));
    });
  });
}
