// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'backends_control_options_bloc.dart';

abstract class BackendsControlOptionsEvent extends Equatable {
  const BackendsControlOptionsEvent();

  @override
  List<Object> get props => [];
}

class OnClickOfStart extends BackendsControlOptionsEvent {
  final String name;
  const OnClickOfStart({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

class OnClickOfStop extends BackendsControlOptionsEvent {
  final String name;
  const OnClickOfStop({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

class OnClickOfRestart extends BackendsControlOptionsEvent {
  final String name;
  const OnClickOfRestart({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

class OnClickOfDelete extends BackendsControlOptionsEvent {
  final String name;
  const OnClickOfDelete({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}
