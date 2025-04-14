import 'package:abstract_factory/models/tarjeta_base.dart';

class Debito extends TarjetaBase {
  Debito({
    required super.tipoTarjeta,
    required super.numeroTarjeta,
    required super.nombreTitular,
    required super.cvv,
    required super.disponible,
  });
}
