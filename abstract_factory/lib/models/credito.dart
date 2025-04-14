import 'package:abstract_factory/models/tarjeta_base.dart';

class Credito extends TarjetaBase {
  Credito({
    required super.tipoTarjeta,
    required super.numeroTarjeta,
    required super.nombreTitular,
    required super.cvv,
    required super.disponible,
  });
}
