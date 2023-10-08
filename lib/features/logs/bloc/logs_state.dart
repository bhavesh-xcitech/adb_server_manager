// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'logs_bloc.dart';

class LogsState {
  final String? logData;
  final List<String> logDataList;
  LogsState({
    this.logData,
     this.logDataList = const[],
  });

  LogsState copyWith({
    String? logData,
    List<String>? logDataList,
  }) {
    return LogsState(
      logData: logData ?? this.logData,
      logDataList: logDataList ?? this.logDataList,
    );
  }
}
