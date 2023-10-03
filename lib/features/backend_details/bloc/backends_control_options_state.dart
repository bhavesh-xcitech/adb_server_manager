// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'backends_control_options_bloc.dart';

class BackendsControlOptionsState extends Equatable {
  final String? successMsg;
  final String? errorMsg;
  final FormzStatus startStatus;
  final FormzStatus stopStatus;
  final FormzStatus restartStatus;
  final FormzStatus deleteStatus;
  final String? msg;

  const BackendsControlOptionsState({
    this.successMsg,
    this.errorMsg,
    this.startStatus = FormzStatus.pure,
    this.stopStatus = FormzStatus.pure,
    this.restartStatus = FormzStatus.pure,
    this.deleteStatus = FormzStatus.pure,
    this.msg,
  });

  @override
  List<Object?> get props =>
      [successMsg, startStatus, stopStatus, restartStatus, deleteStatus];

  BackendsControlOptionsState copyWith({
    String? successMsg,
    FormzStatus? startStatus,
    String? errorMsg,
    FormzStatus? stopStatus,
    FormzStatus? restartStatus,
    FormzStatus? deleteStatus,
  }) {
    return BackendsControlOptionsState(
      msg: msg ?? msg,
      successMsg: successMsg ?? this.successMsg,
      errorMsg: errorMsg ?? this.errorMsg,
      startStatus: startStatus ?? FormzStatus.pure,
      stopStatus: stopStatus ?? FormzStatus.pure,
      restartStatus: restartStatus ?? FormzStatus.pure,
      deleteStatus: deleteStatus ?? FormzStatus.pure,
    );
  }
}
