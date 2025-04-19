import 'package:abstract_factory/models/paypal.dart';
import 'package:abstract_factory/ui/modals/pago_modal_paypal.dart';
import 'package:flutter/material.dart';

class TarjetasPayPalDatasource extends DataTableSource {
  final List<Paypal> tarjetas;
  final BuildContext context;

  TarjetasPayPalDatasource(this.tarjetas, this.context);

  @override
  DataRow? getRow(int index) {
    final tarjeta = tarjetas[index];

    return DataRow.byIndex(
      cells: [
        DataCell(Text(tarjeta.obtenerTipoTarjeta)),
        DataCell(Text(tarjeta.obtenerEmail)),
        DataCell(Text(tarjeta.obtenerLimitePayPal.toString())),
        DataCell(
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  maxWidth: MediaQuery.of(context).size.width,
                ),

                context: context,
                builder: (context) {
                  return PagoModalPayPal(paypal: tarjeta);
                },
              );
            },
            icon: Icon(Icons.credit_card),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => tarjetas.length;

  @override
  int get selectedRowCount => 0;
}
