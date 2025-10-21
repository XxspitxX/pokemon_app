import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:ui/providers/appLocalizations/app_localizations_provider.dart';
import 'package:ui/resources/theme/app_colors.dart';
import 'package:ui/resources/values.dart';

class _NavItemData {
  final IconData icon;
  final String label;
  const _NavItemData(this.icon, this.label);
}

class MainPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: navigationShell,
      ),
      bottomNavigationBar: SlideInUp(
        duration: Values.animationMedium,
        from: Values.fromNav,
        child: _BottomNavBar(
          currentIndex: navigationShell.currentIndex,
          onTap: (index) => _onTap(context, index),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class _BottomNavBar extends ConsumerStatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  ConsumerState<_BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<_BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Values.borderRadius22),
          topRight: Radius.circular(Values.borderRadius22),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.09),
            blurRadius: Values.paddingSmall,
            spreadRadius: 0,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: Values.navBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              _navItems().length,
              (index) => _NavItem(
                icon: _navItems()[index].icon,
                label: _navItems()[index].label,
                index: index,
                currentIndex: widget.currentIndex,
                onTap: widget.onTap,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<_NavItemData> _navItems() {
    final loc = ref.watch(appLocalizationsProvider);
    return [
      _NavItemData(Icons.home, loc.pokedex),
      _NavItemData(Icons.public, loc.regions),
      _NavItemData(Icons.favorite, loc.favorites),
      _NavItemData(Icons.person, loc.profile),
    ];
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndex == index;
    final color = isSelected
        ? AppColors.defaultActiveColor
        : AppColors.defaultInactiveColor;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        splashColor: AppColors.defaultActiveColor.withValues(alpha: 0.1),
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: Values.iconSizeMedium,
              color: color,
            ),
            SizedBox(height: Values.spacingSmall),
            Text(
              label,
              style: TextStyle(
                fontSize: Values.fontSmall,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: color,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
