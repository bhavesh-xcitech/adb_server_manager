import 'package:adb_server_manager/features/login/log_in_repo.dart';
import 'package:adb_server_manager/features/login/user_model.dart';
import 'package:adb_server_manager/network_services/api_result_service.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    LogInReo logInReo = LogInReo();

    on<GetToken>((event, emit) {
      emit(state.copyWith(token: event.token));
    });
    on<AddUserInfo>((event, emit) async {
      if (state.token != null) {
        try {
          emit(state.copyWith(
              addUserFormzStatus: FormzStatus.submissionInProgress));

          RepoResult? response = await logInReo.setUserInfo(
            payload: UserData(
                    phone: event.phone ??
                        FirebaseAuth.instance.currentUser?.phoneNumber,
                    token: Token(
                        token: state.token,
                        notificationEnable: event.isNotificationEnable ?? true))
                .toMap(),
          );

          if (response is RepoSuccess) {
            emit(state.copyWith(
                addUserFormzStatus: FormzStatus.submissionSuccess,
                msg: response.message));
          } else if (response is RepoFailure) {
            emit(state.copyWith(
              addUserFormzStatus: FormzStatus.submissionFailure,
              msg: response.error,
            ));
          }
        } catch (e) {
          emit(state.copyWith(
              addUserFormzStatus: FormzStatus.submissionFailure,
              msg: AppStrings.apiErrorMsg));
        }
      } else {
        emit(state.copyWith(
            addUserFormzStatus: FormzStatus.submissionFailure,
            msg: "Restart your App"));
      }
    });

    on<GetAuthenticatedUsers>((event, emit) async {
      try {
        emit(state.copyWith(
            loadUsersFormStatus: FormzStatus.submissionInProgress));

        RepoResult? response = await logInReo.getAllowedUsers();
        if (response is RepoSuccess) {
          // using coomon usermodel for userinfo and getalloeduser
          List<UserData> responseList =
              (response.data as List<dynamic>).map((item) {
            return UserData.fromMap(item as Map<String, dynamic>);
          }).toList();
          List<String> phoneNumbers = responseList
              .map((userData) => userData.phone.toString())
              .toList();

          emit(
            state.copyWith(
                loadUsersFormStatus: FormzStatus.submissionSuccess,
                validPhoneNumbers: phoneNumbers),
          );
        } else if (response is RepoFailure) {
          emit(
            state.copyWith(
                loadUsersFormStatus: FormzStatus.submissionFailure,
                msg: response.error.toString()),
          );
        }
      } catch (e, s) {
        print(e);
        print(s);
        emit(
          state.copyWith(loadUsersFormStatus: FormzStatus.submissionFailure),
        );
      }
    });
  }
}
