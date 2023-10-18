// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'server_logs_bloc.dart';

class ServerLogsState extends Equatable {
  final FormzStatus initialStatus;
  final FormzStatus listLoadingStatus;
  final List<ServerLogs> allServerLogs;
  final int? page;
  final int? limit;
  final String? msg;
  const ServerLogsState(
      {this.allServerLogs = const [],
      this.msg,
      this.page,
      this.limit,
      this.initialStatus = FormzStatus.pure,
      this.listLoadingStatus = FormzStatus.pure});

  @override
  List<Object?> get props => [initialStatus,listLoadingStatus,allServerLogs, page,limit, msg];

  ServerLogsState copyWith({
    String? msg,
    FormzStatus? initialStatus,
    FormzStatus? listLoadingStatus,
    List<ServerLogs>? allServerLogs,
    int? page,
    int? limit,
  }) {
    return ServerLogsState(
      msg: msg ?? this.msg,
      initialStatus: initialStatus ?? FormzStatus.pure,
      listLoadingStatus: listLoadingStatus ?? FormzStatus.pure,
      allServerLogs: allServerLogs ?? this.allServerLogs,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }
}
