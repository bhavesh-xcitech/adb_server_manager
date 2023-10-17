// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final String? token;
  final FormzStatus firebaseFormzStatus;

  const NotificationsState({
    this.token,
    this.firebaseFormzStatus = FormzStatus.pure,
  });

  @override
  List<Object?> get props => [token, firebaseFormzStatus];

  NotificationsState copyWith({
    String? token,
    FormzStatus? firebaseFormzStatus,
  }) {
    return NotificationsState(
      token: token ?? this.token,
      firebaseFormzStatus: firebaseFormzStatus ?? FormzStatus.pure,
    );
  }
}
