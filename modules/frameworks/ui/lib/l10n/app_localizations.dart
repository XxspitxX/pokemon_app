import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @allAppName.
  ///
  /// In es, this message translates to:
  /// **'Pokemon App'**
  String get allAppName;

  /// No description provided for @onboarding_title_1.
  ///
  /// In es, this message translates to:
  /// **'Todos los Pokémon en un solo lugar'**
  String get onboarding_title_1;

  /// No description provided for @onboarding_description_1.
  ///
  /// In es, this message translates to:
  /// **'Accede a una amplia lista de Pokémon de todas las generaciones creadas por Nintendo'**
  String get onboarding_description_1;

  /// No description provided for @onboarding_button_1.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get onboarding_button_1;

  /// No description provided for @onboarding_title_2.
  ///
  /// In es, this message translates to:
  /// **'Mantén tu Pokédex actualizada'**
  String get onboarding_title_2;

  /// No description provided for @onboarding_description_2.
  ///
  /// In es, this message translates to:
  /// **'Regístrate y guarda tu perfil, Pokémon favoritos, configuraciones y mucho más en la aplicación'**
  String get onboarding_description_2;

  /// No description provided for @onboarding_button_2.
  ///
  /// In es, this message translates to:
  /// **'Empecemos'**
  String get onboarding_button_2;

  /// No description provided for @welcome.
  ///
  /// In es, this message translates to:
  /// **'Bienvenidos'**
  String get welcome;

  /// No description provided for @coming_soon.
  ///
  /// In es, this message translates to:
  /// **'¡Muy pronto disponible!'**
  String get coming_soon;

  /// No description provided for @section_in_progress.
  ///
  /// In es, this message translates to:
  /// **'Estamos trabajando para traerte esta sección. Vuelve más adelante para descubrir todas las novedades.'**
  String get section_in_progress;

  /// No description provided for @something_went_wrong.
  ///
  /// In es, this message translates to:
  /// **'Algo salió mal...'**
  String get something_went_wrong;

  /// No description provided for @load_error_message.
  ///
  /// In es, this message translates to:
  /// **'No pudimos cargar la información en este momento. Verifica tu conexión o intenta nuevamente más tarde.'**
  String get load_error_message;

  /// No description provided for @retry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get retry;

  /// No description provided for @search_pokemon.
  ///
  /// In es, this message translates to:
  /// **'Buscar Pokemon'**
  String get search_pokemon;

  /// No description provided for @water.
  ///
  /// In es, this message translates to:
  /// **'Agua'**
  String get water;

  /// No description provided for @dragon.
  ///
  /// In es, this message translates to:
  /// **'Dragón'**
  String get dragon;

  /// No description provided for @electric.
  ///
  /// In es, this message translates to:
  /// **'Eléctrico'**
  String get electric;

  /// No description provided for @fairy.
  ///
  /// In es, this message translates to:
  /// **'Hada'**
  String get fairy;

  /// No description provided for @ghost.
  ///
  /// In es, this message translates to:
  /// **'Fantasma'**
  String get ghost;

  /// No description provided for @fire.
  ///
  /// In es, this message translates to:
  /// **'Fuego'**
  String get fire;

  /// No description provided for @ice.
  ///
  /// In es, this message translates to:
  /// **'Hielo'**
  String get ice;

  /// No description provided for @grass.
  ///
  /// In es, this message translates to:
  /// **'Planta'**
  String get grass;

  /// No description provided for @bug.
  ///
  /// In es, this message translates to:
  /// **'Bicho'**
  String get bug;

  /// No description provided for @fighting.
  ///
  /// In es, this message translates to:
  /// **'Lucha'**
  String get fighting;

  /// No description provided for @normal.
  ///
  /// In es, this message translates to:
  /// **'Normal'**
  String get normal;

  /// No description provided for @dark.
  ///
  /// In es, this message translates to:
  /// **'Siniestro'**
  String get dark;

  /// No description provided for @steel.
  ///
  /// In es, this message translates to:
  /// **'Acero'**
  String get steel;

  /// No description provided for @rock.
  ///
  /// In es, this message translates to:
  /// **'Roca'**
  String get rock;

  /// No description provided for @psychic.
  ///
  /// In es, this message translates to:
  /// **'Psíquico'**
  String get psychic;

  /// No description provided for @ground.
  ///
  /// In es, this message translates to:
  /// **'Tierra'**
  String get ground;

  /// No description provided for @poison.
  ///
  /// In es, this message translates to:
  /// **'Veneno'**
  String get poison;

  /// No description provided for @flying.
  ///
  /// In es, this message translates to:
  /// **'Volador'**
  String get flying;

  /// No description provided for @apply.
  ///
  /// In es, this message translates to:
  /// **'Aplicar'**
  String get apply;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @filter_by_preference.
  ///
  /// In es, this message translates to:
  /// **'Filtra por tus preferencias'**
  String get filter_by_preference;

  /// No description provided for @typeLabel.
  ///
  /// In es, this message translates to:
  /// **'Tipo'**
  String get typeLabel;

  /// No description provided for @no_favorite_pokemon.
  ///
  /// In es, this message translates to:
  /// **'No has marcado ningún Pokémon como favorito'**
  String get no_favorite_pokemon;

  /// No description provided for @favorite_pokemon_hint.
  ///
  /// In es, this message translates to:
  /// **'Haz clic en el ícono de corazón de tus Pokémon favoritos y aparecerán aquí.'**
  String get favorite_pokemon_hint;

  /// No description provided for @not_found_pokemon.
  ///
  /// In es, this message translates to:
  /// **'No se encontró un Pokémon'**
  String get not_found_pokemon;

  /// No description provided for @pokedex.
  ///
  /// In es, this message translates to:
  /// **'Pokédex'**
  String get pokedex;

  /// No description provided for @regions.
  ///
  /// In es, this message translates to:
  /// **'Regiones'**
  String get regions;

  /// No description provided for @favorites.
  ///
  /// In es, this message translates to:
  /// **'Favoritos'**
  String get favorites;

  /// No description provided for @profile.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get profile;

  /// No description provided for @weaknesses.
  ///
  /// In es, this message translates to:
  /// **'Debilidades'**
  String get weaknesses;

  /// No description provided for @gender.
  ///
  /// In es, this message translates to:
  /// **'Genero'**
  String get gender;

  /// No description provided for @weight.
  ///
  /// In es, this message translates to:
  /// **'Peso'**
  String get weight;

  /// No description provided for @height.
  ///
  /// In es, this message translates to:
  /// **'Altura'**
  String get height;

  /// No description provided for @category.
  ///
  /// In es, this message translates to:
  /// **'Categoria'**
  String get category;

  /// No description provided for @ability.
  ///
  /// In es, this message translates to:
  /// **'Habilidad'**
  String get ability;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
