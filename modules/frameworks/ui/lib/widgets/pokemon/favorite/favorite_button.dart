import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/providers/pokemon/favorite_provider.dart';
import 'package:ui/resources/theme/app_colors.dart';
import 'package:ui/resources/values.dart';

class FavoriteIconButton extends ConsumerWidget {
  final int pokemonId;
  final VoidCallback? onPressed;
  final Color baseColor;

  const FavoriteIconButton({
    super.key,
    required this.pokemonId,
    required this.onPressed,
    required this.baseColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFav = ref.watch(
      favoriteIdsProvider.select(
        (asyncIds) => asyncIds.value?.contains(pokemonId) ?? false,
      ),
    );

    return InkWell(
      onTap: onPressed,
      customBorder: const CircleBorder(),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Container(
          width: Values.iconSizeLarge,
          height: Values.iconSizeLarge,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _darken(baseColor, 0.28),
            border: Border.all(
              color: Colors.white,
              width: Values.borderFavorite,
            ),
          ),
          alignment: Alignment.center,
          child: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            size: Values.iconSizeMedium,
            color: isFav ? AppColors.colorSlide : Colors.white,
          ),
        ),
      ),
    );
  }

  Color _darken(Color c, [double amount = .25]) {
    final hsl = HSLColor.fromColor(c);
    final l = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(l).toColor();
  }
}
