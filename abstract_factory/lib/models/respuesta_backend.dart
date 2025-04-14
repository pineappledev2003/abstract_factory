
import 'dart:convert';

RespuestaBackend respuestaBackendFromJson(String str) => RespuestaBackend.fromJson(json.decode(str));

String respuestaBackendToJson(RespuestaBackend data) => json.encode(data.toJson());

class RespuestaBackend {
    bool success;
    String tipo;
    String id;
    double montoFinal;
    double nuevoLimite;
    String mensaje;

    RespuestaBackend({
        required this.success,
        required this.tipo,
        required this.id,
        required this.montoFinal,
        required this.nuevoLimite,
        required this.mensaje,
    });

  factory RespuestaBackend.fromJson(Map<String, dynamic> json) {
    return RespuestaBackend(
      success: json["success"] ?? false,
      tipo: json["tipo"] ?? "",
      id: json["id"] ?? "",
      montoFinal: (json["monto_final"] as num?)?.toDouble() ?? 0.0, // Maneja nulos en los valores numéricos
      nuevoLimite: (json["nuevo_limite"] as num?)?.toDouble() ?? 0.0, // Maneja nulos en los valores numéricos
      mensaje: json["mensaje"] ?? "No se proporcionó mensaje", // Valor por defecto para mensaje
    );
  }

    Map<String, dynamic> toJson() => {
        "success": success,
        "tipo": tipo,
        "id": id,
        "monto_final": montoFinal,
        "nuevo_limite": nuevoLimite,
        "mensaje": mensaje,
    };
}
