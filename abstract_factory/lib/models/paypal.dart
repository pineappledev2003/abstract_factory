class Paypal {
  String? _tipoTarjeta;
  String? _email;
  double? _limitePayPal;

  Paypal({required String tipoTrajeta, required String email, required double limitePayPal}) {
    _tipoTarjeta = tipoTrajeta;
    _email = email;
    _limitePayPal = limitePayPal;
  }

  String get obtenerTipoTarjeta {
    return _tipoTarjeta!;
  }

  String get obtenerEmail {
    return _email!;
  }

  double get obtenerLimitePayPal {
    return _limitePayPal!;
  }
}
