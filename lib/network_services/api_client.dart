import 'dart:io';

import 'package:adb_server_manager/network_services/api_interceptor.dart';
import 'package:dio/dio.dart';
// class DioClient {
//   late Dio _dio;
//   late String baseUrl;

//   static final DioClient _dioClient = DioClient._internal();

//   factory DioClient() {
//     return _dioClient;
//   }

//   DioClient._internal() {
//     baseUrl = "https://projects.xcitech.in/pm2-api/";
//     _dio = Dio(
//       BaseOptions(
//         baseUrl: baseUrl,
//         validateStatus: (status) {
//           // This allows you to receive 400 status codes as a response
//           return status! <= 500;
//         },
//       ),
//     );
//     _dio.options.headers = {
//       'Content-Type': 'application/json',
//       'token': 'us3r_4uth_tok3n',
//     };
//   }

class DioClient {
  late Dio _dio;
  late String baseUrl;

  static final DioClient _dioClient = DioClient._internal();

  factory DioClient() {
    return _dioClient;
  }

  DioClient._internal() {
    baseUrl = "https://projects.xcitech.in/pm2-api/";
    // "https://projects.xcitech.in/pm2-api/";

    _dio = Dio();
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        validateStatus: (status) {
          // This allows you to receive 400 status codes as a response
          return status! <= 500;
        },
      ),
    );
    _dio..options.baseUrl = baseUrl
    ..httpClientAdapter;
    // ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'};

    _dio.interceptors.add(ApiInterceptors().getInterceptor());
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {

      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> download(
    String url,
    String saveFilePath, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    _dio.interceptors.clear();
    try {
      await _dio.download(url, saveFilePath);
      return true;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postMultipartFile(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }
}
