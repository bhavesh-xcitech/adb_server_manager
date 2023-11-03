import 'package:adb_server_manager/network_services/api_client.dart';
import 'package:adb_server_manager/network_services/api_result.dart';
import 'package:adb_server_manager/network_services/api_result_service.dart';
import 'package:adb_server_manager/resource/api_endpoints.dart';

class DashBoardRepo {
  Future<ApiResult> dashboardStatus() async {
    ApiResult apiResult = await DioClient().get(
      ApisEndPoints.dashboardStatus,
    );
    return apiResult;
  }

  Future<RepoResult> getDashBoardStatus() async {
    try {
      final response = await commonApiCall(dashboardStatus());
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
