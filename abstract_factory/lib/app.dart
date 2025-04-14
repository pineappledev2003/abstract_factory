import 'package:abstract_factory/routes/router.dart';
import 'package:abstract_factory/service/navigation_service.dart';
import 'package:abstract_factory/ui/layout/main_layout_page.dart';
import 'package:abstract_factory/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context, themeController, child) {
        return MaterialApp(
          title: "Abstract_factory",
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          theme: themeController.obtenerTema,

          //? Cuando Flutter necesite mostar una nueva pantalla
          //? le pedimos a Fluro (RouterFluro.router.generator) que busque la ruta
          //? y nos diga que widget devolver segun lo que hayamos definido
          onGenerateRoute: RouterFluro.router.generator,

          //? Aquí uso el "mapa global" (navigatorKey) que fue creado en NavigationServices
          //? para conectar el Navigator con toda la app y permitir navegación sin context
          navigatorKey: NavigationServices.navigatorKey,
          builder: (context, child) {
            return MainLayoutPage(child: child ?? Container());
          },
        );
      },
    );
  }
}
