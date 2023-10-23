// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'logs_bloc.dart';

class LogsState extends Equatable {
  final String? logData;
  final List<String> logDataList;
  final List<String> allLogDataList;
  const LogsState({
    this.allLogDataList = const [],
    this.logData,
    this.logDataList = const [],
  });

  LogsState copyWith({
    List<String>? allLogDataList,
    String? logData,
    List<String>? logDataList,
  }) {
    return LogsState(
      logData: logData ?? this.logData,
      logDataList: logDataList ?? this.logDataList,
      allLogDataList: allLogDataList ?? [],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [logData, logDataList,allLogDataList];
}
