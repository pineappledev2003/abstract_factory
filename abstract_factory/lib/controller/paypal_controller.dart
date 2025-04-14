import 'package:abstract_factory/models/paypal.dart';
import 'package:flutter/material.dart';

class PaypalController extends ChangeNotifier {
  final Map<String, Paypal> _listaPayPal = {};

  void registrarPayPal(String tipoTarjeta, String email, double limitePayPal) {
    if (_listaPayPal.containsKey(email)) {
      throw Exception("Esta tarjeta paypal ya esta creada");
    }

    Paypal paypal = Paypal(tipoTrajeta: tipoTarjeta, email: email, limitePayPal: limitePayPal);
    _listaPayPal[email] = paypal;
    notifyListeners();
  }


  Map<String,Paypal> obtenerListaPayPal(){
    return _listaPayPal;
  }
}
