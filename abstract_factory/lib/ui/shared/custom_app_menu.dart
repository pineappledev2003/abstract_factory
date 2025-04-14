import 'package:abstract_factory/providers/theme_provider.dart';
import 'package:abstract_factory/service/navigation_service.dart';
import 'package:abstract_factory/ui/shared/widgets/custom_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

enum TipoTarjetas { debito, credito, paypal }

class CustomAppMenu extends StatelessWidget {
  final String text;

  const CustomAppMenu({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _DesktopMenu(text: text);
      },
    );
  }
}

class _DesktopMenu extends StatelessWidget {
  final String text;

  const _DesktopMenu({required this.text});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);

    final bool tipoTema = themeController.obtenerTipoFabrica;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      height: 58,
      child: Stack(
        children: [
          Text("$text :", style: GoogleFonts.inter(fontSize: 20)),

          Positioned(
            left: 170,
            child: CustomFaltButton(
              text: "CREDITO",
              onPressed: () {
                NavigationServices.navigateTo("/tarjeta_credito/credito");
              },
            ),
          ),

          Positioned(
            left: 250,
            child: CustomFaltButton(
              text: "DEBITO",
              onPressed: () {
                NavigationServices.navigateTo("/tarjeta_debito/debito");
              },
            ),
          ),

          Positioned(
            left: 320,
            child: CustomFaltButton(
              text: "PAYPAL",
              onPressed: () {
                NavigationServices.navigateTo("/tarjeta_paypal/paypal");
              },
            ),
          ),

          Positioned(left: 390, child: CustomFaltButton(text: "HACER PAGO", onPressed: () {})),

          Positioned(
            right: 0,
            child: Row(
              children: [
                Icon(tipoTema ? Icons.wb_sunny : Icons.nights_stay),
                Switch(
                  activeColor: Colors.blue,
                  value: tipoTema,
                  onChanged: (value) {
                    themeController.toggleTheme();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
