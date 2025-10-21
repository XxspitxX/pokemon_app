import 'package:api_source/di/api_source_di.module.dart';
import 'package:pokemon_app/dependency_injection/pokemon_di.config.dart';
import 'package:data/di/data_di.module.dart';
import 'package:domain/di/domain_di.module.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:db_source/di/db_source_di.module.dart';
import 'package:ui/di/ui_di.module.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
  externalPackageModulesAfter: [
    ExternalModule(ApiSourcePackageModule),
    ExternalModule(DataPackageModule),
    ExternalModule(DomainPackageModule),
    ExternalModule(DbSourcePackageModule),
    ExternalModule(UiPackageModule),
  ],
)
void configureDependencies() => getIt.init();
