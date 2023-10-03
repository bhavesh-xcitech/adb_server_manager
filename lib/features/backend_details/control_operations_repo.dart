import 'package:adb_server_manager/network_services/api_client.dart';
import 'package:adb_server_manager/network_services/api_result.dart';
import 'package:adb_server_manager/network_services/api_result_service.dart';
import 'package:adb_server_manager/resource/api_endpoints.dart';

class ControlOperationRepo {
  Future<ApiResult> startService(
      {required Map<String, dynamic> payload}) async {
    ApiResult apiResult =
        await DioClient().post(ApisEndPoints.start, data: payload);

    return apiResult;
  }

  Future<RepoResult> start({required Map<String, dynamic> payload}) async {
    try {
      final response = await commonApiCall(startService(payload: payload));

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

// calling stop api
  Future<ApiResult> stopService({required String name}) async {
    ApiResult apiResult =
        await DioClient().post(ApisEndPoints.stop, data: {"name": name});
    return apiResult;
  }

  Future<RepoResult> stop({required String name}) async {
    try {
      final response = await commonApiCall(stopService(name: name));
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

  // calling restart api
  Future<ApiResult> restartService({required String name}) async {
    ApiResult apiResult =
        await DioClient().post(ApisEndPoints.restart, data: {"name": name});
    return apiResult;
  }

  Future<RepoResult> restart({required String name}) async {
    try {
      final response = await commonApiCall(restartService(name: name));
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

  // delate api call
  Future<ApiResult> deleteService({required String name}) async {
    ApiResult apiResult =
        await DioClient().post(ApisEndPoints.delete, data: {"name": name});
    return apiResult;
  }

  Future<RepoResult> delete({required String name}) async {
    try {
      final response = await commonApiCall(deleteService(name: name));
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
