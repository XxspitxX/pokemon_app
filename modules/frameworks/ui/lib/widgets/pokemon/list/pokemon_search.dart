part of 'package:ui/pages/home/home_page.dart';

class _PokemonSearch extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final ValueChanged<String>? onChanged;

  const _PokemonSearch({
    required this.controller,
    required this.onSearch,
    this.onChanged,
  });

  @override
  ConsumerState<_PokemonSearch> createState() => __PokemonSearch();
}

class __PokemonSearch extends ConsumerState<_PokemonSearch> {
  @override
  Widget build(BuildContext context) {
    final Color borderGray = Colors.grey.shade300;
    final Color leftIconGray = Colors.grey.shade500;
    final loc = ref.read(appLocalizationsProvider);

    return Padding(
      padding: const EdgeInsets.all(
        Values.paddingMedium,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: Values.onBoardingButtonHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Values.borderRadius22),
                border: Border.all(
                  color: borderGray,
                ),
              ),
              alignment: Alignment.center,
              child: Row(
                children: [
                  const SizedBox(width: Values.paddingMedium),
                  Icon(Icons.search,
                      size: Values.iconSizeMedium, color: leftIconGray),
                  const SizedBox(width: Values.paddingSmall),
                  Expanded(
                    child: TextField(
                      controller: widget.controller,
                      onChanged: widget.onChanged,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (_) => widget.onSearch(),
                      decoration: InputDecoration(
                        hintText: loc.search_pokemon,
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: Values.paddingSmall,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: Values.paddingMedium),
                ],
              ),
            ),
          ),
          const SizedBox(width: Values.paddingMedium),
          InkWell(
            onTap: _pokemonFilter,
            customBorder: const CircleBorder(),
            child: Container(
              width: Values.onBoardingButtonHeight,
              height: Values.onBoardingButtonHeight,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: borderGray,
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.search,
                size: Values.iconSizeMedium,
                color: leftIconGray,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _pokemonFilter() {
    final loc = ref.read(appLocalizationsProvider);

    showModalBottomSheet<Set<String>>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            Values.borderRadius22,
          ),
        ),
      ),
      builder: (ctx) {
        return FilterSheet(
          types: PokemonTypeIconMapper.parseLocalizedTypes(loc),
          selectedInitial: ref.read(filterTypePokemonProvider).toList(),
        );
      },
    );
  }
}
