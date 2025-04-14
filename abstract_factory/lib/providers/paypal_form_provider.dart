import 'package:flutter/widgets.dart';

class PaypalFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String tipoTarjeta = "";
  String email = "";
  double limitePayPal = 0.0;

  set nuevoTipoTarjeta(String nuevoTipoTarjeta){
    tipoTarjeta = nuevoTipoTarjeta;
    notifyListeners();
  }

  set nuevoEmail(String nuevoEmail){
    email = nuevoEmail;
    notifyListeners();
  }

  set nuevoLimitePayPal(double nuevoLimitePayPal){
    limitePayPal = nuevoLimitePayPal;
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