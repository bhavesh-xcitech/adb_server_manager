abstract class Result<T> {
  const Result.empty();
}

class SuccessResult<T> extends Result<T> {
  final T? data;
  final String? message;
  const SuccessResult({this.data, this.message}) : super.empty();
}

class FailureResult<T> extends Result<T> {
  final dynamic error;
  final T? data;
  const FailureResult({required this.error, this.data}) : super.empty();
}

abstract class RepoResult<T> extends Result<T> {
  const RepoResult._() : super.empty();
  const factory RepoResult.success({T data, String? message}) = RepoSuccess<T>;
  const factory RepoResult.failure({required dynamic error, T? data}) =
      RepoFailure<T>;
}

class RepoSuccess<T> extends RepoResult<T> {
  final T? data;
  final String? message;
  const RepoSuccess({this.data, this.message}) : super._();
}

class RepoFailure<T> extends RepoResult<T> {
  final dynamic error;
  final T? data;
  const RepoFailure({required this.error, this.data}) : super._();
}
