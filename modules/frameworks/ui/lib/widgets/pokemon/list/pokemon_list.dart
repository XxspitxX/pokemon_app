part of 'package:ui/pages/home/home_page.dart';

class _PokemonList extends ConsumerStatefulWidget {
  const _PokemonList();

  @override
  ConsumerState<_PokemonList> createState() => __PokemonListState();
}

class __PokemonListState extends ConsumerState<_PokemonList> {
  @override
  Widget build(BuildContext context) {
    final loc = ref.watch(appLocalizationsProvider);
    final page = ref.watch(pokemonDetailsPagerProvider);

    final favIdsAsync = ref.watch(favoriteIdsProvider);

    return Expanded(
      child: page.when(
        loading: () => const PokemonListSkeleton(),
        error: (e, st) => EmptyStateWidget(
          imagePath: Assets.magikarp,
          title: loc.something_went_wrong,
          description: loc.load_error_message,
          buttonText: loc.retry,
          onButtonPressed: () async =>
              await ref.read(pokemonListProvider.notifier).getList(),
        ),
        data: (s) {
          if (s.isInitializing) {
            return const PokemonListSkeleton();
          }

          final query = ref.watch(searchPokemonProvider).trim().toLowerCase();
          final selectedTypes = ref.watch(filterTypePokemonProvider);

          return favIdsAsync.when(
            loading: () => const PokemonListSkeleton(),
            error: (_, __) => const SizedBox.shrink(),
            data: (favIds) {
              final filtered = s.items.where((p) {
                final name = p.name.toLowerCase();
                final idStr = p.id.toString();
                final pTypes = (p.types ?? const [])
                    .map((t) => PokeType.fromNameOrUnknown(t.type.name))
                    .toSet();

                final matchesQuery = query.isEmpty ||
                    name.contains(query) ||
                    idStr.contains(query);
                final matchesType =
                    selectedTypes.isEmpty || pTypes.any(selectedTypes.contains);

                return matchesQuery && matchesType;
              }).toList();

              if (filtered.isEmpty) {
                return EmptyStateWidget(
                  imagePath: Assets.jigglypuff,
                  description: loc.not_found_pokemon,
                );
              }

              final hasActiveFilters =
                  query.isNotEmpty || selectedTypes.isNotEmpty;

              return RefreshIndicator(
                onRefresh: () async {
                  await ref
                      .read(pokemonDetailsPagerProvider.notifier)
                      .refresh();
                },
                child: ListView.builder(
                  itemCount: filtered.length +
                      (!hasActiveFilters && s.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (!hasActiveFilters) {
                      ref
                          .read(pokemonDetailsPagerProvider.notifier)
                          .loadMoreIfNearEnd(index);
                    }

                    if (!hasActiveFilters && index >= filtered.length) {
                      return SizedBox(
                        height: context.mediaQuerySize.height,
                        child: const PokemonListSkeleton(),
                      );
                    }

                    final Pokemon p = filtered[index];
                    return PokemonCard(
                      key: ValueKey('pokemon_${p.id}'),
                      pokemon: p,
                      image: CachedPokemonImage(
                        key: ValueKey(p.id),
                        imageUrl: p.sprites?.other?.dreamWorld?.frontDefault ??
                            p.sprites?.other?.home?.frontDefault,
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
