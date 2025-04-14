import 'package:abstract_factory/patron_abstarct_factory/abstract_factory/abstract_factory.dart';
import 'package:abstract_factory/patron_abstarct_factory/factory_concrete/factory_theme_dark.dart';
import 'package:abstract_factory/patron_abstarct_factory/factory_concrete/factory_theme_light.dart';
import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  //? Aqui defino la fabrica que voy a usar por defecto.
  //? En este caso, quiero trabajar con la fabrica de temas claro.
  //! Importante: todavia no fabrico nada, solo tengo la fabrica lista

  AbstractFactory _themeFactory = FactoryThemeLight();

  ThemeData get obtenerTema {
    //? Aqui le voy a pedir a la fabrica (_themeFactory) que me entregue un producto
    //? Ese producto es un "modelo de tema" (como un plano de construccion) (.createThemeData)
    //? Luego, le digo a ese modelo que construya el "tema real" que necesito (.buildThemeData)

    return _themeFactory.createThemeData().buildThemeData();
  }


  bool get obtenerTipoFabrica {
    return _themeFactory is FactoryThemeLight;
  }

  //? Esta función sirve para cambiar de fábrica, es decir, cambiar el tipo de tema actual (claro u oscuro).

  void toggleTheme() {
    //? Verificamos si actualmente estamos usando la fábrica de temas claros.
    //? Si es así, la cambiamos por la fábrica de temas oscuros.
    //? Si no lo es, entonces cambiamos a la fábrica de temas claros.

    _themeFactory = _themeFactory is FactoryThemeLight ? FactoryThemeDark() : FactoryThemeLight();

    //? Notificamos a toda la app que hubo un cambio de fábrica (y por lo tanto, de diseño de tema).
    notifyListeners();
  }
}
