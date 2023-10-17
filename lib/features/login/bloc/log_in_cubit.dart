import 'package:adb_server_manager/features/login/bloc/login_bloc.dart';
import 'package:adb_server_manager/resource/shared_pref.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';

class OtpVerificationCubit extends Cubit<LoginState> {
  OtpVerificationCubit()
      : super(const LoginState(
          loginFormzStatus: FormzStatus.pure,
          getOtpFormzStatus: FormzStatus.pure,
        ));

  Future<void> getOtp(String phoneNumber) async {
    final auth = FirebaseAuth.instance;
    try {
      emit(state.copyWith(getOtpFormzStatus: FormzStatus.submissionInProgress));

      await auth.verifyPhoneNumber(
        verificationCompleted: (phoneAuthCredential) async {
          final authResult = await FirebaseAuth.instance
              .signInWithCredential(phoneAuthCredential);

          final user = authResult.user?.uid;

          if (user != null) {
            print(user);
            // emit(state.copyWith(
            //     getOtpFormzStatus: FormzStatus.submissionSuccess));
          }
        },
        phoneNumber: '+91$phoneNumber',
        codeSent: (verificationId, forceResendingToken) {
          emit(state.copyWith(
              phone: phoneNumber,
              verificationId: verificationId,
              getOtpFormzStatus: FormzStatus.submissionSuccess,
              isOtpSent: true));
        },
        verificationFailed: (error) {
          print("error : $error");

          emit(state.copyWith(
            getOtpFormzStatus: FormzStatus.submissionFailure,
            msg: error.message,
          ));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } catch (error) {
      emit(state.copyWith(
        getOtpFormzStatus: FormzStatus.submissionFailure,
        msg: error.toString(),
      ));
    }
  }

  Future<void> loginWithPhone(
      {required String verificationId, required String code}) async {
    try {
      emit(state.copyWith(
        loginFormzStatus: FormzStatus.submissionInProgress,
      ));
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: code,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        emit(state.copyWith(
          uid: userCredential.user?.uid,
          loginFormzStatus: FormzStatus.submissionSuccess,
        ));
        await SharedPref.setLoggedIn(true);
      } else {
        emit(state.copyWith(
          loginFormzStatus: FormzStatus.submissionFailure,
          msg: "Something went wrong",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        loginFormzStatus: FormzStatus.submissionFailure,
        msg: e.toString(),
      ));
    }
  }
}
