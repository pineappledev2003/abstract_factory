import 'package:abstract_factory/models/credito.dart';
import 'package:abstract_factory/ui/modals/pago_modal_credito.dart';
import 'package:flutter/material.dart';

class TarjetasCreditoDatasource extends DataTableSource {
  final List<Credito> tarjetas;
  final BuildContext context;

  TarjetasCreditoDatasource(this.tarjetas, this.context);

  @override
  DataRow? getRow(int index) {
    final tarjeta = tarjetas[index];

    return DataRow.byIndex(
      cells: [
        DataCell(Text(tarjeta.obtenerTipoTarjeta)),
        DataCell(Text(tarjeta.obtenerNumeroTarjeta)),
        DataCell(Text(tarjeta.obtenerNombreTitular)),
        DataCell(Text(tarjeta.obtenerCvv)),
        DataCell(Text(tarjeta.obtenerDisponible.toString())),
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
                  return PagoModalCredito(credito: tarjeta);
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
