import 'package:adb_server_manager/network_services/api_client.dart';
import 'package:adb_server_manager/network_services/api_result.dart';
import 'package:adb_server_manager/network_services/api_result_service.dart';
import 'package:adb_server_manager/resource/api_endpoints.dart';

class LogInReo {
  Future<ApiResult> userInfo(payload) async {
    ApiResult apiResult = await DioClient().post(
      ApisEndPoints.login,
      data: payload,
    );
    return apiResult;
  }

  Future<RepoResult> setUserInfo({required payload}) async {
    try {
      final response = await commonApiCall(userInfo(payload));

      if (response is ApiSuccess) {
        return RepoResult.success(message: response.message.toString());
      } else {
        return RepoResult.failure(error: (response as ApiFailure).error);
      }
    } catch (_) {
      return RepoResult.failure(error: _.toString());
    }
  }

  Future<ApiResult> allowedUsers() async {
    ApiResult apiResult = await DioClient().get(
      ApisEndPoints.allowedUsers,
    );
    return apiResult;
  }

  Future<RepoResult> getAllowedUsers() async {
    try {
      final response = await commonApiCall(allowedUsers());
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
