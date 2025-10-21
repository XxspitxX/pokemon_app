import 'package:domain/get_all_pokemon_use_case.dart';
import 'package:domain/get_pokemon_info_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:models/pokemon/pokemon_list_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:models/pokemon/info/pokemon_info.dart';
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
  @override
  FutureOr<PokemonListResponse?> build() async {
    return const PokemonListResponse(results: []);
  }

  Future<void> getList() async {
    final useCase = ref.read(getAllPokemonUseCaseProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await useCase.get();
    });
  }
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
  static const int _batchSize = 5;
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
      final list = await ref.read(pokemonListProvider.future);
      final results = list?.results ?? const [];

      if (current.nextIndex >= results.length) {
        state = AsyncData(current.copyWith(
          isLoading: false,
          hasMore: false,
          isInitializing: false,
        ));
        return;
      }

      final start = current.nextIndex;
      final end = (start + _batchSize).clamp(0, results.length);

      final urls = results.sublist(start, end).map((e) => e.url).toList();
      final useCase = ref.read(getPokemonInfoUseCaseProvider);

      final futures = urls.map((u) => useCase.get({UIConstants.url: u}));
      final details = (await Future.wait(futures)).whereType<Pokemon>().toList();

      state = AsyncData(
        current.copyWith(
          items: [...current.items, ...details],
          nextIndex: end,
          isLoading: false,
          hasMore: end < results.length,
          isInitializing: false,
        ),
      );
      
      debugPrint('Loaded ${details.length} pokemon. Total: ${state.value?.items.length}');
    } catch (e, st) {
      debugPrint('Error in fetchNextBatch: $e');
      state = AsyncError(e, st);
    }
  }

  void loadMoreIfNearEnd(int visibleIndex) {
    final s = state.value;
    if (s == null) return;

    const threshold = 2;
    if (!s.isLoading && s.hasMore && visibleIndex >= s.items.length - threshold) {
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
