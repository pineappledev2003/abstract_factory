
import 'package:abstract_factory/models/credito.dart';
import 'package:flutter/material.dart';

class CreditoController extends ChangeNotifier {
  final Map<String, Credito> _listaCreditos = {};


  void registrarTarjeta(String tipoTarjera, String numeroTarjeta, String nombreTitular, String cvv, double disponible){
    if (_listaCreditos.containsKey(numeroTarjeta)) {
      throw Exception("Esta tarjeta ya esta registrada");
    }
    Credito credito = Credito(tipoTarjeta: tipoTarjera, numeroTarjeta: numeroTarjeta, nombreTitular: nombreTitular, cvv: cvv, disponible: disponible);

    _listaCreditos[numeroTarjeta] = credito;
    notifyListeners();
  }

  Map<String,Credito> obtenerListaCreditos(){
    return _listaCreditos;
  }
}