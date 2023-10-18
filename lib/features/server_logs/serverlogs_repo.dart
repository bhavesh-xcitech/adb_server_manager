import 'package:adb_server_manager/network_services/api_client.dart';
import 'package:adb_server_manager/network_services/api_result.dart';
import 'package:adb_server_manager/network_services/api_result_service.dart';
import 'package:adb_server_manager/resource/api_endpoints.dart';

class ServerLogsRepo {
  Future<ApiResult> getServerLogs(
      {required int page, required int limit}) async {
    ApiResult apiResult = await DioClient()
        .get("${ApisEndPoints.serverLogs}?page=$page&limit$limit");

    return apiResult;
  }

  Future<RepoResult> serverLogs({required int page, required int limit}) async {
    try {
      final response =
          await commonApiCall(getServerLogs(page: page, limit: limit));

      if (response is ApiSuccess) {
        return RepoResult.success(
            data: response.data, message: response.message);
      } else {
        return RepoResult.failure(error: (response as ApiFailure).error);
      }
    } catch (e, s) {
      print(e);
      print(s);
      return RepoResult.failure(error: e.toString());
    }
  }
}
