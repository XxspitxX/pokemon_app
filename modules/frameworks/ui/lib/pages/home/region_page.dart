import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/providers/appLocalizations/app_localizations_provider.dart';
import 'package:ui/providers/locale/locale_provider.dart';
import 'package:ui/resources/assets.dart';
import 'package:ui/resources/theme/app_colors.dart';
import 'package:ui/resources/values.dart';
import 'package:ui/widgets/empty_state/empty_state_widget.dart';

class RegionPage extends ConsumerStatefulWidget {
  const RegionPage({super.key});

  static const String route = 'region';

  static Widget buildPage(BuildContext context, Object? args) {
    return const RegionPage();
  }

  @override
  ConsumerState<RegionPage> createState() => _RegionPageState();
}

class _RegionPageState extends ConsumerState<RegionPage> {
  @override
  Widget build(BuildContext context) {
    final loc = ref.watch(appLocalizationsProvider);
    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            loc.regions,
            style: TextStyle(
              color: AppColors.textBodyLight,
              fontSize: Values.fontMedium,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _LanguageSelector(),
          Expanded(
            child: EmptyStateWidget(
              imagePath: Assets.jigglypuff,
              title: loc.coming_soon,
              description: loc.section_in_progress,
            ),
          ),          
        ],
      ),
    );
  }
}

class _LanguageSelector extends ConsumerWidget {
  const _LanguageSelector();  


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentLocale = ref.watch(localeProvider);
    final isEnglish = currentLocale.languageCode == 'en';

    return Padding(
      padding: const EdgeInsets.all(Values.paddingMedium),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Values.paddingMedium, vertical: Values.paddingShort),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(Values.borderRadius22),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'ES',
              style: TextStyle(
                color: isEnglish ? Colors.grey[600] : AppColors.defaultActiveColor,
                fontWeight: isEnglish ? FontWeight.normal : FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 8),
            Switch(
              value: isEnglish,
              onChanged: (value) {
                ref.read(localeProvider.notifier).setLocale(
                      value ? const Locale('en') : const Locale('es'),
                    );
              },
              activeThumbColor: AppColors.defaultActiveColor,
              inactiveThumbColor: Colors.grey[400],
              inactiveTrackColor: Colors.grey[300],
            ),
            const SizedBox(width: 8),
            Text(
              'EN',
              style: TextStyle(
                color: isEnglish ? AppColors.defaultActiveColor : Colors.grey[600],
                fontWeight: isEnglish ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}