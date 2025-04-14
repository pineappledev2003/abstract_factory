import 'package:abstract_factory/models/debito.dart';
import 'package:flutter/material.dart';

class DebitoController extends ChangeNotifier {
  final Map<String, Debito> _listaDebitos = {};


  void registrarTarjeta(String tipoTarjera, String numeroTarjeta, String nombreTitular, String cvv, double limiteCredito){
    if (_listaDebitos.containsKey(numeroTarjeta)) {
      throw Exception("Esta tarjeta credito ya esta registrada");
    }
    Debito debito = Debito(tipoTarjeta: tipoTarjera, numeroTarjeta: numeroTarjeta, nombreTitular: nombreTitular, cvv: cvv, disponible: limiteCredito);

    _listaDebitos[numeroTarjeta] = debito;
    notifyListeners();
  }

  Map<String,Debito> obtenerListaCreditos(){
    return _listaDebitos;
  }
}