class TarjetaBase {
  String? _tipoTarjeta;
  String? _numeroTarjeta;
  String? _nombreTitular;
  String? _cvv;
  double? _disponible;


  TarjetaBase({required String tipoTarjeta, required String numeroTarjeta, required String nombreTitular, required String cvv, required double disponible }){
    _tipoTarjeta = tipoTarjeta;
    _numeroTarjeta = numeroTarjeta;
    _nombreTitular = nombreTitular;
    _cvv = cvv;
    _disponible = disponible;
  }

  String get obtenerTipoTarjeta{
    return _tipoTarjeta!;
  }

  String get obtenerNumeroTarjeta{
    return _numeroTarjeta!;
  }

  String get obtenerNombreTitular{
    return _nombreTitular!;
  }

  String get obtenerCvv{
    return _cvv!;
  }

  double get obtenerDisponible{
    return _disponible!;
  }

}