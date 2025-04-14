import 'package:dio/dio.dart';

class BackendFrog {
  
  static final Dio _dio = Dio();

  static void configureDio() {
    _dio.options.baseUrl = "http://localhost:8080/pagos";
    _dio.options.headers = {'Content-Type': 'application/json'};
  }

  static Future post(String path, Map<String, dynamic> data) async {

    try {
      final resp = await _dio.post(path, data: data, options: Options(validateStatus: (status) => status != null && status < 500,));
      return resp.data;
    } on DioException catch (e) {
      throw Exception("Error en el POST $e");
    }
  }
}
