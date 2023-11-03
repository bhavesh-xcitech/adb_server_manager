part of 'dash_board_bloc.dart';

abstract class DashBoardEvent extends Equatable {
  const DashBoardEvent();

  @override
  List<Object> get props => [];
}
class GetDashBoardData extends DashBoardEvent{

}
