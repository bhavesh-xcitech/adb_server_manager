// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class AddToFireStore extends NotificationsEvent {
  final String? phone;
  final String? uid;
  const AddToFireStore({
    this.phone,
    this.uid,
  });
}

class UpdateWhileRefresh extends NotificationsEvent {
  final String? token;
  const UpdateWhileRefresh({
    this.token,
  });
}

class GetToken extends NotificationsEvent {
  final String? token;
  const GetToken({
    this.token,
  });
}
