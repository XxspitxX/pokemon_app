import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:models/pokemon/info/pokemon_info.dart';
import 'package:ui/providers/appLocalizations/app_localizations_provider.dart';
import 'package:ui/providers/pokemon/favorite_provider.dart';
import 'package:ui/resources/assets.dart';
import 'package:ui/resources/theme/app_colors.dart';
import 'package:ui/resources/values.dart';
import 'package:ui/widgets/empty_state/empty_state_widget.dart';
import 'package:ui/widgets/pokemon/card/cache_pokemon_image.dart';
import 'package:ui/widgets/pokemon/card/pokemon_card.dart';
import 'package:ui/widgets/pokemon/card/pokemon_list_skeleton.dart';

part 'package:ui/widgets/pokemon/favorite/favorite_list.dart';

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  static const String route = 'favorites';

  static Widget buildPage(BuildContext context, Object? args) {
    return const FavoritesPage();
  }

  @override
  ConsumerState<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final loc = ref.read(appLocalizationsProvider);

    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            loc.favorites,
            style: TextStyle(
              color: AppColors.textBodyLight,
              fontSize: Values.fontMedium,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _FavoritesList(),
        ],
      ),
    );
  }
}
