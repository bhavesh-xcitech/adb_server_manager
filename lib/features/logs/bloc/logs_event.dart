part of 'logs_bloc.dart';

abstract class LogsEvent extends Equatable {
  const LogsEvent();

  @override
  List<Object> get props => [];
}

class SocketDataEvent extends LogsEvent {
  final dynamic data;

  const SocketDataEvent(this.data);
  @override
  List<Object> get props => [data];
}

class GetAllLogs extends LogsEvent {
  final dynamic data;

  const GetAllLogs(this.data);
  @override
  List<Object> get props => [data];
}

class ClearIndividualLogs extends LogsEvent {}
class ClearAllLogs extends LogsEvent {}
