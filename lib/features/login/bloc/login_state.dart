// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzStatus getOtpFormzStatus;
  final FormzStatus loginFormzStatus;
  final FormzStatus addUserFormzStatus;
  final FormzStatus loadUsersFormStatus;
  final List<String> validPhoneNumbers;
  final bool isOtpSent;
  final String? verificationId;
  final String? msg;
  final String? uid;
  final String? phone;
  final String? token;

  const LoginState({
    this.token,
    this.getOtpFormzStatus = FormzStatus.pure,
    this.loginFormzStatus = FormzStatus.pure,
    this.loadUsersFormStatus = FormzStatus.pure,
    this.addUserFormzStatus = FormzStatus.pure,
    this.isOtpSent = false,
    this.verificationId,
    this.validPhoneNumbers = const [],
    this.msg,
    this.uid,
    this.phone,
  });

  @override
  List<Object?> get props => [
        getOtpFormzStatus,
        loginFormzStatus,
        verificationId,
        msg,
        isOtpSent,
        phone,
        uid,
        loadUsersFormStatus,
        validPhoneNumbers,
        addUserFormzStatus,
        token
      ];

  LoginState copyWith(
      {FormzStatus? getOtpFormzStatus,
      FormzStatus? loginFormzStatus,
      FormzStatus? loadUsersFormStatus,
      FormzStatus? addUserFormzStatus,
      List<String>? validPhoneNumbers,
      bool? isOtpSent,
      String? verificationId,
      String? msg,
      String? uid,
      String? phone,
      String? token}) {
    return LoginState(
      token: token ?? this.token,
      validPhoneNumbers: validPhoneNumbers ?? this.validPhoneNumbers,
      loadUsersFormStatus: loadUsersFormStatus ?? FormzStatus.pure,
      getOtpFormzStatus: getOtpFormzStatus ?? FormzStatus.pure,
      loginFormzStatus: loginFormzStatus ?? FormzStatus.pure,
      addUserFormzStatus: addUserFormzStatus ?? FormzStatus.pure,
      isOtpSent: isOtpSent ?? this.isOtpSent,
      verificationId: verificationId ?? this.verificationId,
      msg: msg ?? this.msg,
      uid: uid ?? this.uid,
      phone: phone ?? this.phone,
    );
  }
}
