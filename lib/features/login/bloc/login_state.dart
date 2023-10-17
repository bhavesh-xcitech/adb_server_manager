// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzStatus getOtpFormzStatus;
  final FormzStatus loginFormzStatus;
  final FormzStatus loadUsersFormStatus;
  final List<String> validPhoneNumbers;
  final bool isOtpSent;
  final String? verificationId;
  final String? msg;
  final String? uid;
  final String? phone;

  const LoginState({
    this.getOtpFormzStatus = FormzStatus.pure,
    this.loginFormzStatus = FormzStatus.pure,
    this.loadUsersFormStatus = FormzStatus.pure,
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
        validPhoneNumbers
      ];

  LoginState copyWith({
    FormzStatus? getOtpFormzStatus,
    FormzStatus? loginFormzStatus,
    FormzStatus? loadUsersFormStatus,
    List<String>? validPhoneNumbers,
    bool? isOtpSent,
    String? verificationId,
    String? msg,
    String? uid,
    String? phone,
  }) {
    return LoginState(
      validPhoneNumbers: validPhoneNumbers ?? this.validPhoneNumbers,
      loadUsersFormStatus: loadUsersFormStatus ?? FormzStatus.pure,
      getOtpFormzStatus: getOtpFormzStatus ?? FormzStatus.pure,
      loginFormzStatus: loginFormzStatus ?? FormzStatus.pure,
      isOtpSent: isOtpSent ?? this.isOtpSent,
      verificationId: verificationId ?? this.verificationId,
      msg: msg ?? this.msg,
      uid: uid ?? this.uid,
      phone: phone ?? this.phone,
    );
  }
}
