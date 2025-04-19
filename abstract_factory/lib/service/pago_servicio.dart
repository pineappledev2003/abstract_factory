import 'package:abstract_factory/api/backend_frog.dart';
import 'package:abstract_factory/models/error_response_backend.dart';
import 'package:abstract_factory/models/respuesta_backend.dart';

class PagoServicio {
  static Future<Map<String, dynamic>> procesarPago(
    String tipo,
    String id,
    double limite,
    double monto,
  ) async {
    final data = {"tipo": tipo, "id": id, "limite": limite, "monto": monto};

    final respuesta = await BackendFrog.post("/procesar_pago", data);
    final respuestaBackend = RespuestaBackend.fromJson(respuesta);

    if (respuestaBackend.success) {
      final success = respuestaBackend.success;
      final tipo = respuestaBackend.tipo;
      final id = respuestaBackend.id;
      final montoFinal = respuestaBackend.montoFinal;
      final nuevoLimite = respuestaBackend.nuevoLimite;
      final mensaje = respuestaBackend.mensaje;

      return {
        "success": success,
        "tipo": tipo,
        "id": id,
        "monto_final": montoFinal,
        "nuevo_limite": nuevoLimite,
        "mensaje": mensaje,
      };
    }else{
      final respuestaMalaBackend = ErrorBackend.fromJson(respuesta);
      return {
        "success":respuestaMalaBackend.success,
        "mensaje":respuestaMalaBackend.mensaje
      };
    }

   
  }
}
