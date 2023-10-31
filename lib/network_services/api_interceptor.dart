import 'dart:convert';

import 'package:adb_server_manager/network_services/api_headers.dart';
import 'package:adb_server_manager/network_services/api_result.dart';
import 'package:dio/dio.dart';

class ApiInterceptors {
  getInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {

        Map<String, dynamic> headers = await ApiHeaders.getHeaders();

        headers.addAll(options.headers);
        options.headers = headers;
        return handler.next(options);
      },
      onResponse: (response, handler) async {



        if (response.statusCode == 400) {
          return handler.next(response);
        } else if (response.statusCode == 404) {
          response.data = const ApiResult.failure(error: 'Process Failed');
          return handler.next(response);
        }
        var data = response.data;
        if (response.data.runtimeType == String) {
          data = jsonDecode(data);
        }

        if (response.statusCode == 200) {
          response.data = ApiResult.success(
            data: data['data'],
            message: data['message'],
          );
        } else {
          response.data =
              ApiResult.failure(error: data['error'] ?? data['message']);
        }

        return handler.next(response);
      },
      onError: (e, handler) async {
      
        e.response?.data = ApiResult.failure(error: Exception(e.toString()));
        return handler.next(e);
      },
    );
  }
}
