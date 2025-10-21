import 'package:domain/get_all_pokemon_use_case.dart';
import 'package:domain/get_pokemon_info_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:models/pokemon/info/pokemon_info.dart';
import 'package:models/pokemon/pokemon_list_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui/util/constants/ui_constants.dart';

part 'pokemon_provider.g.dart';

@riverpod
GetAllPokemonUseCase getAllPokemonUseCase(Ref ref) {
  return GetIt.instance<GetAllPokemonUseCase>();
}

@riverpod
GetPokemonInfoUseCase getPokemonInfoUseCase(Ref ref) {
  return GetIt.instance<GetPokemonInfoUseCase>();
}

@riverpod
class PokemonList extends _$PokemonList {
  bool _isLoadingPage = false;

  @override
  FutureOr<PokemonListResponse?> build() async {
    return const PokemonListResponse(
      count: 0,
      next: null,
      previous: null,
      results: [],
    );
  }

  Future<void> fetchFirstPage() async {
    if (_isLoadingPage) return;
    _isLoadingPage = true;
    try {
      state = const AsyncLoading();
      final useCase = ref.read(getAllPokemonUseCaseProvider);
      final first = await useCase.get();
      state = AsyncData(first);
    } catch (e, st) {
      state = AsyncError(e, st);
    } finally {
      _isLoadingPage = false;
    }
  }

  Future<bool> fetchNextPage() async {
    if (_isLoadingPage) return false;

    final current = state.value;
    final nextUrl = current?.next;
    if (nextUrl == null) return false;

    _isLoadingPage = true;
    try {
      final useCase = ref.read(getAllPokemonUseCaseProvider);
      final nextPage = await useCase.get({UIConstants.url: nextUrl});

      final merged = PokemonListResponse(
        count: nextPage?.results?.length ?? current?.count ?? 0,
        next: nextPage?.next ?? '',
        previous: nextPage?.previous,
        results: [
          ...?current?.results,
          ...?nextPage?.results,
        ],
      );

      state = AsyncData(merged);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    } finally {
      _isLoadingPage = false;
    }
  }

  Future<void> getList() => fetchFirstPage();
}

@riverpod
class PokemonInfo extends _$PokemonInfo {
  @override
  FutureOr<Pokemon?> build() async {
    return Pokemon(id: 0, name: '');
  }

  Future<void> getPokemon(String url) async {
    final useCase = ref.read(getPokemonInfoUseCaseProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final Map<dynamic, String> args = {UIConstants.url: url};
      return await useCase.get(args);
    });
  }
}

@riverpod
class PokemonDetailsPager extends _$PokemonDetailsPager {
  bool _started = false;

  @override
  Future<PokemonDetailsPageState> build() async {
    ref.listen<AsyncValue<PokemonListResponse?>>(
      pokemonListProvider,
      (prev, next) {
        next.when(
          data: (list) {
            if (!_started && (list?.results?.isNotEmpty ?? false)) {
              _started = true;
              Future.microtask(fetchNextBatch);
            }
          },
          error: (e, st) {
            final current = state.value;
            if (current == null || current.isInitializing) {
              state = AsyncError(e, st);
            }
          },
          loading: () {},
        );
      },
      fireImmediately: true,
    );

    try {
      final list = await ref.read(pokemonListProvider.future);

      if (list?.results?.isNotEmpty ?? false) {
        if (!_started) {
          _started = true;
          Future.microtask(fetchNextBatch);
        }
      }

      return const PokemonDetailsPageState();
    } catch (e, st) {
      Error.throwWithStackTrace(e, st);
    }
  }

  Future<void> fetchNextBatch() async {
    if (WidgetsBinding.instance.schedulerPhase != SchedulerPhase.idle) {
      WidgetsBinding.instance.addPostFrameCallback((_) => fetchNextBatch());
      return;
    }

    final current = state.value;
    if (current == null || current.isLoading || !current.hasMore) return;

    state = AsyncData(current.copyWith(isLoading: true));

    try {
      var list = await ref.read(pokemonListProvider.future);
      var results = list?.results ?? const [];

      if (current.nextIndex >= results.length) {
        final loaded =
            await ref.read(pokemonListProvider.notifier).fetchNextPage();
        if (!loaded) {
          state = AsyncData(current.copyWith(
            isLoading: false,
            hasMore: false,
            isInitializing: false,
          ));
          return;
        }

        list = await ref.read(pokemonListProvider.future);
        results = list?.results ?? const [];
      }

      final start = current.nextIndex;
      final end = (start + 5).clamp(0, results.length);

      final urls = results.sublist(start, end).map((e) => e.url).toList();
      final useCase = ref.read(getPokemonInfoUseCaseProvider);
      final details = await Future.wait(
        urls.map((u) => useCase.get({UIConstants.url: u})),
      );

      final newNextIndex = end;
      final stillHasMore =
          newNextIndex < results.length || (list?.next != null);

      state = AsyncData(current.copyWith(
        items: [...current.items, ...details.whereType<Pokemon>()],
        nextIndex: newNextIndex,
        isLoading: false,
        hasMore: stillHasMore,
        isInitializing: false,
      ));
    } catch (e, st) {
      debugPrint('Error in fetchNextBatch: $e');
      state = AsyncError(e, st);
    }
  }

  void loadMoreIfNearEnd(int visibleIndex) {
    final s = state.value;
    if (s == null) return;

    const threshold = 2;
    if (!s.isLoading &&
        s.hasMore &&
        visibleIndex >= s.items.length - threshold) {
      Future.microtask(fetchNextBatch);
    }
  }

  Future<void> refresh() async {
    try {
      _started = false;
      state = const AsyncData(PokemonDetailsPageState());
      await ref.read(pokemonListProvider.notifier).getList();
    } catch (e, st) {
      debugPrint('Error in refresh: $e');
      state = AsyncError(e, st);
    }
  }
}
