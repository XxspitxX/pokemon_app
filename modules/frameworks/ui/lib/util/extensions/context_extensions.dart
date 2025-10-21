import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  Size get mediaQuerySize => MediaQuery.of(this).size;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
