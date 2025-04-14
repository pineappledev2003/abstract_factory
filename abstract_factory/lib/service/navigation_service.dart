import 'package:flutter/widgets.dart';

class NavigationServices {

  //? Este GlobalKey actúa como un "mapa global de rutas" para toda la app.
  //? Al ser static, no necesitamos crear una instancia de NavigationServices para usarlo.
  //? Nos permite acceder al Navigator desde cualquier parte del código sin necesitar BuildContext.

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  static replaceTo(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  static goBack() {
    return navigatorKey.currentState!.pop();
  }
}
