import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ui/resources/values.dart';

class PokemonListSkeleton extends StatelessWidget {
  final int count;

  const PokemonListSkeleton({
    super.key,
    this.count = 10,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: count,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, __) => const _PokemonCardSkeleton(),
    );
  }
}

class _PokemonCardSkeleton extends StatelessWidget {
  const _PokemonCardSkeleton();

  @override
  Widget build(BuildContext context) {
    final Color base =
        (Colors.grey.shade400).withValues(alpha: Values.alphaColorLarge);
    final Color highlight =
        Colors.white.withValues(alpha: Values.alphaColorMedium);

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: Values.paddingSmall,
          horizontal: Values.paddingMedium,
        ),
        height: Values.cardSize,
        decoration: BoxDecoration(
          color:
              (Colors.grey.shade300).withValues(alpha: Values.alphaColorMedium),
          borderRadius: BorderRadius.circular(Values.borderRadius22),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(Values.paddingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Values.iconPokemonSize,
                      height: Values.fontSmall,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius:
                            BorderRadius.circular(Values.borderRadius22),
                      ),
                    ),
                    const SizedBox(height: Values.paddingSmall),

                    Container(
                      width: Values.cardSize,
                      height: Values.fontLarge,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius:
                            BorderRadius.circular(Values.borderRadius22),
                      ),
                    ),
                    const Spacer(),

                    // Row(
                    //   children: [
                    //     Container(
                    //       height: Values.fontSmall + 10,
                    //       width: 60,
                    //       decoration: BoxDecoration(
                    //         color: Colors.grey.shade400,
                    //         borderRadius: BorderRadius.circular(999),
                    //       ),
                    //     ),
                    //     const SizedBox(width: Values.paddingSmall),
                    //     Container(
                    //       height: Values.fontSmall + 10,
                    //       width: 60,
                    //       decoration: BoxDecoration(
                    //         color: Colors.grey.shade400,
                    //         borderRadius: BorderRadius.circular(999),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(
                        right: Values.paddingSmall,
                        top: Values.paddingSmall,
                        bottom: Values.paddingSmall,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Values.borderRadius22),
                        color: (Colors.grey.shade400)
                            .withValues(alpha: Values.alphaColorLarge),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: Values.iconPokemonTypeWidth,
                      height: Values.iconPokemonTypeHeight,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(
                          alpha: Values.alphaColorMedium,
                        ),
                        borderRadius:
                            BorderRadius.circular(Values.borderRadius22),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: Values.iconPokemonSize,
                      height: Values.iconPokemonSize,
                      decoration: BoxDecoration(
                        color: Colors.white
                            .withValues(alpha: Values.alphaColorLarge),
                        borderRadius:
                            BorderRadius.circular(Values.borderRadius22),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 16,
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
                          color: Colors.grey.shade400,
                          border: Border.all(
                            color: Colors.white,
                            width: Values.borderFavorite,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
