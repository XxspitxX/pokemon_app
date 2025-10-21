import 'package:db_source/configuration/database_configuration.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/dependency_injection/pokemon_di.dart';
import 'package:pokemon_app/pokemon_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseConfigurator().init();
  configureDependencies();

  runApp(PokemonApp());
}
