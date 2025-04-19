import 'package:abstract_factory/models/debito.dart';
import 'package:flutter/material.dart';

class DebitoController extends ChangeNotifier {
  final Map<String, Debito> _listaDebitos = {};

  void registrarTarjetasDebitos(String tipoTarjeta, String numeroTarjeta, String nombreTitular, String cvv, double disponible){
    if (_listaDebitos.containsKey(numeroTarjeta)) {
      throw Exception("Esta tarjeta ya esta registrada");
    }

    Debito debito = Debito(tipoTarjeta: tipoTarjeta, numeroTarjeta: numeroTarjeta, nombreTitular: nombreTitular, cvv: cvv, disponible: disponible);

    _listaDebitos[numeroTarjeta] = debito;
    notifyListeners();
  }

  Map<String,Debito> obtenerListaDebitos(){
    return _listaDebitos;
  }
}