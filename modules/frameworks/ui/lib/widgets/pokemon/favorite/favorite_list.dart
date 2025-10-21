part of 'package:ui/pages/home/favorites_page.dart';

class _FavoritesList extends ConsumerStatefulWidget {
  const _FavoritesList();

  @override
  ConsumerState<_FavoritesList> createState() => __FavoritesListState();
}

class __FavoritesListState extends ConsumerState<_FavoritesList> {
  final _listKey = GlobalKey<AnimatedListState>();
  final _removing = <int>{};
  final _pendingRemove = <int>{};
  List<Pokemon> _items = [];

  @override
  Widget build(BuildContext context) {
    final loc = ref.read(appLocalizationsProvider);
    final page = ref.watch(favoritePokemonListProvider);

    ref.listen<AsyncValue<List<Pokemon>>>(
      favoritePokemonListProvider,
      (prev, next) {
        next.whenOrNull(data: (list) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;

            final nextFavs = list.where((x) => x.favorite).toList();

            for (int i = _items.length - 1; i >= 0; i--) {
              final p = _items[i];
              final stillExists = nextFavs.any((n) => n.id == p.id);
              if (!stillExists && !_removing.contains(p.id)) {
                _removeAt(i);
              }
            }

            for (int i = 0; i < nextFavs.length; i++) {
              final p = nextFavs[i];
              if (_pendingRemove.contains(p.id)) continue; // 👈 clave
              final existsIndex = _items.indexWhere((it) => it.id == p.id);
              if (existsIndex == -1) {
                _insertAt(i, p);
              }
            }

            _pendingRemove
                .removeWhere((id) => !nextFavs.any((p) => p.id == id));
          });
        });
      },
    );

    return Expanded(
      child: page.when(
        loading: () => const PokemonListSkeleton(),
        error: (e, st) => EmptyStateWidget(
          imagePath: Assets.magikarp,
          title: loc.something_went_wrong,
          description: loc.load_error_message,
          buttonText: loc.retry,
          onButtonPressed: () {
            ref.read(favoritePokemonListProvider.notifier).getList();
          },
        ),
        data: (list) {
          final filter = list.where((x) => x.favorite).toList();

          if (_items.isEmpty && filter.isNotEmpty) {
            _items = List<Pokemon>.from(filter);
          }

          if (filter.isEmpty) {
            return EmptyStateWidget(
              imagePath: Assets.magikarp,
              title: loc.no_favorite_pokemon,
              description: loc.favorite_pokemon_hint,
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(favoritePokemonListProvider.notifier).getList();
            },
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _items.length,
              itemBuilder: (context, index, animation) {
                final p = _items[index];
                return _FavoriteTile(
                  key: ValueKey('tile_${p.id}'),
                  pokemon: p,
                  animation: animation,
                  onToggleFavorite: () => _removeWithToggle(p),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _insertAt(int index, Pokemon p) {
    _items.insert(index, p);
    _listKey.currentState
        ?.insertItem(index, duration: const Duration(milliseconds: 300));
  }

  void _removeAt(int index) {
    if (index < 0 || index >= _items.length) return;
    final removed = _items.removeAt(index);
    _removing.add(removed.id);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _FavoriteTile(
        pokemon: removed,
        animation: animation,
        onToggleFavorite: () {},
      ),
      duration: Values.animationShort,
    );
    Future.delayed(Values.animationShort, () {
      if (!mounted) return;
      _removing.remove(removed.id);
    });
  }

  void _removeWithToggle(Pokemon p) {
    final index = _items.indexWhere((it) => it.id == p.id);
    if (index != -1) _removeAt(index);
    _pendingRemove.add(p.id);
    _setFavorite(p);
  }

  void _setFavorite(Pokemon p) {
    ref.read(favoriteIdsProvider.notifier).togglePokemon(p);
  }
}

class _FavoriteTile extends StatelessWidget {
  const _FavoriteTile({
    super.key,
    required this.pokemon,
    required this.animation,
    required this.onToggleFavorite,
  });

  final Pokemon pokemon;
  final Animation<double> animation;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      child: Slidable(
        key: ValueKey('slidable_${pokemon.id}'),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            CustomSlidableAction(
              onPressed: (_) => onToggleFavorite(),
              backgroundColor: AppColors.colorSlide,
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: Values.sizeIconDelete,
              ),
            )
          ],
        ),
        child: PokemonCard( 
          key: ValueKey(pokemon.id),
          pokemon: pokemon,
          image: CachedPokemonImage(
            key: ValueKey(pokemon.id),
            imageUrl: pokemon.sprites?.other?.dreamWorld?.frontDefault ??
                pokemon.sprites?.other?.home?.frontDefault,
          ),
        ),
      ),
    );
  }
}
