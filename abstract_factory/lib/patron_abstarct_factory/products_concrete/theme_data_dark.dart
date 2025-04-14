import 'package:abstract_factory/patron_abstarct_factory/abstract_products/abstract_theme_data.dart';
import 'package:flutter/material.dart';

class ThemeDataDark implements AbstractThemeData {
  @override
  ThemeData buildThemeData() {
    return ThemeData.dark(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor:  WidgetStatePropertyAll(Colors.white)
        )
      ),
      dividerTheme: DividerThemeData(
        color: Colors.white
      )
    );
  }
}
