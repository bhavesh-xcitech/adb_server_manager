import 'package:adb_server_manager/network_services/api_result_service.dart';

abstract class ApiResult<T> extends Result<T> {
  const ApiResult._() : super.empty();
  const factory ApiResult.success({T data, String? message}) = ApiSuccess<T>;
  const factory ApiResult.failure({required dynamic error, T? data}) =
      ApiFailure<T>;
}

class ApiSuccess<T> extends ApiResult<T> {
  final T? data;
  final String? message;
  const ApiSuccess({this.data, this.message}) : super._();
}

class ApiFailure<T> extends ApiResult<T> {
  final dynamic error;
  final T? data;
  const ApiFailure({required this.error, this.data}) : super._();
}

Future<ApiResult> commonApiCall(Future<ApiResult<dynamic>> apiCall) async {
  try {
    return await apiCall;
  } catch (e, s) {
    print(e);
    print(s);
    return ApiResult.failure(error: Exception('Something went wrong'));
  }
}
