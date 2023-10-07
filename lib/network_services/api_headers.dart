import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiHeaders {
  static Future<Map<String, dynamic>> getHeaders() async {
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      // 'accept': "application/json",
      "token": dotenv.env['TOKEN'] ?? ''
    };

    return headers;
  }
}
