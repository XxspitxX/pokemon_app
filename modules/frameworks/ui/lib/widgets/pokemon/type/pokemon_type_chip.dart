part of 'package:ui/pages/pokemon/pokemon_detail_page.dart';

class PokemonTypeChip extends ConsumerStatefulWidget {
  final List<TypeInfo> types;
  final double size;
  final double iconSize;
  final int maxTypes;

  const PokemonTypeChip({
    super.key,
    required this.types,
    required this.iconSize,
    required this.size,
    this.maxTypes = 0,
  });

  @override
  ConsumerState<PokemonTypeChip> createState() => _PokemonTypeChipState();
}

class _PokemonTypeChipState extends ConsumerState<PokemonTypeChip> {
  @override
  Widget build(BuildContext context) {
    final visibleTypes = widget.maxTypes > 0
        ? widget.types.take(widget.maxTypes).toList()
        : widget.types;
    final loc = ref.read(appLocalizationsProvider);

    return Wrap(
      direction: Axis.horizontal,
      spacing: Values.paddingSmall,
      runSpacing: Values.paddingShort,
      children: visibleTypes.map((type) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Values.paddingShort,
            vertical: Values.paddingSmall,
          ),
          decoration: BoxDecoration(
            color: PokemonTypeIconMapper.getColor(type.asEnum),
            borderRadius: BorderRadius.circular(Values.borderRadius22),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PokemonTypeImage(
                type: type.asEnum,
                size: widget.size,
                iconSize: widget.iconSize,
              ),
              const SizedBox(width: Values.paddingShort),
              Text(
                PokemonTypeIconMapper.getLabelType(loc, type.asEnum),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: Values.textBodySmall,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _PokemonTypeImage extends StatelessWidget {
  final PokeType type;
  final double size;
  final double iconSize;
  const _PokemonTypeImage({
    required this.type,
    required this.iconSize,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Values.paddingSmall),
            child: SvgPicture.asset(
              PokemonTypeIconMapper.getIconUrl(type),
              width: iconSize,
              height: iconSize,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
