part of 'package:ui/pages/pokemon/pokemon_detail_page.dart';

class _PokemonStatsRow extends ConsumerStatefulWidget {
  final double height;
  final double weight;

  const _PokemonStatsRow({
    required this.height,
    required this.weight,
  });

  @override
  ConsumerState<_PokemonStatsRow> createState() => __PokemonStatsRowState();
}

class __PokemonStatsRowState extends ConsumerState<_PokemonStatsRow> {
  @override
  Widget build(BuildContext context) {
    final loc = ref.read(appLocalizationsProvider);
    return Row(
      children: [
        Expanded(
          child: PokemonStatCard(
            label: loc.weight,
            value: "${widget.weight / 10} kg",
            icon: Icons.monitor_weight_outlined,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: PokemonStatCard(
            label: loc.height,
            value: "${widget.height / 10} m ",
            icon: Icons.height,
          ),
        ),
      ],
    );
  }
}

class PokemonStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const PokemonStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        Values.paddingMedium,
      ),
      child: Column(
        children: [
          Align(
            alignment: AlignmentGeometry.topLeft,
            child: Row(
              spacing: Values.paddingShort,
              children: [
                Icon(
                  icon,
                  size: Values.iconSizeSmall,
                ),
                Text(label.toUpperCase())
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(
                  Values.paddingMedium,
                )),
            padding: EdgeInsets.symmetric(
                vertical: Values.paddingMedium,
                horizontal: Values.paddingMediumLong),
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Values.fontMedium,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PokemonStatCardSkeleton extends StatelessWidget {
  const PokemonStatCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey.shade300;
    final highlightColor = Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        padding: const EdgeInsets.all(
          Values.paddingMedium,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Container(
                    width: Values.iconSizeSmall,
                    height: Values.iconSizeSmall,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(
                        Values.paddingSmall,
                      ),
                    ),
                  ),
                  const SizedBox(width: Values.paddingShort),
                  Container(
                    width: Values.loadingImageSize,
                    height: Values.paddingShort,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(
                        Values.paddingSmall,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: Values.paddingShort),
            Container(
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(
                  Values.paddingShort,
                ),
              ),
              width: Values.iconPokemonTypeWidth,
              height: Values.iconSizeLarge,
              padding: EdgeInsets.symmetric(
                  vertical: Values.paddingMediumLong,
                  horizontal: Values.paddingMediumLong),
            )
          ],
        ),
      ),
    );
  }
}
