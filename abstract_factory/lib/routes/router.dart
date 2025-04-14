import 'package:abstract_factory/routes/router_handlers.dart';
import 'package:fluro/fluro.dart';

//? Clase que configura y expone el router global para la app

class RouterFluro {

  //? Usamos 'static' para crear una sola instancia del router en toda la app.
  //? Esto evita tener que crear objetos de RouterFluro manualmente.
  //? Así, accedemos directamente con: RouterFluro.router

  //? Instancia global y unica del router Fluro
  static final FluroRouter router = FluroRouter();

  //? Metodo estatico que define todas las rutas validas
  //? Puede ser llamado desde cualquier lugar sin crear un objeto de esta clase
  static void configureRoutes(){

    router.define("/", handler: RouterHandlers.crearPagoHandler, transitionType: TransitionType.fadeIn);
    router.define("/tarjeta_credito/:base", handler: RouterHandlers.crearPagoHandler, transitionType: TransitionType.fadeIn);
    router.define("/tarjeta_debito/:base", handler: RouterHandlers.debitoPagoHandler, transitionType: TransitionType.fadeIn);
    router.define("/tarjeta_paypal/:base", handler: RouterHandlers.payPalPagoHandler, transitionType: TransitionType.fadeIn);


    //Imporatante siempre definir el notFoundHandler
    router.notFoundHandler = RouterHandlers.noPageFound;
  }
}