// To parse this JSON data, do
//
//     final errorBackend = errorBackendFromJson(jsonString);

import 'dart:convert';

ErrorBackend errorBackendFromJson(String str) => ErrorBackend.fromJson(json.decode(str));

String errorBackendToJson(ErrorBackend data) => json.encode(data.toJson());

class ErrorBackend {
    bool success;
    String mensaje;

    ErrorBackend({
        required this.success,
        required this.mensaje,
    });

    factory ErrorBackend.fromJson(Map<String, dynamic> json) => ErrorBackend(
        success: json["success"],
        mensaje: json["mensaje"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "mensaje": mensaje,
    };
}
