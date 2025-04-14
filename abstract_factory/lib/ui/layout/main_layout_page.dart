import 'package:abstract_factory/ui/shared/custom_app_menu.dart';
import 'package:flutter/material.dart';

class MainLayoutPage extends StatelessWidget {

  final Widget child;

  const MainLayoutPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppMenu(text: "CREAR TARJETA",),
          Expanded(child: child),
        ],
      ),
    );
  }
}