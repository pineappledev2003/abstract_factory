import 'package:dio/dio.dart';

class BackendFrog {
  static final Dio _dio = Dio();

  static void configureDio() {
    _dio.options.baseUrl = "http://localhost:8080/pagos";
    _dio.options.headers = {'Content-Type': 'application/json'};
    _dio.options.validateStatus = (status) {
      // Acepta respuestas con 200-299 como exitosas
      // y también errores controlados como 400 (validación del negocio)
      return status != null && (status >= 200 && status < 300 || status == 400);
    };
  }

  static Future post(String path, Map<String, dynamic> data) async {
    try {
      final resp = await _dio.post(path, data: data);
      return resp.data;
    } on DioException catch (e) {
      throw Exception("Error en el POST $e");
    }
  }
}
