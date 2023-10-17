import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<GetAuthenticatedUsers>((event, emit) async {
      try {
        emit(state.copyWith(
            loadUsersFormStatus: FormzStatus.submissionInProgress));
        CollectionReference authenticatedUsers =
            FirebaseFirestore.instance.collection('authenticated_users');
        DocumentReference docRef = authenticatedUsers.doc("users");
        final userDoc = await docRef.get();
        final data = userDoc.data() as Map<String, dynamic>?;
        final tempList = await data?['auth_users'] as List<dynamic>;
        final authUsers = tempList.map((item) {
          return item.toString();
        }).toList();
        emit(state.copyWith(validPhoneNumbers: authUsers));
      } catch (e) {
        emit(
            state.copyWith(loadUsersFormStatus: FormzStatus.submissionFailure));
      }
    });
  }
}
