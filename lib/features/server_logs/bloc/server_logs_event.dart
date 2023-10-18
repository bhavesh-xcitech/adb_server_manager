part of 'server_logs_bloc.dart';

abstract class ServerLogsEvent extends Equatable {
  const ServerLogsEvent();

  @override
  List<Object> get props => [];
}

class GetServerLogs extends ServerLogsEvent {}
class GetMoreServerLogs extends ServerLogsEvent {}
