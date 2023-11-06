part of 'alerts_logs_bloc.dart';

abstract class AlertsLogsEvent extends Equatable {
  const AlertsLogsEvent();

  @override
  List<Object> get props => [];
}

class GetServerLogs extends AlertsLogsEvent {}
class GetMoreServerLogs extends AlertsLogsEvent {}
class DeleteServerLogs extends AlertsLogsEvent {}
class ResetPage extends AlertsLogsEvent {}
