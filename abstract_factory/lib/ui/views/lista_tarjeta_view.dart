import 'package:abstract_factory/controller/credito_controller.dart';
import 'package:abstract_factory/controller/debito_controller.dart';
import 'package:abstract_factory/controller/paypal_controller.dart';
import 'package:abstract_factory/datables/tarjetas_credito_datasource.dart';
import 'package:abstract_factory/datables/tarjetas_debito_datasource.dart';
import 'package:abstract_factory/datables/tarjetas_paypal_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaTarjetasView extends StatefulWidget {
  const ListaTarjetasView({super.key});

  @override
  State<ListaTarjetasView> createState() => _ListaTarjetaViewState();
}

class _ListaTarjetaViewState extends State<ListaTarjetasView> {
  String _tipoSeleccionado = "credito";

  @override
  void initState() {
    super.initState();
    Provider.of<CreditoController>(context, listen: false).obtenerListaCreditos();
    Provider.of<DebitoController>(context, listen: false).obtenerListaDebitos();
    Provider.of<PaypalController>(context, listen: false).obtenerListaPayPal();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: DropdownButtonFormField(
              value: _tipoSeleccionado,
              items: [
                DropdownMenuItem(value: "credito", child: Text("Credito")),
                DropdownMenuItem(value: "debito", child: Text("Debito")),
                DropdownMenuItem(value: "paypal", child: Text("PayPal")),
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "TIPOS DE TARJETAS",
              ),
              onChanged: (value) {
                setState(() {
                  _tipoSeleccionado = value!;
                });
              },
            ),
          ),
          PaginatedDataTable(
            // 👇 Usamos una Key basada en _tipoSeleccionado para forzar la reconstrucción del widget
            // Esto es necesario porque PaginatedDataTable no actualiza las columnas dinámicamente
            // si Flutter considera que el widget es "el mismo". Con esta Key se asegura el rebuild.
            key: ValueKey(_tipoSeleccionado),
            columns: _getColumnasPorTipo(_tipoSeleccionado),
            source: _getDataSourcePorTipo(_tipoSeleccionado),
            header: Text("TABLAS"),
          ),
        ],
      ),
    );
  }

  List<DataColumn> _getColumnasPorTipo(String tipo) {
    switch (tipo) {
      case "debito":
        return [
          DataColumn(label: Text("TIPO TARJETA")),
          DataColumn(label: Text("NUM TARJETA")),
          DataColumn(label: Text("NOMBRE TITULAR")),
          DataColumn(label: Text("CVV")),
          DataColumn(label: Text("SALDO DISPONIBLE")),
          DataColumn(label: Text("REALIZAR PAGO")),
        ];
      case "paypal":
        return [
          DataColumn(label: Text("TIPO TARJETA")),
          DataColumn(label: Text("EMAIL")),
          DataColumn(label: Text("LIMITE PAYPAL")),
          DataColumn(label: Text("REALIZAR PAGO")),
        ];
      case "credito":
      default:
        return [
          DataColumn(label: Text("TIPO TARJETA")),
          DataColumn(label: Text("NUM TARJETA")),
          DataColumn(label: Text("NOMBRE TITULAR")),
          DataColumn(label: Text("CVV")),
          DataColumn(label: Text("LIMITE CREDITO")),
          DataColumn(label: Text("REALIZAR PAGO")),
        ];
    }
  }

  DataTableSource _getDataSourcePorTipo(String tipo) {
    switch (tipo) {
      case "debito":
        final tarjetasDebitoController =
            Provider.of<DebitoController>(context, listen: false).obtenerListaDebitos();
        final tarjetasListDebito = tarjetasDebitoController.values.toList();
        return TarjetasDebitoDatasource(tarjetasListDebito, context);
      case "credito":
        final tarjetasCreditoController =
            Provider.of<CreditoController>(context, listen: false).obtenerListaCreditos();
        final tarjetasListCredito = tarjetasCreditoController.values.toList();
        return TarjetasCreditoDatasource(tarjetasListCredito, context);
      case "paypal":
      default:
        final tarjetasPayPalController =
            Provider.of<PaypalController>(context, listen: false).obtenerListaPayPal();
        final tarjetasListPayPal = tarjetasPayPalController.values.toList();
        return TarjetasPayPalDatasource(tarjetasListPayPal, context);
    }
  }
}
