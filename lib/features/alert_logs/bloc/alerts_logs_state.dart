// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'alerts_logs_bloc.dart';

class AlertsLogsState extends Equatable {
  final FormzStatus initialStatus;
  final FormzStatus listLoadingStatus;
  final FormzStatus deleteLogsStatus;
  final List<AlertLogs> allServerLogs;
  final AlertLogs? lastLog;
  final int? page;
  final int? limit;
  final String? msg;
  const AlertsLogsState(
      {this.allServerLogs = const [],
      this.deleteLogsStatus = FormzStatus.pure,
      this.msg,
      this.page,
      this.limit,
      this.lastLog,
      this.initialStatus = FormzStatus.pure,
      this.listLoadingStatus = FormzStatus.pure});

  @override
  List<Object?> get props => [
        initialStatus,
        listLoadingStatus,
        allServerLogs,
        page,
        limit,
        msg,
        lastLog,
        deleteLogsStatus
      ];

  AlertsLogsState copyWith(
      {FormzStatus? initialStatus,
      FormzStatus? listLoadingStatus,
      FormzStatus? deleteLogsStatus,
      List<AlertLogs>? allServerLogs,
      int? page,
      int? limit,
      String? msg,
      AlertLogs? lastLog}) {
    return AlertsLogsState(
        deleteLogsStatus: deleteLogsStatus ?? FormzStatus.pure,
        msg: msg ?? this.msg,
        initialStatus: initialStatus ?? FormzStatus.pure,
        listLoadingStatus: listLoadingStatus ?? FormzStatus.pure,
        allServerLogs: allServerLogs ?? this.allServerLogs,
        page: page ?? this.page,
        limit: limit ?? this.limit,
        lastLog: lastLog ?? this.lastLog);
  }
}
