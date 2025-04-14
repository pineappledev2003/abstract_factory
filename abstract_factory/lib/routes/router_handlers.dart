import 'package:abstract_factory/ui/views/credito_view.dart';
import 'package:abstract_factory/ui/views/debito_view.dart';
import 'package:abstract_factory/ui/views/no_page_found_view.dart';
import 'package:abstract_factory/ui/views/paypal_view.dart';
import 'package:fluro/fluro.dart';

class RouterHandlers {
  static Handler crearPagoHandler = Handler(
    handlerFunc: (context, parameters) {
      final tipo = parameters["base"]?.first.toUpperCase();

      if (tipo == "CREDITO") {
        return CreditoView(baseURL: tipo ?? "CREDITO");
      } else {
        return NoPageFoundView();
      }
    },
  );

  static Handler debitoPagoHandler = Handler(
    handlerFunc: (context, parameters) {
      final tipo = parameters["base"]?.first.toUpperCase();

      if (tipo == "DEBITO") {
        return DebitoView(baseURL: tipo!);
      } else {
        return NoPageFoundView();
      }
    },
  );

  static Handler payPalPagoHandler = Handler(
    handlerFunc: (context, parameters) {
      final tipo = parameters["base"]?.first.toUpperCase();
      if (tipo == "PAYPAL") {
        return PayPalView(baseURL: tipo!);
      } else {
        return NoPageFoundView();
      }
    },
  );

  static Handler noPageFound = Handler(
    handlerFunc: (context, parameters) {
      return NoPageFoundView();
    },
  );
}
