part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class GetOtp extends LoginEvent {
  final String? phone;
  const GetOtp({
    this.phone,
  });
}

class Login extends LoginEvent {
  final String? code;
  const Login({
    this.code,
  });
}

class GetAuthenticatedUsers extends LoginEvent {
  const GetAuthenticatedUsers();
}
