// lib/providers/localization_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui/l10n/app_localizations.dart';
import '../locale/locale_provider.dart';

part 'app_localizations_provider.g.dart';

@riverpod
AppLocalizations appLocalizations(Ref ref) {
  final locale = ref.watch(localeProvider);
  return lookupAppLocalizations(locale);
}
