import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class Application {
  static Application? _singleton;
  late String platform;
  late String? timeZone;
  late GlobalKey<NavigatorState> appNavigatorKey;
  GoRouter? globalRouter;

  factory Application() {
    _singleton ??= Application._();

    return _singleton!;
  }

  Application._();
}
