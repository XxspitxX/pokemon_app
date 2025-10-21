import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class PokemonCacheManager {
  static const key = 'pokemonCache';

  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 200,
    ),
  );
}
