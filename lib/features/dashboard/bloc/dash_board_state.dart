// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dash_board_bloc.dart';

class DashBoardState extends Equatable {
  final List<DashBoardLogs> dashboardList;
  final FormzStatus formStatus;
  final String? msg;
  const DashBoardState({
    this.dashboardList = const [],
    this.formStatus = FormzStatus.pure,
    this.msg,
  });

  @override
  List<Object?> get props => [formStatus,dashboardList, msg];

  DashBoardState copyWith({
    List<DashBoardLogs>? dashboardList,
    FormzStatus? formStatus,
    String? msg,
  }) {
    return DashBoardState(
      dashboardList: dashboardList ?? this.dashboardList,
      formStatus: formStatus ?? FormzStatus.pure,
      msg: msg ?? this.msg,
    );
  }
}
