class ApiHeaders {
  static Future<Map<String, dynamic>> getHeaders() async {
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      // 'accept': "application/json",
      "token":"us3r_4uth_tok3n"
    };

    return headers;
  }
}
