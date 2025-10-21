import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:models/pokemon/enum/poke_type.dart';
import 'package:ui/providers/appLocalizations/app_localizations_provider.dart';
import 'package:ui/providers/pokemon/search_pokemon_provider.dart';
import 'package:ui/resources/theme/app_colors.dart';
import 'package:ui/resources/values.dart';
import 'package:ui/widgets/primary_buttom.dart';
import 'package:ui/widgets/secondary_buttom.dart';

class FilterSheet extends ConsumerWidget {
  const FilterSheet({
    super.key,
    required this.types,
    required this.selectedInitial,
  });

  final Map<String, PokeType> types;
  final List<PokeType> selectedInitial;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expanded = ref.watch(typeExpanderProvider);
    final selected = ref.watch(filterTypePokemonProvider);
    final l10n = ref.watch(appLocalizationsProvider);

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * (expanded ? 0.74 : 0.6),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(Values.paddingMediumLong, Values.paddingMediumLong, Values.paddingMediumLong, Values.paddingShort),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    ref.invalidate(typeExpanderProvider);
                    ref.invalidate(filterTypePokemonProvider);
                    ref.read(filterTypePokemonProvider.notifier).clear();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: Values.iconSizeMediumLarge,
                    height: Values.iconSizeMediumLarge,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.close,
                      size: 24,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    l10n.filter_by_preference,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Values.fontMediumLarge,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                SizedBox(width: 30),                
              ],
            ),
          ),
          InkWell(
            onTap: () => ref.read(typeExpanderProvider.notifier).toggle(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(Values.paddingMediumLong, Values.paddingMediumLong, Values.paddingMediumLong, Values.paddingMedium),
              child: Row(
                children: [
                  Text(
                    l10n.typeLabel,
                    style: TextStyle(
                      fontSize: Values.textBody,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    expanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                    color: Colors.black87,
                    size: Values.fontLarge,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: Values.paddingMediumLong),
            color: Colors.grey.shade200,
          ),
          if (expanded)
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: Values.paddingShort),
                  child: Column(
                    children: types.entries.map((t) {
                      final checked = selected.contains(t.value);
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => ref
                              .read(filterTypePokemonProvider.notifier)
                              .toggle(t.value),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Values.paddingMediumLong,
                              vertical: Values.paddingShort,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _cap(t.key),
                                    style: TextStyle(
                                      fontSize: Values.textBody,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Checkbox(
                                    value: checked,
                                    onChanged: (_) => ref
                                        .read(filterTypePokemonProvider.notifier)
                                        .toggle(t.value),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    side: BorderSide(
                                      color: checked 
                                          ? AppColors.primarySwatch 
                                          : Colors.grey.shade400,
                                      width: 1,
                                    ),
                                    activeColor: AppColors.primarySwatch,
                                    checkColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          Container(
            height: 2,
            color: Colors.grey.shade200,
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PrimaryButton(
                    text: l10n.apply,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 12),
                  SecondaryButton(
                    text: l10n.cancel,
                    onPressed: () {
                      ref.invalidate(typeExpanderProvider);
                      ref.invalidate(filterTypePokemonProvider);
                      ref.read(filterTypePokemonProvider.notifier).clear();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  static String _cap(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}