import 'package:flutter/material.dart';

class CreditoDebitoFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String tipoTarjeta = "";
  String numeroTarjeta = "";
  String nombreTitular = "";
  String cvv = "";
  double limiteCredito = 0.0;

  set setTipoTarjeta(String value) {
    tipoTarjeta = value;
    notifyListeners();
  }

  set setNumeroTarjeta(String value) {
    numeroTarjeta = value;
    notifyListeners();
  }

  set setNombreTitular(String value) {
    nombreTitular = value;
    notifyListeners();
  }

  set setCvv(String value) {
    cvv = value;
    notifyListeners();
  }

  set setLimiteCredito(double value) {
    limiteCredito = value;
    notifyListeners();
  }

  validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
