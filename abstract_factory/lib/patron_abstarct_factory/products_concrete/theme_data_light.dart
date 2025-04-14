import 'package:abstract_factory/patron_abstarct_factory/abstract_products/abstract_theme_data.dart';
import 'package:flutter/material.dart';

class ThemeDataLight implements AbstractThemeData {
  @override
  ThemeData buildThemeData() {
    return ThemeData.light(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.blue, foregroundColor: Colors.white),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.black)),
      ),
      dividerTheme: DividerThemeData(
        color: Colors.black
      )
    );
  }
}
