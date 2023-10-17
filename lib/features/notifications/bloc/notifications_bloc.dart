import 'package:adb_server_manager/features/login/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(const NotificationsState()) {
    CollectionReference appUsers =
        FirebaseFirestore.instance.collection('app_users');
    on<AddToFireStore>((event, emit) {
      DocumentReference docRef = appUsers.doc(event.uid ?? "");
      docRef.set(UserData(PhoneNum: event.phone, token: state.token).toMap());
      emit(state.copyWith(firebaseFormzStatus: FormzStatus.submissionSuccess));
    });
    on<GetToken>((event, emit) {
      emit(state.copyWith(token: event.token));
    });
    on<UpdateWhileRefresh>((event, emit) {});
  }
}
