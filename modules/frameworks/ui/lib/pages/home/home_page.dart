import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:models/pokemon/enum/poke_type.dart';
import 'package:models/pokemon/info/pokemon_info.dart';
import 'package:ui/providers/appLocalizations/app_localizations_provider.dart';
import 'package:ui/providers/pokemon/favorite_provider.dart';
import 'package:ui/providers/pokemon/pokemon_provider.dart';
import 'package:ui/providers/pokemon/search_pokemon_provider.dart';
import 'package:ui/resources/assets.dart';
import 'package:ui/resources/values.dart';
import 'package:ui/util/extensions/context_extensions.dart';
import 'package:ui/util/pokemon_util/pokemon_type_util.dart';
import 'package:ui/widgets/empty_state/empty_state_widget.dart';
import 'package:ui/widgets/pokemon/card/cache_pokemon_image.dart';
import 'package:ui/widgets/pokemon/card/pokemon_card.dart';
import 'package:ui/widgets/pokemon/card/pokemon_list_skeleton.dart';
import 'package:ui/widgets/pokemon/list/pokemon_filter.dart';

part 'package:ui/widgets/pokemon/list/pokemon_list.dart';
part 'package:ui/widgets/pokemon/list/pokemon_search.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  static const String route = 'home';

  @override
  ConsumerState<HomePage> createState() => _HomePageState();

  static Widget buildPage(BuildContext context, Object? args) {
    return const HomePage();
  }
}

class _HomePageState extends ConsumerState<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(pokemonListProvider.notifier).getList();
    });
}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Material(
      child: Column(
        children: [
          _PokemonSearch(
            controller: _controller,
            onSearch: () => _searchPokemon,
            onChanged: _searchPokemon,
          ),
          _PokemonList(),
        ],
      ),
    );
  }

  void _searchPokemon(String? value) {
    ref.read(searchPokemonProvider.notifier).search(value ?? _controller.text);
  }
}
