import 'package:abstract_factory/patron_abstarct_factory/abstract_factory/abstract_factory.dart';
import 'package:abstract_factory/patron_abstarct_factory/abstract_products/abstract_theme_data.dart';
import 'package:abstract_factory/patron_abstarct_factory/products_concrete/theme_data_dark.dart';


class FactoryThemeDark implements AbstractFactory {
  @override
  AbstractThemeData createThemeData() {
    return ThemeDataDark();
  }
}