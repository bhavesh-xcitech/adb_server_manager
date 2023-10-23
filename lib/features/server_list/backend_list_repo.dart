import 'dart:convert';

import 'package:adb_server_manager/network_services/api_client.dart';
import 'package:adb_server_manager/network_services/api_result.dart';
import 'package:adb_server_manager/network_services/api_result_service.dart';
import 'package:adb_server_manager/resource/api_endpoints.dart';
import 'package:dio/dio.dart';

class BackendListRepo {
  Future<dynamic> fetchData() async {
    final dio = Dio();
    const baseUrl = "https://projects.xcitech.in/pm2-api/";
    const token = "us3r_4uth_tok3n";

    try {
      final response = await dio.get(
        '${baseUrl}pm2/list',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'token': token,
        }),
      );
      var data = response.data;
      if (response.data.runtimeType == String) {
        data = jsonDecode(data);
      }
      if (response.statusCode == 200) {
        // Process responseData here

        return ApiResult.success(
          data: data['data'],
          message: data['message'],
        );
      } else {}
    } catch (e) {
      // Handle network errors or Dio exceptions here
    }
  }

  Future<ApiResult> getBackendList() async {
    ApiResult apiResult = await DioClient().get(
      ApisEndPoints.backendListing,
    );
    return apiResult;
  }

  Future<RepoResult> allBackendList() async {
    try {
      final response = await commonApiCall(getBackendList());
      if (response is ApiSuccess) {
        return RepoResult.success(
            data: response.data, message: response.message);
      } else {
        return RepoResult.failure(error: (response as ApiFailure).error);
      }
    } catch (e) {
      return RepoResult.failure(error: e.toString());
    }
  }
}
