import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/providers/appLocalizations/app_localizations_provider.dart';
import 'package:ui/resources/assets.dart';
import 'package:ui/resources/theme/app_colors.dart';
import 'package:ui/resources/values.dart';
import 'package:ui/widgets/empty_state/empty_state_widget.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  static const String route = 'profile';

  static Widget buildPage(BuildContext context, Object? args) {
    return const ProfilePage();
  }

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final loc = ref.read(appLocalizationsProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            loc.profile,
            style: TextStyle(
              color: AppColors.textBodyLight,
              fontSize: Values.fontMedium,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: EmptyStateWidget(
        imagePath: Assets.jigglypuff,
        title: loc.coming_soon,
        description: loc.section_in_progress,
      ),
    );
  }
}
