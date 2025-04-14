import 'package:abstract_factory/api/backend_frog.dart';
import 'package:abstract_factory/app.dart';
import 'package:abstract_factory/providers/theme_provider.dart';
import 'package:abstract_factory/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  BackendFrog.configureDio();
  RouterFluro.configureRoutes();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ThemeController())],
      child: const MainApp(),
    ),
  );
}
